    Include('errors.clw'),Once
    Include('c25_DataTypes.clw'),Once
    Include('c25_Sqlite34Class.inc'), once
    Include('c25_NanoSyncClass.inc'), once
    Include('c25_WinApi32Class.inc'), once
    Include('StringTheory.inc'), once
    Include('C25_DUMMY.CLW'), once
    Include('c25_TrueReflectionClass.inc'), once
    Include('c25_WorkerThreadClass.inc'), once
    Include('C25_DUMMY.CLW'),once

WinHandlesArray                         Long,dim(2048)
!GWL_USERDATA                            EQUATE(-21)

CurrentWorkerThreadInfo                 Group(WorkerThreadInfo_TYPE),Pre(CurrentWorkerThreadInfo)
                                        End

c25WorkerThreadsClass                   Class(),type, Module('c25_WorkerThreadsClass.clw'), Link('c25_WorkerThreadsClass.clw',1),DLL(0)
Construct                                   Procedure()
Destruct                                    Procedure()
GetRealThreadHandle                         Procedure(),Long
GetSelfAddress                              Procedure(),Long
Init                                        Procedure(Long _paramA),Long,proc
InitReady                                    Byte
NanoSync                                    &NanoSyncClass
PoweredUp                                   Byte
SelfAddress                                 Long
Sqlite34                                    &Sqlite34Class
st1                                         &StringTheory
WinApi                                      &WinApi32Class
StartWorkerThread                           Procedure(Long _index,<String _name>),String,proc
WorkerThreadInfoArray                       Group(WorkerThreadInfo_TYPE),Pre(WorkerThreadInfoArray),dim(2048)
                                            End
WorkerThreadInfoArrayMax                    Long
WorkerThreadInfoIndex                       Long
WinHandle                                   Long
CreateNewWorkerThread                       Procedure(<String _name>),Long,proc
GetWorkerWinHandle                          Procedure(<Long _index>,<String _name>),Long,proc
GetWorkerInstancePtr                        Procedure(<Long _index>,<String _name>),Long,proc
                                        End

