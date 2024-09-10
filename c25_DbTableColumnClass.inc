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

c25DbTableColumnClass               Class(),type, Module('c25_DbTableColumnClass.clw'), Link('c25_DbTableColumnClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
Construct                           Procedure()
Destruct                                Procedure(),virtual
ColumnsRecord                    Group(c25DbTableColumns_TYPE),Pre(ColumnsRecord)
                                End
GetSelfAddress                      Procedure(),Long,PROC
SelfAddress                         Long

c25DbTableColumnInstance                &c25DbTableColumnClass

                            End

