Include('c25_ProgramHandlerClass.inc'),Once

c25_QueueExtenderClass                          Class(),type,Module('c25_QueueExtenderClass.clw'), Link('c25_QueueExtenderClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
Construct                                           Procedure()
Destruct                                            Procedure()

ClassTypeName                                                               cstring(128)
DataTables                                          &DataTables_TYPE
DataTableColumns                                    &DataTableColumns_TYPE

Activated                                           Bool
ApplyQueueStructure                                 Procedure(<*DataTableColumns_TYPE _dataTableColumns>),long,proc
AtomWindowClassExA                                  Long
BitConverter                                        &C25_BitConverterClass
CloseDown                                           Procedure()
CreateDataTable                                     Procedure(),Long
DllBytes                                            &DllBytes_TYPE
DllLoader                                           &C25_DllLoaderClass
ExtraWindowSpace                                    &ExtraWindowSpace_TYPE
fp_CreateQueue                                      LONG,NAME('CreateQueue')
GetFieldLenToString                                 Procedure(long _dataTypeLen),String
GetInt32ToString                                    Procedure(long _Characters),String
InitWindow                                          Procedure(<String _name>, <string _functionName>),String,Proc
IsActive                                            BOOL
LoadMetaLibrary                                     Procedure(),proc,Long
MessageQueueOnly                                    BOOL
Name                                                &String
NanoSync                                            &c25_NanoSyncClass()
OpenWindow                                          Procedure(),String,Proc
Proc_000275_WM_TIMER                                Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam)
Proc_WM_C25CloseApp                                 Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam)
Proc_WM_C25Special                                  Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam)
ProgramHandler                                      &c25_ProgramHandlerClass
QueuesExtend                                        &QueuesExtend_TYPE
RegisterWMs                                         Procedure(),proc,long
Start                                               Procedure()
StartDataSection                                    long
StartDataSectionAddress                             long
StartField001                                       long
StartField001Address                                long
StDllBytes                                          &StringTheory
StDllBytesNew                                       &StringTheory
StDllBytesOld                                       &StringTheory
Stop                                                Procedure()
ThreadHandle                                        Long
ThreadId                                            Long
TimerIDEvent                                        Long
TitleA                                              &String
DataReflection                                      &c25_DataReflectionClass
WindowClientHandle                                  Long
WindowHandle                                        Long
WindowMessage                                       &WindowMessage_TYPE
WindowNameA                                         String(255)
WindowStyle                                         Long
WM_C25CloseApp                                      LONG
WM_C25Special                                       long
WMInputQ                                            &WMInput_TYPE
WndClassEx_ClassName                                String(245)
WndClassExA                                         &WndClassExA_TYPE
WndProc_Process                                     Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam),String,proc
WndProc_Process_Return                              Long
WndProcAddress                                      Long
WndProcClientAddress                                Long
WndProcDispatchArrayMax                             Long
WndProcHookAddress                                  Long
WndProcHookClientAddress                            Long

ReturnWndProc                                       GROUP,Pre(ReturnWndProc)
Processed                                               BOOL
ReturnVal                                               Long
                                                    End
ModuleInfo                                          Group,Pre(ModuleInfo)
BaseOfDll                                               long
SizeOfImage                                             long
EntryPoint                                              long
                                                    End
WndProcDispatchArray                                Group,Pre(WndProcDispatchArray),Dim(256)
DllLibraryHandle                                        Long
ProcAddress                                             Long
ReturnVal                                               Long
Processed                                               Long
                                                    End
                                                End


