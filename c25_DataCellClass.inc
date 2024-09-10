    Include('c25_ProgramHandlerClass.inc'),Once
    Include('c25_ExtendedDataTypes.inc'),Once

c25_DataCellClass           	                                        Class(),type,Module('c25_DataCellClass.clw'), Link('c25_DataCellClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
Construct                                                                   Procedure()
Destruct                                                                    Procedure()

!ClassTypeName                                                               cstring(128)
DataRow                                                                     &c25_DataRowClass

ASyncCall                                                                   bool
!RowIndex64                                                                  Like(UINT64)
!RowIndex                                                                    Decimal(20,0)

Index                                                                       LONG
!SpecialColumnType                                                           LONG


DataColumn                                                                  &c25_DataColumnClass
DataTable                                                                   &c25_DataTableClass
ProgramHandlerClass                                                         &c25_ProgramHandlerClass
ValueObject                                                                 &c25_ObjectClass !obselate todo
!ValueObjectDefaults                                                         &c25_ObjectClass
ValueObjectClass                                                            &c25_ValueObjectClass

Init                                                                        Procedure(*c25_DataRowClass _dataRowClass),long,PROC
ConvertClarionQFieldValue                                                   Procedure(*c25_DataColumnClass _dataColumnClass, *string _q),long,PROC
GetSpecialColumnType                                                        Procedure(),long

                                                                        End


