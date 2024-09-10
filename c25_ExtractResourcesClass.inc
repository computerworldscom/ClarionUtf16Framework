Include('c25_ProgramHandlerClass.inc'),Once

ExtractResourcesClass           Class(),type, Module('c25_ExtractResourcesClass.clw'), Link('c25_ExtractResourcesClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)

ThreadInfo                          Group(ThreadInfo_TYPE),Pre(ThreadInfo).
ThreadInfoSourceAddress             Long
SizeThreadInfo                      Long
ThreadExtractHandle                 Long
ThreadIdentity                      Long
ThreadInfoMem                       &String
Installed                           Byte
IsInstalledParam                    Byte
Construct                           Procedure()
Destruct                            Procedure()
Start                               Procedure(<Byte _isInstalled>),String,PROC
StartThread                         Procedure(<Long _threadQId>),String,PROC
                                End

