    Include('c25_ProgramHandlerClass.inc'),Once

c25_DataColumnsCollectionClass                                              Class(),type, Module('c25_DataColumnsCollectionClass.clw'), Link('c25_DataColumnsCollectionClass.clw',1),DLL(0)
Construct                                                                       Procedure()
Destruct                                                                        Procedure()

DataColumnsArrayCapacity                                                        Long

DataColumnsArray                                                                long,dim(256)
DataColumnsCount                                                                Long

DataSourceClass                                                                 &c25_DataSourceClass
ProgramHandlerClass                                                             &c25_ProgramHandlerClass
BitConverterClass                                                               &c25_BitConverterClass
Init                                                                            Procedure(*c25_DataSourceClass _dataSourceClass),Long,proc
RemoveAll                                                                       Procedure(),long,PROC
CreateFromClarionFields                                                         Procedure(*ClarionFields_TYPE _clarionFields),long,PROC
                                                                            End

