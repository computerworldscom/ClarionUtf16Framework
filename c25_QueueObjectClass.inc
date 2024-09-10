Include('c25_ProgramHandlerClass.inc'),Once


c25_QueueObjectClass                                                    Class(),type,Module('c25_QueueObjectClass.clw'), Link('c25_QueueObjectClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
Construct                                                                   Procedure()
Destruct                                                                    Procedure()

ClassTypeName                                                               cstring(128)
Id                                                                          Long
CRLF                                                                        String(2)
Name                                                                        cstring(128)
TypeName                                                                    cstring(128)
IsGlobal                                                                    bool

ClarionFields                                                               &ClarionFields_TYPE()
Q                                                                           &Queue
st1                                                                         &StringTheory()



                                End


