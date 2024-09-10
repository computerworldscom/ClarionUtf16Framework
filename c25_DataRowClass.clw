                        Member

                        Include('c25_DataRowClass.inc'),Once
                        Map
                            Include('i64.inc')
                            Include('cwutil.inc')
                            Include('c25_WinApiPrototypes.inc')
                        End


c25_DataRowClass.Construct                                          Procedure()

Code

    Clear(Self.DataCells)
    Self.DataCellsCapacity = Maximum(Self.DataCells,1)
    Self.DataCellsCount = 0
    Self.SpecialColumnsCapacity =  Maximum(Self.SpecialColumns,1)

c25_DataRowClass.Destruct                                           Procedure()

    Code
        

c25_DataRowClass.Init                                               Procedure(*c25_DataSourceClass _dataSourceClass)

Code

    !Self.BindingSourceClass &= _bindingSourceClass
    Self.DataSourceClass &= _dataSourceClass
    Self.SourceDataColumns &= Self.DataSourceClass.SourceDataColumns
    Self.ProgramHandlerClass &= Self.DataSourceClass.ProgramHandlerClass
    Self.BitConverterClass &= Self.DataSourceClass.BitConverterClass
    Return 0
    

c25_DataRowClass.Reset                                              Procedure()

Code

    Self.DisposeDataCells()
    
    Return 0
    
c25_DataRowClass.DisposeDataCells                                   Procedure()

Code

    Self.I = 0
    Loop Self.DataCellsCapacity TIMES
        Self.I = Self.I + 1
        If Self.DataCells[Self.I] <> 0
            Self.DataCell &= (Self.DataCells[Self.I])
            Dispose(Self.DataCell)
            Self.DataCells[Self.I] = 0
        End
    End
    Self.DataCellsCount = 0
    Self.Index = 0
    Return 0
    
    
    
    
c25_DataRowClass.AddNewDataCell                                     Procedure(*c25_DataColumnClass _dataColumnClass)

DataCell   &c25_DataCellClass

Code

    Self.DataCellsCount = Self.DataCellsCount + 1
    Self.Index = Self.DataCellsCount
    DataCell &= NEW c25_DataCellClass()
    
    DataCell.DataColumn &= _dataColumnClass !Self.DataSourceClass.SourceDataColumnAtIndex(Self.Index)

    
    Self.DataCell &= DataCell
    Self.DataCell.Index = Self.Index
    Self.DataCells[Self.Index] = Address(Self.DataCell)    
    
    Return Self.DataCell
    
    
c25_DataRowClass.CellAtIndex                                        Procedure(long _index)

Code

    If _index < 1 Or _index > Self.DataCellsCapacity Or _index > Self.DataCellsCount
        Return NULL
    END
    Return (Self.DataCells[_index])
    

c25_DataRowClass.CellByName                                     Procedure(string _name)

DataCell &c25_DataCellClass

Code

    I# = 0
    Loop Self.DataCellsCount TIMES
        I# = I# + 1
        DataCell &= Self.CellAtIndex(I#)
        If DataCell.DataColumn.NameUpper = upper(_name)
            Return Self.CellAtIndex(I#)
        End
    End
    Return null
    

c25_DataRowClass.CellBySpecialColumnType                                     Procedure(long _specialColumnType)

DataCell &c25_DataCellClass

Code

    If _specialColumnType < 1 Or _specialColumnType > Self.SpecialColumnsCapacity
        Return NULL
    END
    If Self.SpecialColumns[_specialColumnType] = 0
        I# = 0
        Loop Self.DataCellsCount TIMES
            I# = I# + 1
            DataCell &= Self.CellAtIndex(I#)
            If DataCell.DataColumn.SpecialColumnType = _specialColumnType
                Self.SpecialColumns[I#] = _specialColumnType
                Return Self.CellAtIndex(I#)
            End
        End
        Return NULL
    End
    Return Self.CellAtIndex(Self.SpecialColumns[_specialColumnType])
    

    
    