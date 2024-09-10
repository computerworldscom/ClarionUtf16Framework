    Include('c25_ProgramHandlerClass.inc'),Once
    Include('c25_ExtendedDataTypes.inc'),Once

c25_ClassStarter                                                     Class(),type,Module('c25_ClassStarter.clw'), Link('c25_ClassStarter.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
Construct                                                                   Procedure()
Destruct                                                                    Procedure()

RegMesStringA                                                               CString(250)
ReturnVal                                                                   LONG
CWM_GetPHPtr                                                                ULONG

Start                                                                       Procedure(<string _info>),long
NanoClockClass                                                              &c25_NanoSyncClass
                                                                        End


