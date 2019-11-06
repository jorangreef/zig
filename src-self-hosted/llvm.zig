const builtin = @import("builtin");
const c = @import("c.zig");
const std = @import("std");
const assert = std.debug.assert;

// we wrap the c module for 3 reasons:
// 1. to avoid accidentally calling the non-thread-safe functions
// 2. patch up some of the types to remove nullability
// 3. some functions have been augmented by zig_llvm.cpp to be more powerful,
//    such as ZigLLVMTargetMachineEmitToFile

pub const AttributeIndex = c_uint;
pub const Bool = c_int;

pub const Builder = c.LLVMBuilderRef.Child.Child;
pub const Context = c.LLVMContextRef.Child.Child;
pub const Module = c.LLVMModuleRef.Child.Child;
pub const Value = c.LLVMValueRef.Child.Child;
pub const Type = c.LLVMTypeRef.Child.Child;
pub const BasicBlock = c.LLVMBasicBlockRef.Child.Child;
pub const Attribute = c.LLVMAttributeRef.Child.Child;
pub const Target = c.LLVMTargetRef.Child.Child;
pub const TargetMachine = c.LLVMTargetMachineRef.Child.Child;
pub const TargetData = c.LLVMTargetDataRef.Child.Child;
pub const DIBuilder = c.ZigLLVMDIBuilder;
pub const DIFile = c.ZigLLVMDIFile;
pub const DICompileUnit = c.ZigLLVMDICompileUnit;

pub const ABIAlignmentOfType = c.LLVMABIAlignmentOfType;
pub const AddAttributeAtIndex = c.LLVMAddAttributeAtIndex;
pub const AddModuleCodeViewFlag = c.ZigLLVMAddModuleCodeViewFlag;
pub const AddModuleDebugInfoFlag = c.ZigLLVMAddModuleDebugInfoFlag;
pub const ClearCurrentDebugLocation = c.ZigLLVMClearCurrentDebugLocation;
pub const ConstAllOnes = c.LLVMConstAllOnes;
pub const ConstArray = c.LLVMConstArray;
pub const ConstBitCast = c.LLVMConstBitCast;
pub const ConstIntOfArbitraryPrecision = c.LLVMConstIntOfArbitraryPrecision;
pub const ConstNeg = c.LLVMConstNeg;
pub const ConstStructInContext = c.LLVMConstStructInContext;
pub const DIBuilderFinalize = c.ZigLLVMDIBuilderFinalize;
pub const DisposeBuilder = c.LLVMDisposeBuilder;
pub const DisposeDIBuilder = c.ZigLLVMDisposeDIBuilder;
pub const DisposeMessage = c.LLVMDisposeMessage;
pub const DisposeModule = c.LLVMDisposeModule;
pub const DisposeTargetData = c.LLVMDisposeTargetData;
pub const DisposeTargetMachine = c.LLVMDisposeTargetMachine;
pub const DoubleTypeInContext = c.LLVMDoubleTypeInContext;
pub const DumpModule = c.LLVMDumpModule;
pub const FP128TypeInContext = c.LLVMFP128TypeInContext;
pub const FloatTypeInContext = c.LLVMFloatTypeInContext;
pub const GetEnumAttributeKindForName = c.LLVMGetEnumAttributeKindForName;
pub const GetMDKindIDInContext = c.LLVMGetMDKindIDInContext;
pub const GetUndef = c.LLVMGetUndef;
pub const HalfTypeInContext = c.LLVMHalfTypeInContext;
pub const InitializeAllAsmParsers = c.LLVMInitializeAllAsmParsers;
pub const InitializeAllAsmPrinters = c.LLVMInitializeAllAsmPrinters;
pub const InitializeAllTargetInfos = c.LLVMInitializeAllTargetInfos;
pub const InitializeAllTargetMCs = c.LLVMInitializeAllTargetMCs;
pub const InitializeAllTargets = c.LLVMInitializeAllTargets;
pub const InsertBasicBlockInContext = c.LLVMInsertBasicBlockInContext;
pub const Int128TypeInContext = c.LLVMInt128TypeInContext;
pub const Int16TypeInContext = c.LLVMInt16TypeInContext;
pub const Int1TypeInContext = c.LLVMInt1TypeInContext;
pub const Int32TypeInContext = c.LLVMInt32TypeInContext;
pub const Int64TypeInContext = c.LLVMInt64TypeInContext;
pub const Int8TypeInContext = c.LLVMInt8TypeInContext;
pub const IntPtrTypeForASInContext = c.LLVMIntPtrTypeForASInContext;
pub const IntPtrTypeInContext = c.LLVMIntPtrTypeInContext;
pub const LabelTypeInContext = c.LLVMLabelTypeInContext;
pub const MDNodeInContext = c.LLVMMDNodeInContext;
pub const MDStringInContext = c.LLVMMDStringInContext;
pub const MetadataTypeInContext = c.LLVMMetadataTypeInContext;
pub const PPCFP128TypeInContext = c.LLVMPPCFP128TypeInContext;
pub const SetAlignment = c.LLVMSetAlignment;
pub const SetDataLayout = c.LLVMSetDataLayout;
pub const SetGlobalConstant = c.LLVMSetGlobalConstant;
pub const SetInitializer = c.LLVMSetInitializer;
pub const SetLinkage = c.LLVMSetLinkage;
pub const SetTarget = c.LLVMSetTarget;
pub const SetUnnamedAddr = c.LLVMSetUnnamedAddr;
pub const SetVolatile = c.LLVMSetVolatile;
pub const StructTypeInContext = c.LLVMStructTypeInContext;
pub const TokenTypeInContext = c.LLVMTokenTypeInContext;
pub const X86FP80TypeInContext = c.LLVMX86FP80TypeInContext;
pub const X86MMXTypeInContext = c.LLVMX86MMXTypeInContext;

