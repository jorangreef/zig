const Target = @import("std").Target;

pub const CInt = struct {
    id: Id,
    zig_name: []const u8,
    c_name: []const u8,
    is_signed: bool,

    pub const Id = enum {
        Short,
        UShort,
        Int,
        UInt,
        Long,
        ULong,
        LongLong,
        ULongLong,
    };

    pub const list = [_]CInt{
        CInt{
            .id = Id.Short,
            .zig_name = "c_short",
            .c_name = "short",
            .is_signed = true,
        },
        CInt{
            .id = Id.UShort,
            .zig_name = "c_ushort",
            .c_name = "unsigned short",
            .is_signed = false,
        },
        CInt{
            .id = Id.Int,
            .zig_name = "c_int",
            .c_name = "int",
            .is_signed = true,
        },
        CInt{
            .id = Id.UInt,
            .zig_name = "c_uint",
            .c_name = "unsigned int",
            .is_signed = false,
        },
        CInt{
            .id = Id.Long,
            .zig_name = "c_long",
            .c_name = "long",
            .is_signed = true,
        },
        CInt{
            .id = Id.ULong,
            .zig_name = "c_ulong",
            .c_name = "unsigned long",
            .is_signed = false,
        },
        CInt{
            .id = Id.LongLong,
            .zig_name = "c_longlong",
            .c_name = "long long",
            .is_signed = true,
        },
        CInt{
            .id = Id.ULongLong,
            .zig_name = "c_ulonglong",
            .c_name = "unsigned long long",
            .is_signed = false,
        },
    };

    pub fn sizeInBits(id: CInt.Id, self: Target) u32 {
        const arch = self.getArch();
        switch (self.getOs()) {
            .freestanding => switch (self.getArch()) {
                .msp430 => switch (id) {
                    .Short,
                    .UShort,
                    .Int,
                    .UInt,
                    => return 16,
                    .Long,
                    .ULong,
                    => return 32,
                    .LongLong,
                    .ULongLong,
                    => return 64,
                },
                else => switch (id) {
                    .Short,
                    .UShort,
                    => return 16,
                    .Int,
                    .UInt,
                    => return 32,
                    .Long,
                    .ULong,
                    => return self.getArchPtrBitWidth(),
                    .LongLong,
                    .ULongLong,
                    => return 64,
                },
            },

            .linux,
            .macosx,
            .freebsd,
            .openbsd,
            .zen,
            => switch (id) {
                .Short,
                .UShort,
                => return 16,
                .Int,
                .UInt,
                => return 32,
                .Long,
                .ULong,
                => return self.getArchPtrBitWidth(),
                .LongLong,
                .ULongLong,
                => return 64,
            },

            .windows, .uefi => switch (id) {
                .Short,
                .UShort,
                => return 16,
                .Int,
                .UInt,
                => return 32,
                .Long,
                .ULong,
                .LongLong,
                .ULongLong,
                => return 64,
            },

            .ananas,
            .cloudabi,
            .dragonfly,
            .fuchsia,
            .ios,
            .kfreebsd,
            .lv2,
            .netbsd,
            .solaris,
            .haiku,
            .minix,
            .rtems,
            .nacl,
            .cnk,
            .aix,
            .cuda,
            .nvcl,
            .amdhsa,
            .ps4,
            .elfiamcu,
            .tvos,
            .watchos,
            .mesa3d,
            .contiki,
            .amdpal,
            .hermit,
            .hurd,
            .wasi,
            .emscripten,
            => @panic("TODO specify the C integer type sizes for this OS"),
        }
    }
};
