        Member

        Include('c25_ObjectClass.inc'),Once

                    MAP
                        Include('Sqlite3Prototypes.inc')
                        Include('CWUTIL.inc'),once
                        Include('i64.inc')
                        Include('c25_WinApiPrototypes.inc')
                    End

c25_ObjectClass.Construct   Procedure()

!ClassStarter            &c25_ClassStarter
!ClassTypeName           cstring(128)

Code

!    ClassTypeName = 'c25_ObjectClass'
!    ClassStarter &= NEW c25_ClassStarter()
!    Self.ProgramHandlerClass &= (ClassStarter.Start(ClassTypeName))
!    Dispose(ClassStarter)
    Self.BitConverterClass &= NEW c25_BitConverterClass()

c25_ObjectClass.Destruct                                                    Procedure()

Code

    If not Self.Buffer &= NULL THEN Dispose(Self.Buffer).
    If not Self.DataLength &= NULL THEN Dispose(Self.DataLength).
    If not Self.DataType &= NULL THEN Dispose(Self.DataType).

    Self.Dispose_MsSqlColumnProperties()
    
!ObjectValueStorageType                                                      ITEMIZE,PRE(ObjectValueStorageType)
!Byte                                                                            Equate(1)
!Int16                                                                           equate
!UInt16                                                                          EQUATE
!Int32                                                                           equate
!UInt32                                                                          EQUATE
!Int64                                                                           equate
!UInt64                                                                          EQUATE
!StringPtr                                                                       EQUATE
!String                                                                          EQUATE
!MemAllocBufferPtr                                                               EQUATE
!MemAllocBufferPtrAndSize                                                        EQUATE
!MemAllocBuffer                                                                  EQUATE
!AWEMemAllocBuffer                                                               EQUATE
!OnDisk                                                                          EQUATE
!                                                                            END    

!c25_ObjectClass.SetValueByte        Procedure(byte _byte)
!
!Code
!
!    Self.Reset()
!    Self.ValueLong = _byte
!
!    
!c25_ObjectClass.SetValueInt16       Procedure(short _int16)
!
!Code
!
!c25_ObjectClass.SetValueUInt16      Procedure(ushort _uint16)
!
!Code
!
!c25_ObjectClass.SetValueInt32       Procedure(long _int32)
!
!Code
!
!c25_ObjectClass.SetValueUInt32      Procedure(ulong _uint32)
!
!Code



c25_ObjectClass.Dispose_MsSqlColumnProperties   Procedure()

