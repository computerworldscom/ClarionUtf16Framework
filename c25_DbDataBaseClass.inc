    Include('errors.clw'),Once
    Include('c25_DataTypes.clw'),Once
    Include('c25_NanoSyncClass.inc'), once
    Include('c25_WinApi32Class.inc'), once
    Include('c25_DatabaseHandlerClass.inc'), once
    Include('c25_DbAdapterClass.inc'), once
    Include('c25_DbSourceClass.inc'), once
    Include('StringTheory.inc'), once
    Include('C25_DUMMY.CLW'), once
    Include('c25_MsSqlClass.inc'),once
    Include('C25_DUMMY.CLW'),once

c25DbDatabaseClass          Class(),type, Module('c25_DbDatabaseClass.clw'), Link('c25_DbDatabaseClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
Construct                   Procedure()
Destruct                    Procedure()
SelfAddress                 Long
GetSelfAddress              Procedure(),Long
NanoSync                    &NanoSyncClass
WinApi32                    &WinApi32Class
DatabaseRecord              Group(c25DbDatabases_TYPE),Pre(DatabaseRecord)
                            End
Tables                      &c25DbTables_TYPE
                            End

