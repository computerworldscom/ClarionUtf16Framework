    Include('c25_DataTypes.clw'),Once
    Include('c25_DbAdapterClass.inc'), once
    Include('c25_DbDatabaseClass.inc'), once
    Include('c25_DbSourceClass.inc'), once
    Include('c25_DbTableClass.inc'), once
    Include('c25_DbTableColumnClass.inc'), once
    Include('C25_DUMMY.CLW'), once
    Include('C25_DUMMY.CLW'), once
    Include('c25_Equates_Itemized.clw'), once
    Include('c25_NanoSyncClass.inc'), once
    Include('c25_TrueReflectionClass.inc'), once
    Include('Reflection.inc'), once
    Include('c25_WinApi32Class.inc'), once
    Include('errors.clw'),Once
    Include('StringTheory.inc'), once
    Include('jfiles.inc'), once
    Include('C25_DUMMY.CLW'),once
    Include('C25_DUMMY.CLW'),once
    Include('c25_Equates_Itemized.clw'),ONCE

AdaptersWinHandlesArray         Long,dim(2048)
DbAdapterIndex                  Long
DBHandlerPtr                    Long
ReturnVal                       Long

c25DatabaseHandlerClass         Class(),type, Module('c25_DatabaseHandlerClass.clw'), Link('c25_DatabaseHandlerClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
Construct                           Procedure()
Destruct                            Procedure()


Adapters                            &c25DbAdapters_TYPE
Adapters_SeedId                     Long
AdapterWinHandle_TEMP               Long
AppMemoryReady                      Byte
c25DbSqlObject                      &c25DbSqlObject_TYPE
c25DbSqlObjectMem                   &String
c25EFObjects                        &c25EFObject_TYPE
c25EFObjectsIdSeed                  Long
c25EFObjectsTree                    &c25EFObject_TYPE
c25EFObjectsTreeIdSeed              Long
Connections                         &c25DbConnections_TYPE
ConnectionStrings                   &c25DbConnectionStrings_TYPE
ConnectionStrings_SeedId            Long
CRLF                                String(2)
Databases                           &c25DbDatabases_TYPE
Databases_SeedId                    Long
DatabasesTemp                       &c25DbDatabases_TYPE
EFMapMeta                           Procedure(),String,proc
ExecuteScalar                       Procedure(<String _eventId>,<Byte _async>, <Long _timeoutMMSecs>, <*Byte _isNull>, <*c25DbSqlObjectReturn_TYPE _c25DbSqlObjectReturn>, <Long _returnDataType>, <Long _targetPtr>, String _adapterName,String _sourceName,String _databaseName,<String _tableName>,<String _columnName>,String _sql),String,proc
GetAdapterByAdapterName             Procedure(String _name, <Long _dbEngineType>),Long,proc
GetDbDatabaseBySourceName           Procedure(String _adapterName, String _sourceName,<Long _dbEngineType>),String,proc
GetEFMapQType                       Procedure(String _typeName, <*queue _type>),*queue,proc
GetSelfAddress                      Procedure(),Long,proc
GetSqlite34ConnHandle               Procedure(String _adapterName, String _sourceName,String _dbName),Long
GetWinHandleByAdapterName           Procedure(String _name),Long,proc
Init                                Procedure(Long _paramA),Long,proc
InitReady                            Byte
JSon                                &JSONClass()
MsSql                               &c25MsSqlClass()
NanoSync                            &NanoSyncClass
PoweredUp                           Byte
PrimarySqlite3ConnHandle            Long
ProcessNextAdapter                  Byte
ReturnQueueRef                      &QUEUE
ReturnStringRef                     &String
ReturnVal                           Long
SaveQueue                           Procedure(<String _eventId>,<Byte _async>, String _adapterName,String _sourceName,<String _databaseName>,<String _tableName>,<String _queueType>,<*Queue _queue>, <Long _queuePtr>,<Byte _skipUpdateId>),String,proc
SelfAddress                         Long
SendAdapterMessage                  Procedure(String _adapterName, Long _mes),String,proc
SetDefaultModel                     Procedure(),Long,proc
Sources                             &c25DbSources_TYPE
Sources_SeedId                      Long
Sqlite34                            &Sqlite34Class
Sqlite34_IsMemoryBase                Byte
Sqlite34Ptr                         Long
Sqlite34Temp                        &Sqlite34Class
Sqlite34TempPtr                     Long
st1                                 &StringTheory()
st2                                 &StringTheory()
st3                                 &StringTheory()
st4                                 &StringTheory()
st5                                 &StringTheory()
TableColumns                        &c25DbTableColumns_TYPE
TableColumns_SeedId                 Long
Tables                              &c25DbTables_TYPE
Tables_SeedId                       Long
TrueReflection                      &TrueReflectionClass
WinApi                              &WinApi32Class
WndProcTest                         Procedure(),String,proc
                                End