CODE
        
        
    If not Self.MsSqlColumnProperties &= null
        If not Self.MsSqlColumnProperties.MSSQL_ALLOC_TYPE &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_ALLOC_TYPE).
        If not Self.MsSqlColumnProperties.MSSQL_ARRAY_SIZE &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_ARRAY_SIZE).
        If not Self.MsSqlColumnProperties.MSSQL_ARRAY_STATUS_PTR &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_ARRAY_STATUS_PTR).
        If not Self.MsSqlColumnProperties.MSSQL_AUTO_UNIQUE_VALUE &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_AUTO_UNIQUE_VALUE).
        If not Self.MsSqlColumnProperties.MSSQL_BASE_COLUMN_NAME &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_BASE_COLUMN_NAME).
        If not Self.MsSqlColumnProperties.MSSQL_BASE_TABLE_NAME &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_BASE_TABLE_NAME).
        If not Self.MsSqlColumnProperties.MSSQL_BIND_OFFSET_PTR &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_BIND_OFFSET_PTR).
        If not Self.MsSqlColumnProperties.MSSQL_BIND_TYPE &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_BIND_TYPE).
        If not Self.MsSqlColumnProperties.MSSQL_CASE_SENSITIVE &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_CASE_SENSITIVE).
        If not Self.MsSqlColumnProperties.MSSQL_CATALOG_NAME &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_CATALOG_NAME).
        If not Self.MsSqlColumnProperties.MSSQL_CONCISE_TYPE &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_CONCISE_TYPE).
        If not Self.MsSqlColumnProperties.MSSQL_COUNT &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_COUNT).
        If not Self.MsSqlColumnProperties.MSSQL_DATA_PTR &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_DATA_PTR).
        If not Self.MsSqlColumnProperties.MSSQL_DATETIME_INTERVAL_CODE &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_DATETIME_INTERVAL_CODE).
        If not Self.MsSqlColumnProperties.MSSQL_DISPLAY_SIZE &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_DISPLAY_SIZE).
        If not Self.MsSqlColumnProperties.MSSQL_FIXED_PREC_SCALE &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_FIXED_PREC_SCALE).
        If not Self.MsSqlColumnProperties.MSSQL_INDICATOR_PTR &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_INDICATOR_PTR).
        If not Self.MsSqlColumnProperties.MSSQL_LABEL &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_LABEL).
        If not Self.MsSqlColumnProperties.MSSQL_LENGTH &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_LENGTH).
        If not Self.MsSqlColumnProperties.MSSQL_LITERAL_PREFIX &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_LITERAL_PREFIX).
        If not Self.MsSqlColumnProperties.MSSQL_LITERAL_SUFFIX &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_LITERAL_SUFFIX).
        If not Self.MsSqlColumnProperties.MSSQL_LOCAL_TYPE_NAME &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_LOCAL_TYPE_NAME).
        If not Self.MsSqlColumnProperties.MSSQL_MAXIMUM_SCALE &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_MAXIMUM_SCALE).
        If not Self.MsSqlColumnProperties.MSSQL_MINIMUM_SCALE &= NULL THEN Dispose(Self.Buffer).
        If not Self.MsSqlColumnProperties.MSSQL_NAME &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_NAME).
        If not Self.MsSqlColumnProperties.MSSQL_NULLABLE &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_NULLABLE).
        If not Self.MsSqlColumnProperties.MSSQL_NUM_PREC_RADIX &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_NUM_PREC_RADIX).
        If not Self.MsSqlColumnProperties.MSSQL_OCTET_LENGTH &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_OCTET_LENGTH).
        If not Self.MsSqlColumnProperties.MSSQL_OCTET_LENGTH_PTR &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_OCTET_LENGTH_PTR).
        If not Self.MsSqlColumnProperties.MSSQL_PARAMETER_TYPE &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_PARAMETER_TYPE).
        If not Self.MsSqlColumnProperties.MSSQL_PRECISION &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_PRECISION).
        If not Self.MsSqlColumnProperties.MSSQL_ROWS_PROCESSED_PTR &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_ROWS_PROCESSED_PTR).
        If not Self.MsSqlColumnProperties.MSSQL_ROWVER &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_ROWVER).
        If not Self.MsSqlColumnProperties.MSSQL_SCALE &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_SCALE).
        If not Self.MsSqlColumnProperties.MSSQL_SCHEMA_NAME &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_SCHEMA_NAME).
        If not Self.MsSqlColumnProperties.MSSQL_SEARCHABLE &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_SEARCHABLE).
        If not Self.MsSqlColumnProperties.MSSQL_TABLE_NAME &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_TABLE_NAME).
        If not Self.MsSqlColumnProperties.MSSQL_TYPE &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_TYPE).
        If not Self.MsSqlColumnProperties.MSSQL_TYPE_NAME &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_TYPE_NAME).
        If not Self.MsSqlColumnProperties.MSSQL_UNNAMED &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_UNNAMED).
        If not Self.MsSqlColumnProperties.MSSQL_UNSIGNED &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_UNSIGNED).
        If not Self.MsSqlColumnProperties.MSSQL_UPDATABLE &= NULL THEN Dispose(Self.MsSqlColumnProperties.MSSQL_UPDATABLE).
        Dispose(Self.MsSqlColumnProperties)
    End
    
    Return 0


c25_ObjectClass.ParseSqlite3Value                                                       Procedure(long _sqlStatementSelectHandle, long _sourceIndex)

