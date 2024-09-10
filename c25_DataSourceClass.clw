                        Member

                        Include('c25_DataSourceClass.inc'),Once
                        Map
                            Include('i64.inc')
                            Include('cwutil.inc')
                            Include('c25_WinApiPrototypes.inc')
                        End

c25_DataSourceClass.Construct                                  Procedure()

Code

    Self.BitConverterClass          &= NEW c25_BitConverterClass()
    Self.DataReflectionClass        &= NEW c25_DataReflectionClass()
    Self.ClarionFieldsQ             &= NEW ClarionFields_TYPE()
    Self.SourceDataColumns          &= NEW c25_DataColumnsCollectionClass()
    Self.CurrentPageBufferClass     &= NEW c25_PageBufferClass()

c25_DataSourceClass.Destruct                                    Procedure()

Code

c25_DataSourceClass.SetConnectionString                         Procedure(string _connString)

Code

    If not Self.ConnectionString &= NULL
        Dispose(Self.ConnectionString)
    End
    Self.ConnectionString &= Self.BitConverterClass.BinaryCopy(_connString)

    Return 0

c25_DataSourceClass.Init                                        Procedure(*c25_BindingSourceClass _bindingSourceClass)

Code

    Self.BindingSourceClass &= _bindingSourceClass
    Self.ProgramHandlerClass &= Self.BindingSourceClass.ProgramHandlerClass
    Self.SourceDataColumns.Init(Self)
    Return 0

c25_DataSourceClass.SetClarionQueue                                        Procedure(*Queue _queue)

Code

    Self.ClarionSourceQ &= _queue
    Self.SetSourceRowCount(Records(Self.ClarionSourceQ))
    Self.AnalyzeClarionQueue()
    If not Self.ClarionSourceQBytes &= NULL
        Dispose(Self.ClarionSourceQBytes)
    END
    Self.ClarionSourceQBytes &= NEW STRING(Size(Self.ClarionSourceQ))
    
    Case Self.BindingSourceClass.ControlClass.TypeEnum
    Of ControlType:TreeView
    End
    Return 0

c25_DataSourceClass.AnalyzeClarionQueue                 Procedure()

CODE

    If Self.ClarionSourceQ &= NULL
        Message('error at c25_DataSourceClass.AnalyseClarionQueue, set Self.ClarionSourceQ first')
        Return 0
    End
    Self.DataReflectionClass.Analyze(Self.ClarionSourceQ, Self.ClarionFieldsQ, 'm:\ClarionSourceQ.json')
    Self.SourceFieldsCount = Records(Self.ClarionFieldsQ)
    Self.SourceDataColumns.CreateFromClarionFields(Self.ClarionFieldsQ)

    Return 0

c25_DataSourceClass.SetSourceRowCount                   Procedure(string _rowCount)

CODE

    Self.SourceRowCountDecimal = _rowCount
    i64FromDecimal(Self.SourceRowCount, Self.SourceRowCountDecimal)
    Return Self.SourceRowCount

c25_DataSourceClass.SetPosition                         Procedure(<ulong _index32>, <string _index64>, <string _indexI64>)


CODE

    If omitted(_index32) = False
        Self.SourceIndex = Self.BitConverterClass.ConvertToI64(_index32)
    ElsIf omitted(_index64) = False
        Self.SourceIndex = Self.BitConverterClass.ConvertToI64(_index64)
    Else 
        Self.SourceIndex = _indexI64
    End
    
    
    Case Self.BindingSourceClass.DataSourceProviderType
    Of DataSourceProviderType:ClarionQueue
        !Message('try get Self.SourceIndex.Lo: ' & Self.SourceIndex.Lo)
        Get(Self.ClarionSourceQ, Self.SourceIndex.Lo)
        If Errorcode() <> 0
            !Message('ERROR GET c25_DataSourceClass.SetPosition')
            RETURN 0
        End
        Self.ClarionSourceQBytes = Self.ClarionSourceQ
    End
    Return True

c25_DataSourceClass.FillPageBuffer      Procedure(*c25_PageBufferClass _pageBufferClass, string _startIndex, long _maxRows)

DataRowClass        &c25_DataRowClass
RowIndex            uLONG

CODE

    !return 0
    Case Self.BindingSourceClass.DataSourceProviderType
    Of DataSourceProviderType:ClarionQueue
        RowIndex = _startIndex -1
        Loop 100 Times
            RowIndex = RowIndex + 1
            Self.SetPosition(RowIndex)
            
            DataRowClass &= _pageBufferClass.AddNewRow()
            DataRowClass.Init(Self)
            Self.ClarionQRowToDataRow(RowIndex, DataRowClass)
        End
    End

    Return 0

c25_DataSourceClass.ClarionQRowToDataRow      Procedure(ulong _index, *c25_DataRowClass _dataRowClass)

ColumnIndex         LONG
DataColumnClass     &c25_DataColumnClass
DataCellClass       &c25_DataCellClass
DataRowClass        &c25_DataRowClass

CODE


    If Self.SourceDataColumns.DataColumnsCount < 1
        Return 0
    End

    DataRowClass &= _dataRowClass

    ColumnIndex = 0
    Loop Self.SourceDataColumns.DataColumnsCount Times
        ColumnIndex = ColumnIndex + 1
        If Self.SourceDataColumns.DataColumnsArray[ColumnIndex] = 0
            Return 0
        End
        DataColumnClass &= (Self.SourceDataColumns.DataColumnsArray[ColumnIndex])
        DataCellClass &= DataRowClass.AddNewDataCell(DataColumnClass)
        DataCellClass.Init(DataRowClass)
        
        DataCellClass.ConvertClarionQFieldValue(DataColumnClass, Self.ClarionSourceQBytes)
    End
    DataColumnClass &= null
    DataRowClass    &= NULL
    DataCellClass   &= NULL

    Return 0
    
    
c25_DataSourceClass.SourceDataColumnAtIndex                Procedure(long _index)

CODE
    
    If Self.SourceDataColumns &= NULL
        Return NULL
    End
    
    I# = 0
    Loop Self.SourceDataColumns.DataColumnsCount Times
        I# = I# + 1
        If Self.SourceDataColumns.DataColumnsArray[I#] = 0
            CYCLE
        END
        Return (Self.SourceDataColumns.DataColumnsArray[I#])
    End
    Return NULL
    
    
    
    
!c25_DataSourceClass.SetDataRow              Procedure(*c25_DataRowClass _dataRowClass)
!
!I                                           LONG
!DataCellClass                               &c25_DataCellClass
!
!    CODE
!        
!        Message('hier')
!
!    If _dataRowClass &= NULL
!        Return 0
!    End
!
!    Case Self.BindingSourceClass.DataSourceProviderType
!    Of DataSourceProviderType:Sqlite3Table
!
!    Of DataSourceProviderType:ClarionQueue
!        _dataRowClass.Reset()
!        _dataRowClass.DataCellPtrArrayCount = Self.SourceFieldsCount
!
!        I = 0
!        Loop Self.SourceFieldsCount Times
!            I = I + 1
!            DataCellClass &= NEW c25_DataCellClass()
!            _dataRowClass.DataCellPtrArray[I] = Address(DataCellClass)
!            DataCellClass.ValueObjectClass.SetValueInt32(777)
!        End
!    Of DataSourceProviderType:MsSqlTable
!
!    End
!
!    Return ''
!
!c25_DataSourceClass.ResetDataRow      Procedure(*c25_DataRowClass _dataRowClass)
!
!CODE
!
!    Return ''
!
