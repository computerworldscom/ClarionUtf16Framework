Include('c25_ProgramHandlerClass.inc'),Once

c25_TabClass                                                            Class(),Type, Module('c25_TabClass.clw'), Link('c25_TabClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
Construct                                                                   Procedure()
Destruct                                                                    Procedure()

ClassTypeName                                                               cstring(128)
ProgramHandlerClass                                                         &c25_ProgramHandlerClass()
MessageOnlyWindowClass                                                      &c25_MessageOnlyWindowClass

stLog                                                                       &StringTheory
stLogFileName                                                               cstring(512)

Id                                                                          LONG
Order                                                                       Long
Name                                                                        &STRING
Active                                                                      BOOL
PaintingDone                                                                BOOL

TabHeaderDisplayOrdinalRow                                                  Long
TabHeaderDisplayOrdinalColumn                                               Long

TabHeaderOffsetX                                                            Long
TabHeaderOffsetY                                                            Long

TabHeaderLabelWidth                                                         Long
TabHeaderIconWidth                                                          Long
TabHeaderIconHeight                                                         Long
TabHeaderWidth                                                              Long
TabHeaderMaxWidth                                                           Long
TabHeaderTextW                                                              &string


BitConverter                                                                &c25_BitConverterClass
TabRenderEngineClass                                                        &c25_TabRenderEngineClass
ControlsFactoryClass                                                        &c25_ControlsFactoryClass
SQLiteAsyncConnections                                                      &SQLiteAsyncConnection_TYPE
NanoSync                                                                    &c25_NanoSyncClass
ResizeTimeout                                                               Decimal(20,0)
PaintTimeout                                                                Decimal(20,0)
NavigationTree                                                              &NavigationTree_TYPE ! move out
ControlRect                                                                 &WindowRect_TYPE

ProcessMouseEvent                                                           Procedure(),long,proc
CreateSqliteDatabases                                                       Procedure(),long,PROC
!Init                                                                        Procedure(long _id, <*Tab_TYPE _tab>),long,PROC
Init                                                                        Procedure(),long,PROC
LoadControls                                                                Procedure(),long,PROC
PopulateControls                                                            Procedure(),long,PROC
WndProc_Process                                                             Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam, bool Processed, *long ReturnVal, <*bool PostProcess>)
Resize                                                                      Procedure(),long,PROC
Paint                                                                       Procedure(),long,PROC
                                                                        End


