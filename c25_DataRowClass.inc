            Include('c25_ProgramHandlerClass.inc'),Once

c25_DataRowClass                                                            Class(),Type, Module('c25_DataRowClass.clw'), Link('c25_DataRowClass.clw',1),DLL(0)

Construct                                                                       Procedure()
Destruct                                                                        Procedure()

ProgramHandlerClass                                                             &c25_ProgramHandlerClass
BitConverterClass                                                               &c25_BitConverterClass
!BindingSourceClass                                                              &c25_BindingSourceClass
DataSourceClass                                                                 &c25_DataSourceClass
SourceDataColumns                                                               &c25_DataColumnsCollectionClass

PageBufferIndex                                                                 ULONG

I                                                                               LONG

DataCellsCapacity                                                               LONG
DataCellsCount                                                                  LONG

DataCells                                                                       long,dim(256)

DataCell                                                                        &c25_DataCellClass
Index                                                                           Long

SpecialColumns                                                                  long,dim(256)
SpecialColumnsCapacity                                                          LONG

Init                                                                            Procedure(*c25_DataSourceClass _dataSourceClass),bool,proc
Reset                                                                           Procedure(),bool,PROC
DisposeDataCells                                                                Procedure(),bool,PROC
AddNewDataCell                                                                  Procedure(*c25_DataColumnClass _dataColumnClass),*c25_DataCellClass
CellAtIndex                                                                     Procedure(long _index),*c25_DataCellClass
CellBySpecialColumnType                                                         Procedure(long _specialColumnType),*c25_DataCellClass
CellByName                                                                      Procedure(string _name),*c25_DataCellClass

                                                                            End

