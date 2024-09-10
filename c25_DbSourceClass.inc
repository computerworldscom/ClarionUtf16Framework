    Include('errors.clw'),Once
    Include('c25_DataTypes.clw'),Once
    Include('c25_NanoSyncClass.inc'), once
    Include('c25_WinApi32Class.inc'), once
    Include('c25_DatabaseHandlerClass.inc'), once
    Include('c25_DbAdapterClass.inc'), once
    Include('StringTheory.inc'), once
    Include('C25_DUMMY.CLW'), once
    Include('c25_Sqlite34Class.inc'), once
    Include('c25_TrueReflectionClass.inc'), once

c25DbSourceClass               Class(),type, Module('c25_DbSourceClass.clw'), Link('c25_DbSourceClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
Construct                       Procedure()
Destruct                        Procedure(),virtual
SelfAddress                     Long
GetSelfAddress                  Procedure(),Long
NanoSync                        &NanoSyncClass()
WinApi32                        &WinApi32Class()
DatabaseHandlerParent           &DatabaseHandlerClass()
Source_Instance                 &c25DbSourceClass()
Source_InstancePtr              Long
Databases                       &c25DbDatabases_TYPE()
SourceRecord                    Group(c25DbSources_TYPE),Pre(SourceRecord)
                                End
Sqlite34ConnHandle              Long
Sqlite34                        &Sqlite34Class
Sqlite34Ptr                     Long
Sqlite34Connect                 Procedure(<String _c25DbDatabases>,<String _connStringOrUriUtf8>),Long,proc
QueueDataToSqliteTableEntity    Procedure(<String _c25DbDatabases>,<String _connStringOrUriUtf8>,*QUEUE _queue, String _tableName, <Byte _skipUpdateId>, <Byte _keepOpen>, <Long _saveQueueToSqlite3Flags>),Long,proc
ExecuteScalar                   Procedure(<String _c25DbDatabases>,<String _connStringOrUriUtf8>, String _tableName, String _sql, <Long _targetPtr>,<*c25DbSqlObjectReturn_TYPE _c25DbSqlObjectReturn>),Long,proc
Exec                            Procedure(<String _c25DbDatabases>,<String _connStringOrUriUtf8>, String _tableName, String _sql, <Long _targetPtr>,<*c25DbSqlObjectReturn_TYPE _c25DbSqlObjectReturn>),Long,proc
                            End

