    Include('errors.clw'),Once
    Include('c25_DataTypes.clw'),Once
    Include('c25_NanoSyncClass.inc'), once
    Include('c25_WinApi32Class.inc'), once
    Include('c25_DatabaseHandlerClass.inc'), once
    Include('c25_DbAdapterClass.inc'), once
    Include('c25_DbSourceClass.inc'), once
    Include('c25_DbDatabaseClass.inc'), once
    Include('StringTheory.inc'), once
    Include('C25_DUMMY.CLW'), once

c25DbTableClass               Class(),type, Module('c25_DbTableClass.clw'), Link('c25_DbTableClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
Construct                       Procedure()
Destruct                        Procedure(),virtual
TablesRecord                    Group(c25DbTables_TYPE),Pre(TablesRecord)
                                End
GetSelfAddress                  Procedure(),Long,PROC
SelfAddress                     Long
ClarionFields_Records             Long
ClarionQueueTypeName            &String
ClarionQueueTypeRef             &Queue
CreateScript                    &String
TableColumns                    &c25DbTableColumns_TYPE()
PopulateFromClaQTypeRef         Byte
DropTableIfExists               Byte
ClarionFields_Index             Long
TrueReflection                  &TrueReflectionClass
ClarionFields                   &ClarionFields_TYPE
                            End

