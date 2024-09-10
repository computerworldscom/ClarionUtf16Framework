Include('c25_ProgramHandlerClass.inc'),Once


c25_WinMesObjectClass           	                   Class(),type,Module('c25_WinMesObjectClass.clw'), Link('c25_WinMesObjectClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
Construct                                                   Procedure()
Destruct                                                    Procedure()

GlobalAllocAddress                                          LONG

C25WinMes                                                   &C25WinMes_TYPE
C25WinMesAddress                                            long
C25WinMesSize                                               long
C25WinMesSizeAddress                                        long
GetC25WinMes                                                Procedure(long _address),long,proc
SetC25WinMes                                                Procedure(),long,proc

BitConverterClass                                           &c25_BitConverterClass
NanoClockClass                                              &c25_NanoSyncClass

ProcessHeapHandle                                          LONG
                                                        End