pub const AddGlobal = LLVMAddGlobal;
extern fn LLVMAddGlobal(M: *Module, Ty: *Type, Name: [*]const u8) ?*Value;

pub const ConstStringInContext = LLVMConstStringInContext;
extern fn LLVMConstStringInContext(C: *Context, Str: [*]const u8, Length: c_uint, DontNullTerminate: Bool) ?*Value;

pub const ConstInt = LLVMConstInt;
extern fn LLVMConstInt(IntTy: *Type, N: c_ulonglong, SignExtend: Bool) ?*Value;

pub const BuildLoad = LLVMBuildLoad;
extern fn LLVMBuildLoad(arg0: *Builder, PointerVal: *Value, Name: [*]const u8) ?*Value;

pub const ConstNull = LLVMConstNull;
extern fn LLVMConstNull(Ty: *Type) ?*Value;

pub const CreateStringAttribute = LLVMCreateStringAttribute;
extern fn LLVMCreateStringAttribute(
    C: *Context,
    K: [*]const u8,
    KLength: c_uint,
    V: [*]const u8,
    VLength: c_uint,
) ?*Attribute;

pub const CreateEnumAttribute = LLVMCreateEnumAttribute;
extern fn LLVMCreateEnumAttribute(C: *Context, KindID: c_uint, Val: u64) ?*Attribute;

pub const AddFunction = LLVMAddFunction;
extern fn LLVMAddFunction(M: *Module, Name: [*]const u8, FunctionTy: *Type) ?*Value;

pub const CreateCompileUnit = ZigLLVMCreateCompileUnit;
extern fn ZigLLVMCreateCompileUnit(
    dibuilder: *DIBuilder,
    lang: c_uint,
    difile: *DIFile,
    producer: [*]const u8,
    is_optimized: bool,
    flags: [*]const u8,
    runtime_version: c_uint,
    split_name: [*]const u8,
    dwo_id: u64,
    emit_debug_info: bool,
) ?*DICompileUnit;

pub const CreateFile = ZigLLVMCreateFile;
extern fn ZigLLVMCreateFile(dibuilder: *DIBuilder, filename: [*]const u8, directory: [*]const u8) ?*DIFile;

pub const ArrayType = LLVMArrayType;
extern fn LLVMArrayType(ElementType: *Type, ElementCount: c_uint) ?*Type;

pub const CreateDIBuilder = ZigLLVMCreateDIBuilder;
extern fn ZigLLVMCreateDIBuilder(module: *Module, allow_unresolved: bool) ?*DIBuilder;

pub const PointerType = LLVMPointerType;
extern fn LLVMPointerType(ElementType: *Type, AddressSpace: c_uint) ?*Type;

pub const CreateBuilderInContext = LLVMCreateBuilderInContext;
extern fn LLVMCreateBuilderInContext(C: *Context) ?*Builder;

pub const IntTypeInContext = LLVMIntTypeInContext;
extern fn LLVMIntTypeInContext(C: *Context, NumBits: c_uint) ?*Type;

pub const ModuleCreateWithNameInContext = LLVMModuleCreateWithNameInContext;
extern fn LLVMModuleCreateWithNameInContext(ModuleID: [*]const u8, C: *Context) ?*Module;

pub const VoidTypeInContext = LLVMVoidTypeInContext;
extern fn LLVMVoidTypeInContext(C: *Context) ?*Type;