CODE

    If not Self.Value &= NULL
        Dispose(Self.Value)
    End
   

    Self.SourceTypeEnum = c25_sqlite3_column_type(_sqlStatementSelectHandle, _sourceIndex)
    
    Case Self.SourceTypeEnum
    Of Sqlite3DataTypeEnum:INTEGER
        Self.SourceColumnBytes = c25_sqlite3_column_bytes(_sqlStatementSelectHandle, _sourceIndex)
        P# = c25_sqlite3_column_text(_sqlStatementSelectHandle, _sourceIndex)
        If P# <> 0 And Self.SourceColumnBytes > 0
            Self.Buffer &= NEW STRING(Self.SourceColumnBytes)
            C25_Memcpy(Address(Self.Buffer), P#, Self.SourceColumnBytes)
            Self.SetNumericValue(Self.Buffer)
            Self.ValueLong = Self.Buffer
            Dispose(Self.Buffer)
        End
    Of Sqlite3DataTypeEnum:FLOAT
    Of Sqlite3DataTypeEnum:TEXT
        Self.SourceColumnBytes = c25_sqlite3_column_bytes16(_sqlStatementSelectHandle, _sourceIndex)
        P# = c25_sqlite3_column_text16(_sqlStatementSelectHandle, _sourceIndex)
        If P# <> 0 And Self.SourceColumnBytes > 0
            Self.Value &= NEW STRING(Self.SourceColumnBytes)
            C25_Memcpy(Address(Self.Value), P#, Self.SourceColumnBytes)
        End
    Of Sqlite3DataTypeEnum:TEXT
         Self.SourceColumnBytes = c25_sqlite3_column_bytes16(_sqlStatementSelectHandle, _sourceIndex)
        P# = c25_sqlite3_column_text16(_sqlStatementSelectHandle, _sourceIndex)
        If P# <> 0 And Self.SourceColumnBytes > 0
            Self.Buffer &= NEW STRING(Self.SourceColumnBytes)
            C25_Memcpy(Address(Self.Buffer), P#, Self.SourceColumnBytes)
            Self.SetNumericValue(Self.Buffer)
            Dispose(Self.Buffer)
        End
    Of Sqlite3DataTypeEnum:BLOB

    Of Sqlite3DataTypeEnum:NULL

    End
    Return 0

c25_ObjectClass.SetStringValue                                           Procedure(string _source, <long _encodingSource>, <long _encodingReturn>, <bool _setNull>)

CODE

    Self.IsStringValue = True
    Self.IsNULL = False

    If omitted(_encodingSource) = FALSE
        Self.EncodingStringValue = _encodingSource
    End
    If omitted(_encodingReturn) = FALSE
        Self.EncodingStringValueOut = _encodingReturn
    End

    If not Self.StringValue &= NULL
        Dispose(Self.StringValue)
    End
    If omitted(_setNull) = FALSE
        If _setNull = TRUE
            Self.IsNULL = True
        End
    End
    Self.IsNULL = False
    Self.StringValue &= Self.BitConverterClass.BinaryCopy(_source)

c25_ObjectClass.GetStringValue                                           Procedure(<string _returnValueIfNull>, <*string _stringRef>)

Ref  &STRING

CODE

    If Self.StringValue &= NULL
        If omitted(_returnValueIfNull) = FALSE
            If omitted(_stringRef) = False
                Ref &=_stringRef
                If not Ref &= null
                    _stringRef = _returnValueIfNull
                End
            End
            Return _returnValueIfNull
        Else
            If omitted(_stringRef) = False
                Ref &=_stringRef
                If not Ref &= null
                    _stringRef = ''
                End
            End
            Return ''
        End
    End
    If omitted(_stringRef) = False
        Ref &=_stringRef
        If not Ref &= null
            _stringRef = Self.StringValue
       End
    End
    Return Self.StringValue

c25_ObjectClass.GetStringValueRef                                           Procedure()

CODE

    Return Self.StringValue

c25_ObjectClass.GetStringValueNewRef                                           Procedure(<string _returnValueIfNull>)

NewString &String

CODE

    If Self.StringValue &= NULL
        If omitted(_returnValueIfNull) = true
            Return null
        Else
            NewString &= Self.BitConverterClass.BinaryCopy(_returnValueIfNull)
            Return NewString
        End
    End
    NewString &= Self.BitConverterClass.BinaryCopy(Self.StringValue)
    Return NewString

c25_ObjectClass.SetNumericValue                                           Procedure(string _numericSource)

CODE

    Self.NumericTypeEnum = 0
    Self.Dec21 = _numericSource
    If Self.ValueNumeric &= null
        Self.ValueNumeric &= NEW ValueNumeric_TYPE()
    End
    Self.ValueNumeric.NumericSource = _numericSource

    If Self.Dec21 = 0 Or Self.Dec21 = 1
        Self.NumericTypeEnum = IntTypeEnum:Boolean
    Else
        If Self.Dec21 < 0
            Self.ValueNumeric.IsNegative = True

            If Self.Dec21 > -129
                Self.NumericTypeEnum = IntTypeEnum:Int8
            ElsIf Self.Dec21 >= Self.BitConverterClass.Int16MinValue
                Self.NumericTypeEnum = IntTypeEnum:Int16
            ElsIf Self.Dec21 >= Self.BitConverterClass.Int32MinValue
                Self.NumericTypeEnum = IntTypeEnum:Int32
            ElsIf Self.Dec21 >= Self.BitConverterClass.Int64MinValue
                Self.NumericTypeEnum = IntTypeEnum:Int64
            ELSE
                Self.NumericTypeEnum = IntTypeEnum:IntLarge
            End
        Else
            Self.ValueNumeric.IsNegative = FALSE

            If Self.Dec21 < 128
                Self.NumericTypeEnum = IntTypeEnum:UInt8
            ElsIf Self.Dec21 =< Self.BitConverterClass.UInt16MaxValue
                Self.NumericTypeEnum = IntTypeEnum:UInt8
            ElsIf Self.Dec21 =< Self.BitConverterClass.UInt32MaxValue
                Self.NumericTypeEnum = IntTypeEnum:UInt32
            ElsIf Self.Dec21 =< Self.BitConverterClass.UInt64MaxValue
                Self.NumericTypeEnum = IntTypeEnum:UInt64
            ELSE
                Self.NumericTypeEnum = IntTypeEnum:UIntLarge
            End
        End
    End
    Case Self.NumericTypeEnum
    Of IntTypeEnum:Boolean
        Self.ValueNumeric.BoolValue = _numericSource
    Of IntTypeEnum:Int8
        Self.ValueNumeric.Int8Value = _numericSource
    Of IntTypeEnum:UInt8
        Self.ValueNumeric.UInt8Value = _numericSource
    Of IntTypeEnum:Int16
        Self.ValueNumeric.Int16Value = _numericSource
    Of IntTypeEnum:UInt16
        Self.ValueNumeric.UInt16Value = _numericSource
    Of IntTypeEnum:Int32
        Self.ValueNumeric.Int32Value = _numericSource
    Of IntTypeEnum:UInt32
        Self.ValueNumeric.UInt32Value = _numericSource
    Of IntTypeEnum:Int64
        Self.ValueNumeric.Int64Value = _numericSource
    Of IntTypeEnum:UInt64
        Self.ValueNumeric.UInt64Value = _numericSource
    Of IntTypeEnum:IntLarge
    Of IntTypeEnum:UIntLarge
    End

c25_ObjectClass.GetNumericValue     Procedure()

CODE

    Case Self.NumericTypeEnum
    Of IntTypeEnum:Boolean
        Return Self.ValueNumeric.BoolValue
    Of IntTypeEnum:Int8
        Return Self.ValueNumeric.Int1Value
    Of IntTypeEnum:UInt8
       Return Self.ValueNumeric.UInt1Value
    Of IntTypeEnum:Int16
        Return Self.ValueNumeric.Int16Value
    Of IntTypeEnum:UInt16
        Return Self.ValueNumeric.UInt16Value
    Of IntTypeEnum:Int32
        Return Self.ValueNumeric.Int32Value
    Of IntTypeEnum:UInt32
        Return Self.ValueNumeric.UInt32Value
    Of IntTypeEnum:Int32
        Return Self.ValueNumeric.Int32Value
    Of IntTypeEnum:UInt32
        Return Self.ValueNumeric.UInt32Value
    Else
        Return Self.ValueNumeric.NumericSource
    End

    Return 0

c25_ObjectClass.GetValueFromValuePtr      Procedure(long _ptr, long _size, <bool _deleteAlloc>)

CODE

    If _ptr = 0 Or _size < 1
        Return ''
    End

    If not Self.Buffer &= NULL
        Dispose(Self.Buffer)
    End
    Self.Buffer &= NEW STRING(_size)

    C25_Memcpy(Address(Self.Buffer),_ptr, _size)
    Return Self.Buffer

c25_ObjectClass.FindInByteArray     Procedure(string _findBytes, long _valuePtr, long _valueSize, <bool _caseInsensitive>)

st                                      &StringTheory
F                                       LONG

CODE

    If _valuePtr = 0 Or _valueSize < 1
        return 0
    End
    st &= NEW StringTheory()
    st.SetValueByAddress(_valuePtr, _valueSize)
    F = st.FindChars(_findBytes)

    st.SetValueByAddress(Address(Self.DummyString1), 1)
    st.Start()
    Dispose(st)
    Return F

c25_ObjectClass.StringTheoryToMemAllocPtr                                   Procedure(*StringTheory st, <bool _freeValue>)

Tuple2                                                                      Group
V1                                                                              LONG
V2                                                                              LONG
                                                                            End
CODE

    Clear(Tuple2)

    If st &= NULL
        Return Tuple2
    End
    If st.Length() < 1
        Return Tuple2
    End
    Tuple2.V1 = c25_HeapAlloc(C25_Getprocessheap(), c25_HEAP_ZERO_MEMORY, st.Length())

    C25_Memcpy(Tuple2.V1, st.GetAddress(), st.Length())
    Tuple2.V2 = st.Length()
    If _freeValue = TRUE
        st.Start()
    End
    Return Tuple2

c25_ObjectClass.SetValue                                                    Procedure(string _value, <long _size>)

    CODE

    Return 0

c25_ObjectClass.SetValue                                                    Procedure(long _ptr, long _size)

    CODE

    Return 0

c25_ObjectClass.SetDataType                                                 Procedure(string _dataType)

CODE

    If not Self.DataType &= null
        Dispose(Self.DataType)
    End
    If Size(_dataType) > 0
        Self.DataType &= NEW STRING(Size(_dataType))
        Self.DataType = _dataType
    End
    Return 0

c25_ObjectClass.SetDataTypeEnum                                             Procedure(long _dataTypeEnum)

    CODE

        Self.DataTypeEnum = _dataTypeEnum
        Return ''

c25_ObjectClass.DeformatDataLength  Procedure(string _dataLengthString)

    CODE

c25_ObjectClass.Reset  Procedure()

    CODE
        
!    Clear(Self.ValueLong)
!
!    Clear(Self.FieldOrdinal)
!    Clear(Self.IsFirstField)
!    Clear(Self.IsLastField)
!
!    Clear(Self.Dec21)
!    Clear(Self.NumericTypeEnum)
!    Clear(Self.IsStringValue)
!    Clear(Self.EncodingStringValue)
!    Clear(Self.EncodingStringValueOut)
!    Clear(Self.SourceTypeEnum)
!    Clear(Self.SourceColumnBytes)
!    Clear(Self.BufferSize)
!    Clear(Self.BytesAllocated)
!    Clear(Self.BytesSize)
!    Clear(Self.Characters)
!    Clear(Self.DataTypeEnum)
!    Clear(Self.DummyString1)
!    Clear(Self.IsNULL)
!    Clear(Self.IsPrivateHeap)
!    Clear(Self.SystemDataTypeEnum)
!    Clear(Self.ValuePtr)
!    Clear(Self.ValueSize)
!
!    If not Self.Buffer &= null
!        Dispose(Self.Buffer)
!    End
!    If not Self.Name &= null
!        Dispose(Self.Name)
!    End
!    If not Self.Value &= null
!        Dispose(Self.Value)
!    End
!    If not Self.DataLength &= null
!        Dispose(Self.DataLength)
!    End
!    If not Self.DataType &= null
!        Dispose(Self.DataType)
!    End
!    If not Self.Buffer &= null
!        Dispose(Self.Buffer)
!    End    
!    Dispose(Self.Name)
!    Dispose(Self.Value)
!    Dispose(Self.DataLength)
!    Dispose(Self.DataType)
!    Self.Dispose_MsSqlColumnProperties()
!        
!    Dispose(Self.StringValue)
!    Dispose(Self.ValueNumeric.NumericFormatted)
!    Dispose(Self.ValueNumeric)
!        
!
