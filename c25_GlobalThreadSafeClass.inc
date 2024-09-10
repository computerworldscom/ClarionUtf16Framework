    Include('errors.clw'),Once
    Include('c25_DataTypes.clw'),Once
    Include('c25_DbAdapterClass.inc'), once
    Include('c25_DbSourceClass.inc'), once
    Include('c25_DbDatabaseClass.inc'), once
    Include('c25_DbTableClass.inc'), once
    Include('c25_DbTableColumnClass.inc'), once
    Include('c25_NanoSyncClass.inc'), once
    Include('c25_WinApi32Class.inc'), once
    Include('StringTheory.inc'), once
    Include('C25_DUMMY.CLW'), once
    Include('c25_TrueReflectionClass.inc'), once

c25GlobalThreadSafeClass                   Class(),type, Module('c25_GlobalThreadSafeClass.clw'), Link('c25_GlobalThreadSafeClass.clw',1),DLL(0)
Construct                                   Procedure()
Destruct                                    Procedure()
st1                                         &StringTheory
SelfAddress                                 Long
Init                                        Procedure(Long _appRootPtr),Long,proc
InitReady                                    Byte
GetSelfAddress                              Procedure(),Long
NanoSync                                    &NanoSyncClass
MessagePump                                 Procedure(),Long,proc
MessagePumpOld                              Procedure(),Long,proc
Adapter_Instance                            &c25DbAdapterClass
Adapters                                    &c25DbAdapters_TYPE
Databases                                   &c25DbDatabases_TYPE
Sources                                     &c25DbSources_TYPE
Sqlite34                                    &Sqlite34Class
PoweredUp                                   Byte
Hardware_Instance                           &HardwareClass
GetRealThreadHandle                         Procedure(),Long
WinApi                                      &WinApi32Class
c25MessagesQ                                &c25Messages_TYPE
c25MessagesQBuffer                          &c25Messages_TYPE
PostMessageOld                              Procedure(<c25Messages_TYPE _c25MessagesQ>,<ULong _mes>,<ULong _wParam>,<Long _lParam>,<String _messageStr>),Long,proc
c25MessagesQBufferLOCK                      Byte
c25MessagesQProcessedCount                  Long
c25MessagesQBufferProcessedCount            Long

c25DatabaseHandler_InstancePtr              Long
c25DatabaseHandler_Instance                 &c25DatabaseHandlerClass
AppMemConnHandle                            Long
                                        End

