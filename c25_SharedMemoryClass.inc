Include('c25_ProgramHandlerClass.inc'),Once

c25SharedMemoryClass                            Class(),type, Module('c25_SharedMemoryClass.clw'), Link('c25_SharedMemoryClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)

Construct                                           Procedure()
Destruct                                            Procedure()
ProgramHandler                                      &c25ProgramHandlerClass()
BitConverter                                        &c25BitConverterClass()
NanoSync                                            &c25NanoSyncClass()
CreateMemoryMappedFile                              Procedure(string _globalFileNameA, long _sizeLo, long _sizeHi, <INT64 _sizeInt64>),Long,Proc
                                                End