pub const ContextCreate = LLVMContextCreate;
extern fn LLVMContextCreate() ?*Context;

pub const ContextDispose = LLVMContextDispose;
extern fn LLVMContextDispose(C: *Context) void;

pub const CopyStringRepOfTargetData = LLVMCopyStringRepOfTargetData;
extern fn LLVMCopyStringRepOfTargetData(TD: *TargetData) ?[*]u8;

pub const CreateTargetDataLayout = LLVMCreateTargetDataLayout;
extern fn LLVMCreateTargetDataLayout(T: *TargetMachine) ?*TargetData;

pub const CreateTargetMachine = ZigLLVMCreateTargetMachine;
extern fn ZigLLVMCreateTargetMachine(
    T: *Target,
    Triple: [*]const u8,
    CPU: [*]const u8,
    Features: [*]const u8,
    Level: CodeGenOptLevel,
    Reloc: RelocMode,
    CodeModel: CodeModel,
    function_sections: bool,
) ?*TargetMachine;

pub const GetHostCPUName = LLVMGetHostCPUName;
extern fn LLVMGetHostCPUName() ?[*]u8;

pub const GetNativeFeatures = ZigLLVMGetNativeFeatures;
extern fn ZigLLVMGetNativeFeatures() ?[*]u8;

pub const GetElementType = LLVMGetElementType;
extern fn LLVMGetElementType(Ty: *Type) *Type;

pub const TypeOf = LLVMTypeOf;
extern fn LLVMTypeOf(Val: *Value) *Type;

pub const BuildStore = LLVMBuildStore;
extern fn LLVMBuildStore(arg0: *Builder, Val: *Value, Ptr: *Value) ?*Value;

pub const BuildAlloca = LLVMBuildAlloca;
extern fn LLVMBuildAlloca(arg0: *Builder, Ty: *Type, Name: ?[*]const u8) ?*Value;

pub const ConstInBoundsGEP = LLVMConstInBoundsGEP;
pub extern fn LLVMConstInBoundsGEP(ConstantVal: *Value, ConstantIndices: [*]*Value, NumIndices: c_uint) ?*Value;

pub const GetTargetFromTriple = LLVMGetTargetFromTriple;
extern fn LLVMGetTargetFromTriple(Triple: [*]const u8, T: **Target, ErrorMessage: ?*[*]u8) Bool;

pub const VerifyModule = LLVMVerifyModule;
extern fn LLVMVerifyModule(M: *Module, Action: VerifierFailureAction, OutMessage: *?[*]u8) Bool;

pub const GetInsertBlock = LLVMGetInsertBlock;
extern fn LLVMGetInsertBlock(Builder: *Builder) *BasicBlock;

pub const FunctionType = LLVMFunctionType;
extern fn LLVMFunctionType(
    ReturnType: *Type,
    ParamTypes: [*]*Type,
    ParamCount: c_uint,
    IsVarArg: Bool,
) ?*Type;

pub const GetParam = LLVMGetParam;
extern fn LLVMGetParam(Fn: *Value, Index: c_uint) *Value;

pub const AppendBasicBlockInContext = LLVMAppendBasicBlockInContext;
extern fn LLVMAppendBasicBlockInContext(C: *Context, Fn: *Value, Name: [*]const u8) ?*BasicBlock;

pub const PositionBuilderAtEnd = LLVMPositionBuilderAtEnd;
extern fn LLVMPositionBuilderAtEnd(Builder: *Builder, Block: *BasicBlock) void;

pub const AbortProcessAction = VerifierFailureAction.LLVMAbortProcessAction;
pub const PrintMessageAction = VerifierFailureAction.LLVMPrintMessageAction;
pub const ReturnStatusAction = VerifierFailureAction.LLVMReturnStatusAction;
pub const VerifierFailureAction = c.LLVMVerifierFailureAction;

pub const CodeGenLevelNone = c.LLVMCodeGenOptLevel.LLVMCodeGenLevelNone;
pub const CodeGenLevelLess = c.LLVMCodeGenOptLevel.LLVMCodeGenLevelLess;
pub const CodeGenLevelDefault = c.LLVMCodeGenOptLevel.LLVMCodeGenLevelDefault;
pub const CodeGenLevelAggressive = c.LLVMCodeGenOptLevel.LLVMCodeGenLevelAggressive;
pub const CodeGenOptLevel = c.LLVMCodeGenOptLevel;

pub const RelocDefault = c.LLVMRelocMode.LLVMRelocDefault;
pub const RelocStatic = c.LLVMRelocMode.LLVMRelocStatic;
pub const RelocPIC = c.LLVMRelocMode.LLVMRelocPIC;
pub const RelocDynamicNoPic = c.LLVMRelocMode.LLVMRelocDynamicNoPic;
pub const RelocMode = c.LLVMRelocMode;

