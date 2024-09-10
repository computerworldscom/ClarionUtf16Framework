Include('c25_DataTypes.clw'),Once
Include('StringTheory.inc'), once

c25AppRootClass                 Class(),type, Module('c25_AppRootClass.clw'), Link('c25_AppRootClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
Construct                           Procedure()
Destruct                            Procedure(),virtual
SelfAddress                         Long
GetSelfAddress                      Procedure(),Long
Properties                          &c25AppObj_TYPE
c25AppObjects                       &c25AppObjects_TYPE
Populatec25AppObjects               Procedure(),Long,proc
WorkerThreads_InstancePtr           Long
DatabaseHandler_InstancePtr         Long
RenderEngine_InstancePtr            Long
AppMemoryConnHandle                 Long
AppMemoryReady                      Byte
GlobalMemPtr                        Long
GlobalMem                            &GlobalMem_TYPE
                                End

