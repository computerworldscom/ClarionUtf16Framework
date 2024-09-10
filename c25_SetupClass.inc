!    Include('c25_ExtractResourcesClass.inc'),Once
!    Include('c25_NanoSyncClass.inc'),Once
!    Include('c25_WinApi32Class.inc'),Once
!    Include('ERRORS.CLW'),Once
!    Include('jFiles.inc'),Once
    Include('c25_ProgramHandlerClass.inc'),Once
    Include('c25_ExtendedDataTypes.inc'),Once

c25_SetupClass                                                              Class(),type, Module('c25_SetupClass.clw'), Link('c25_SetupClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)

Construct                                                                       Procedure()
Destruct                                                                        Procedure()

ExtractResourcesThreadClass                                                     &c25_ExtractResourcesThreadClass
hModule                                                                         LONG
NanoSyncClass                                                                   &c25_NanoSyncClass
ProgramHandlerClass                                                             &C25_ProgramHandlerClass
RunningIsInstalled                                                              byte
Start                                                                           Procedure(<byte _skipCheckInstalled>),proc,long
WinApiClass                                                                     &c25_WinApiClass
stLog                                                                           &StringTheory
StLogFileName                                                                   cstring(1024)
BitConverterClass                                                               &c25_BitConverterClass
AWEClass                                                                        &c25_AWEClass

                                                                         End


