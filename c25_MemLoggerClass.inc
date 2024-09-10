    Include('c25_ProgramHandlerClass.inc'),Once

c25MemLoggerClass                Class(),type, Module('c25_MemLoggerClass.clw'), Link('c25_MemLoggerClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
Construct                                           Procedure()
Destruct                                            Procedure()

ThreadHandle                                        Long
ThreadId                                            Long


MappedFileHdr                                       &MappedFileHdr_TYPE()
MappedLogSrvHdr                                     &MappedLogSrvHdr_TYPE()
MappedLogClientHdr                                  &MappedLogClientHdr_TYPE()

StLog                                               &StringTheory()

WM_RequestLogServerWindowHandle                     Long
WM_LogServerWindowHandle                            Long
WM_NewLogToServer                                   Long

!MappedFile                                          Group,Pre(MappedFile)
!Size                                                    Long
!OffsetHi                                                Long
!OffsetLo                                                Long
!SrvWindowHandle                                         Long
!FileNameA                                               String(250)
!FileSizeHi                                              Long
!FileSizeLo                                              Long
!FileHandle                                              Long
!FileOpenError                                           Long
!ThisHeaderHandle                                        Long
!SrvHeaderHandle                                         Long
!SrvHeaderSize                                           Long
!ClientHeaderHandle                                      Long
!ClientHeaderSize                                        Long
!                                                    End
!MappedLogSrvHdr                                     Group,Pre(MappedLogSrvHdr)
!Size                                                    Long
!Handle                                                  Long
!LastUpdateNano                                          Decimal(20,0)
!LastReadOffsetStart                                     Long
!LastReadOffsetEnd                                       Long
!LastReadSize                                            Long
!                                                    End
!MappedLogClientHdr                                  Group,Pre(MappedLogClientHdr)
!Size                                                    Long
!Handle                                                  Long
!LastUpdateNano                                          Decimal(20,0)
!LastWriteOffsetStart                                    Long
!LastWriteOffsetEnd                                      Long
!LastWriteSize                                           Long
!                                                    End



LogStructure                                        Group,Pre(LogStructure)
Length                                                  Long
Line                                                    &String
                                                    End
LogStructureStr                                     &String
LogStructureStrSize                                 Long

ReturnWndProc                                       GROUP,Pre(ReturnWndProc)
Processed                                               BOOL
ReturnVal                                               Long
                                                    End
Activated                                           Bool
AtomWindowClassExA                                  Long
CurrentProcess                                      Long
CurrentThread                                       Long
ExecutionThread                                     Long
GetMessageReturn                                    Long
InputContextHandle                                  Long
Is_WS_OVERLAPPEDWINDOW                              Bool
IsClient                                            Bool
IsMDIClient                                         Bool
IsMDIParent                                         Bool
MDIClientHandle                                     Long
ParentClientWindowHandle                            Long
ParentWindowHandle                                  Long
ProcessHandle                                       Long

TimerIDEvent                                        Long
TitleA                                              &String
WindowHandle                                        Long
WindowClientHandle                                  Long
WindowNameA                                         String(255)
WindowStyle                                         Long
WndClassEx_ClassName                                String(245)
WndProc_Process_Return                              Long
WndProcAddress                                      Long
WndProcClientAddress                                Long
WndProcDispatchArrayMax                             Long
WndProcHookAddress                                  Long
WndProcHookClientAddress                            Long
StartXPos                                           Long
StartYPos                                           Long
StartWidth                                          Long
StartHeight                                         Long
MessageQueueOnly                                    BOOL
IsActive                                            BOOL

CloseMappedFile                                     Procedure(),Long,proc
OpenSharedMemory                                    Procedure(),Long,proc
RegisterWM                                          Procedure(),Long,proc
InitWindow                                          Procedure(<String _name>),String,Proc
OpenWindow                                          Procedure(),String,Proc
WndProc_Process                                     Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam),String,proc

WindowMessage                                       Group(WindowMessage_TYPE),Pre(WindowMessage)
                                                    End
WndClassExA                                         Group(WndClassExA_TYPE),Pre(WndClassExA)
                                                    End
ExtraWindowSpace                                    Group(ExtraWindowSpace_TYPE),Pre(ExtraWindowSpace)
                                                    End
                                                End

