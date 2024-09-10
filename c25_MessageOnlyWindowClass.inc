Include('c25_ProgramHandlerClass.inc'),Once

c25_MessageOnlyWindowClass                                              Class(),Type, Module('c25_MessageOnlyWindowClass.clw'), Link('c25_MessageOnlyWindowClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)

Construct                                                                   Procedure()
Destruct                                                                    Procedure()

ClassTypeName                                                               cstring(128)
Activated                                                                   Bool
AtomWindowClassExA                                                          Long
CurrentProcess                                                              Long
CurrentThread                                                               Long
ExecutionThread                                                             Long
InvokerClassPtr                                                             Long
IsActive                                                                    BOOL
ParentClassPtr                                                              Long
ParentClassTypeEnum                                                         Long
ProcessHandle                                                               Long
ThreadHandle                                                                Long
ThreadId                                                                    Long
TimerElapse                                                                 Long
TimerIDEvent                                                                Long
WindowClientHandle                                                          Long
WindowHandle                                                                Long
WindowNameA                                                                 String(255)
WndClassEx_ClassName                                                        String(245)
WndProc_Process_Return                                                      Long
WndProcAddress                                                              Long
WndProcHookAddress                                                          Long
WndProcHookClientAddress                                                    Long

ControlClass &c25_ControlClass
ControlRenderClass &c25_ControlRenderClass
TabClass &c25_TabClass

TreeViewClass                                                               &c25_TreeViewClass
TabRenderEngineClass                                                        &c25_TabRenderEngineClass
BitConverter                                                                &c25_BitConverterClass
DataTableClass                                                              &c25_DataTableClass
InvokerClass                                                                &c25_InvokerDummyClass
NanoSync                                                                    &c25_NanoSyncClass
ProgramHandlerClass                                                         &c25_ProgramHandlerClass
QueueCreateClass                                                            &c25_QueueCreateClass
WinApi                                                                      &c25WinApiClass
ExtraWindowSpace                                                            &ExtraWindowSpace_TYPE
TitleA                                                                      &String
WindowMessage                                                               &WindowMessage_TYPE
WndClassExA                                                                 &WndClassExA_TYPE

InitWindow                                                                  Procedure(<long _parentClassTypeEnum> , <long _parentClassPtr>),String,Proc
OpenWindow                                                                  Procedure(),String,Proc
PreDestructWindow                                                           Procedure(),proc,long
Proc_000000_CWM_CloseApp                                                    Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam)
Proc_000016_WM_CLOSE                                                        Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam)
Proc_000275_WM_TIMER                                                        Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam)
WndProc_Process                                                             Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam),String,proc


ReturnWndProc                                       		                Group,Pre(ReturnWndProc)
Processed                                               		                BOOL
ReturnVal                                               		                Long
                                                    		                End
                                                		                End