pub const CodeModelDefault = c.LLVMCodeModel.LLVMCodeModelDefault;
pub const CodeModelJITDefault = c.LLVMCodeModel.LLVMCodeModelJITDefault;
pub const CodeModelSmall = c.LLVMCodeModel.LLVMCodeModelSmall;
pub const CodeModelKernel = c.LLVMCodeModel.LLVMCodeModelKernel;
pub const CodeModelMedium = c.LLVMCodeModel.LLVMCodeModelMedium;
pub const CodeModelLarge = c.LLVMCodeModel.LLVMCodeModelLarge;
pub const CodeModel = c.LLVMCodeModel;

pub const EmitAssembly = EmitOutputType.ZigLLVM_EmitAssembly;
pub const EmitBinary = EmitOutputType.ZigLLVM_EmitBinary;
pub const EmitLLVMIr = EmitOutputType.ZigLLVM_EmitLLVMIr;
pub const EmitOutputType = c.ZigLLVM_EmitOutputType;

pub const CCallConv = c.LLVMCCallConv;
pub const FastCallConv = c.LLVMFastCallConv;
pub const ColdCallConv = c.LLVMColdCallConv;
pub const WebKitJSCallConv = c.LLVMWebKitJSCallConv;
pub const AnyRegCallConv = c.LLVMAnyRegCallConv;
pub const X86StdcallCallConv = c.LLVMX86StdcallCallConv;
pub const X86FastcallCallConv = c.LLVMX86FastcallCallConv;
pub const CallConv = c.LLVMCallConv;

pub const FnInline = extern enum {
    Auto,
    Always,
    Never,
};

fn removeNullability(comptime T: type) type {
    comptime assert(@typeInfo(T).Pointer.size == @import("builtin").TypeInfo.Pointer.Size.C);
    return *T.Child;
}

pub const BuildRet = LLVMBuildRet;
extern fn LLVMBuildRet(arg0: *Builder, V: ?*Value) ?*Value;

pub const TargetMachineEmitToFile = ZigLLVMTargetMachineEmitToFile;
extern fn ZigLLVMTargetMachineEmitToFile(
    targ_machine_ref: *TargetMachine,
    module_ref: *Module,
    filename: [*]const u8,
    output_type: EmitOutputType,
    error_message: *[*]u8,
    is_debug: bool,
    is_small: bool,
) bool;

pub const BuildCall = ZigLLVMBuildCall;
extern fn ZigLLVMBuildCall(B: *Builder, Fn: *Value, Args: [*]*Value, NumArgs: c_uint, CC: c_uint, fn_inline: FnInline, Name: [*]const u8) ?*Value;

pub const PrivateLinkage = c.LLVMLinkage.LLVMPrivateLinkage;

pub fn targetFromTriple(triple: std.Buffer) !*Target {
    var result: *Target = undefined;
    var err_msg: [*]u8 = undefined;
    if (GetTargetFromTriple(triple.ptr(), &result, &err_msg) != 0) {
        std.debug.warn("triple: {s} error: {s}\n", triple.ptr(), err_msg);
        return error.UnsupportedTarget;
    }
    return result;
}

pub fn initializeAllTargets() void {
    InitializeAllTargets();
    InitializeAllTargetInfos();
    InitializeAllTargetMCs();
    InitializeAllAsmPrinters();
    InitializeAllAsmParsers();
}

pub fn getTriple(allocator: *std.mem.Allocator, self: Target) !std.Buffer {
    var result = try std.Buffer.initSize(allocator, 0);
    errdefer result.deinit();

    // LLVM WebAssembly output support requires the target to be activated at
    // build type with -DCMAKE_LLVM_EXPIERMENTAL_TARGETS_TO_BUILD=WebAssembly.
    //
    // LLVM determines the output format based on the abi suffix,
    // defaulting to an object based on the architecture. The default format in
    // LLVM 6 sets the wasm arch output incorrectly to ELF. We need to
    // explicitly set this ourself in order for it to work.
    //
    // This is fixed in LLVM 7 and you will be able to get wasm output by
    // using the target triple `wasm32-unknown-unknown-unknown`.
    const env_name = if (self.isWasm()) "wasm" else @tagName(self.getAbi());

    var out = &std.io.BufferOutStream.init(&result).stream;
    try out.print("{}-unknown-{}-{}", @tagName(self.getArch()), @tagName(self.getOs()), env_name);

    return result;
}