     Member

    Include('c25_MsSqlClass.inc'),once

            Map
                include('c25_Prototypes_Sqlsrv32.clw')
                Include('c25_WinApiPrototypes.clw')
                Include('i64.inc')
                Include('CWUTIL.inc'),once
            End

c25_MsSqlClass.Construct                                                         Procedure()

    Code






        Self.SetTestValues              = TRUE

        Self.DebugLog                   = True
        Self.DateTime27StringPtr        = Address(Self.DateTime27String)
        Self.DateTime23StringPtr        = Address(Self.DateTime23String)

        Self.st1                        &= New StringTheory()
        Self.st2                        &= New StringTheory()

        Self.Js1                        &= New JSONClass()


        Self.ClarionFields              &= New ClarionFields_TYPE()
        Self.MsSqlMeta                  &= New MsSqlInformationSchema_TYPE()
        Self.DataReflection             &= NEW c25_DataReflectionClass

        Self.NanoSync                   &= NEW c25_NanoSyncClass()
        Self.BitConverter               &= NEW c25_BitConverterClass()
        Self.WinApi                     &= NEW c25_WinApiClass()
        
        Self.SelfAddress                = Address(Self)
        Self.Int32MaxValue              = 2147483647
        Self.Int32MinValue              = -2147483648
        Self.UInt32MaxValue             = 4294967295
        Self.UInt32MinValue             = 0

        Self.Int64MaxValue              = 9223372036854775807
        Self.Int64MinValue              = -9223372036854775808
        Self.UInt64MaxValue             = 18446744073709551615
        Self.UInt64MinValue             = 0
        Self.ExecuteScriptQ            &= NEW ExecuteScript_TYPE()
        Self.StSqlBase                 &= New StringTheory()
        Self.StSql                     &= New StringTheory()

        Self.CharacterAttributePtr      = Address(Self.CharacterAttribute)
        Self.StringLengthPtr            = Address(Self.StringLength)
        Self.NumericAttributePtr        = Address(Self.NumericAttribute)

        Self.Describe_ColumnNamePtr     = Address(Self.Describe_ColumnName)
        Self.Describe_NameLengthPtr     = Address(Self.Describe_NameLength)
        Self.Describe_DataTypePtr       = Address(Self.Describe_DataType)
        Self.Describe_ColumnSizePtr     = Address(Self.Describe_ColumnSize)
        Self.Describe_DecimalDigitsPtr  = Address(Self.Describe_DecimalDigits)
        Self.Describe_NullablePtr       = Address(Self.Describe_Nullable)
        Self.Describe_ColumnNameSize    = (Size(Self.Describe_ColumnName)-1) / 2

        Self.TargetStr4OverLongPtr      = Address(Self.TargetStr4OverLong)

        Self.SQLGetDataReturnLength     = 0
        Self.SQLGetDataReturnLengthPtr  = Address(Self.SQLGetDataReturnLength)

        Self.CharBuffer2MBPtr            = Address(Self.CharBuffer2MB)

        Self.ByteValuePtr               = Address(Self.ByteValue)
        Self.ShortValuePtr              = Address(Self.ShortValue)
        Self.LongValuePtr               = Address(Self.LongValue)
        Self.Int64ValuePtr              = Address(Self.Int64Value)
        Self.UInt64ValuePtr             = Address(Self.UInt64Value)

        Self.Str11OverDec20Ptr          = Address(Self.Str11OverDec20)

        Self.IntValue                   = 0
        Self.IntValuePtr                = Address(Self.IntValue)

        Self.SmallIntValue              = 0
        Self.SmallIntValuePtr           = Address(Self.SmallIntValue)

        Self.TinyIntValue               = 0
        Self.TinyIntValuePtr            = Address(Self.TinyIntValue)

        Self.UTinyIntValue              = 0
        Self.UTinyIntValuePtr           = Address(Self.UTinyIntValue)

        Self.BitValue                   = 0
        Self.BitValuePtr                = Address(Self.bitValue)

        Self.StrLen_or_IndPtr           = Address(Self.StrLen_or_Ind)


        Self.DecimalInStringPtr         = Address(Self.DecimalInString)

        I# = 0
        Loop Maximum(Self.BcpBoundEmptyStringPtr,1) Times
            I# = I# + 1
            Self.BcpBoundEmptyStringPtr[I#] = Address(Self.BcpBoundEmptyString[I#])
        End

        I# = 0
        Loop Maximum(Self.MemNullablePtr,1) Times
            I# = I# + 1
            Self.MemNullablePtr[I#] = Address(Self.MemNullable[I#])
        End

        I# = 0
        Loop Maximum(Self.MemIndicatorLenPtr,1) Times
            I# = I# + 1
            Self.MemIndicatorLenPtr[I#] = Address(Self.MemIndicatorLen[I#])
        End

        I# = 0
        Loop Maximum(Self.MemIsFixedLenPtr,1) Times
            I# = I# + 1
            Self.MemIsFixedLenPtr[I#] = Address(Self.MemIsFixedLen[I#])
        End

        I# = 0
        Loop Maximum(Self.MemFixedLenPtr,1) Times
            I# = I# + 1
            Self.MemFixedLenPtr[I#] = Address(Self.MemFixedLen[I#])
        End

        I# = 0
        Loop Maximum(Self.MemAllocFullLenPtr,1) Times
            I# = I# + 1
            Self.MemAllocFullLenPtr[I#] = Address(Self.MemAllocFullLen[I#])
        End

        I# = 0
        Loop Maximum(Self.MemAllocHandlePtr,1) Times
            I# = I# + 1
            Self.MemAllocHandlePtr[I#] = Address(Self.MemAllocHandle[I#])
        End

        I# = 0
        Loop Maximum(Self.OctedLenPtr,1) Times
            I# = I# + 1
            Self.OctedLenPtr[I#] = Address(Self.OctedLen[I#])
        End

        I# = 0
        Loop Maximum(Self.MemAllocValueLenPtr,1) Times
            I# = I# + 1
            Self.MemAllocValueLenPtr[I#] = Address(Self.MemAllocValueLen[I#])
        End

        I# = 0
        Loop Maximum(Self.MemIndicatorValuePtr,1) Times
            I# = I# + 1
            Self.MemIndicatorValuePtr[I#] = Address(Self.MemIndicatorValue[I#])
        End

        I# = 0
        Loop Maximum(Self.MemValueLenPtr,1) Times
            I# = I# + 1
            Self.MemValueLenPtr[I#] = Address(Self.MemValueLen[I#])
        End

        If Self.ProcessHeapHandle = 0
            Self.ProcessHeapHandle = c25_GetProcessHeap()
        End

        Self.Utf16SpacesBuffer &= NEW String(32000)

        Self.T = 0
        Self.P = Size(Self.Utf16SpacesBuffer) / 2

        c25_memset(Address(Self.Utf16SpacesBuffer), 0 , Size(Self.Utf16SpacesBuffer))

        Self.Utf16SpacesBufferPtr = Address(Self.Utf16SpacesBuffer)
        Loop Self.P Times
            c25_memset(Self.Utf16SpacesBufferPtr + Self.T, 32 , 1)
            Self.T = Self.T + 2
        End

c25_MsSqlClass.Destruct                                                          Procedure()

    Code

c25_MsSqlClass.GetCreateBCPFormatFile                                            Procedure(String _tableNameA, <String _fields>, <*QUEUE _claQueue>, <String _queueType>)

Sql cstring(4096)

    Code

        Return 'jeetje'

        If Len(Clip(_tableNameA)) < 1
            Return -2
        End

        If not Self.ClarionFields &= NULL
            Free(Self.ClarionFields)
        ELSE
            Self.ClarionFields &= NEW ClarionFields_TYPE
        End

        If omitted(_claQueue) = False
            If not _claQueue &= null
                Self.GetClaDataReflectionAnalyze(_claQueue)
            End
        ElsIf omitted(_fields) = False
            Self.st1.Start()
            Self.St1.Append(_fields)
            Self.St1.Split(',')
            G# = 0
            Loop Records(Self.St1.Lines) TIMES
                G# = G# + 1
                Get(Self.St1.Lines,G#)
                If Len(Clip(Left(Self.St1.Lines.line))) < 1
                    Cycle
                End
                Clear(Self.ClarionFields)
                Self.ClarionFields.Name = Clip(Left(Self.St1.Lines.line))
                Add(Self.ClarionFields)
            End
        ELSE
            Return ''
        End

        Self.st1.Start()
        Self.st1.Append('Select Top 1 ')
        G# = 0
        Loop Records(Self.ClarionFields) TIMES
            G# = G# + 1
            Get(Self.ClarionFields,G#)
            If G# = 1
                Self.st1.Append(Self.ClarionFields.Name)
            Else
                Self.st1.Append(', ' & Self.ClarionFields.Name)
            End
        End
        Self.st1.Append(' From ' & Clip(_tableNameA) & ' WHERE 0 > 1' & Chr(0) )

        Message(Self.st1.GetValue())

        Sql = Self.st1.GetValue()


        Self.StmtHandle = Self.AllocHandle(,True)
        If Self.StmtHandle = 0
            Return 0
        End

        If Not Self.BulkTableNameA &= NULL
            Dispose(Self.BulkTableNameA)
        End
        If Not Self.BulkTableNameW &= NULL
            Dispose(Self.BulkTableNameW)
        End
        If Not Self.BulkErrorFileW &= NULL
            Dispose(Self.BulkErrorFileW)
        End
        If Not Self.BulkHostFileW &= NULL
            Dispose(Self.BulkHostFileW)
        End
        If Not Self.BulkFormatFileW &= NULL
            Dispose(Self.BulkFormatFileW)
        End

        Self.BulkTableNameA &= Self.BitConverter.BinaryCopy(Clip(_tableNameA) & Chr(0))

        Self.BulkTableNameW     &= Self.BitConverter.AnsiToUtf16(Self.BulkTableNameA,,True)

        Self.BulkErrorFileW     &= Self.BitConverter.AnsiToUtf16('.\DataTemp\BCP_INIT_ERRORS_' & Self.NanoSync.GetSysTime() & '.txt', , True)
        Self.BulkHostFileW      &= Self.BitConverter.AnsiToUtf16('.\DataTemp\BCP_HOSTFILE_' & Self.NanoSync.GetSysTime() & 'bcp', , True)
        Self.BulkFormatFileW    &= Self.BitConverter.AnsiToUtf16('.\DataTemp\BCP_FormatFile_' & Self.NanoSync.GetSysTime() & 'fmt', , True)

        Self.BulkSqlSelectA    &= Self.BitConverter.BinaryCopy(Sql & Chr(0) )

        Self.RETCODE = C25_Bcp_Init(Self.ConnHandle, 0, Address(Self.BulkHostFileW),  Address(Self.BulkErrorFileW), C25_ODBC_DB_OUT)
        If Self.RETCODE = C25_ODBC_FAIL
            Message(Self.RETCODE & ', error C25_Bcp_Init ' & c25_getlasterror())
        End
        Self.RETCODE = C25_BCP_Control(Self.ConnHandle, C25_BCPHINTSA , Address(Self.BulkSqlSelectA))

        Self.SetTestValues = TRUE

        Self.MsSqlMetaArrayIndex = 0
        R# = Records(Self.MsSqlMeta)

        Self.RETCODE = C25_bcp_columns(Self.ConnHandle, R#)
        If Self.RETCODE = C25_ODBC_FAIL
            Message(Self.RETCODE & ', error C25_bcp_columns ' & c25_getlasterror())
        End

        Self.RETCODE = C25_BCP_WriteFmt(Self.ConnHandle, Address(Self.BulkFormatFileW))
        If Self.RETCODE = C25_ODBC_FAIL
            Message(Self.RETCODE & ', error C25_BCP_WriteFmt ' & c25_getlasterror())
        End

        Self.RETCODE = C25_BCP_Exec(Self.ConnHandle, Address(Self.RowsFetched) )

        Message('Self.RowsFetched ' & Self.RowsFetched)


        Return 0

c25_MsSqlClass.ConvertQToBCP                                                     Procedure(*QUEUE _claQueue, <*String _bcpOut>, <String _targetTable>, <String _formatFileNameUtf8>, <String _bulkFileNameUtf8>)

TheLine                         String(1024)


        Code

            Message('todo ConvertQToBCP')
            Self.St1.Start()
            Self.St1.Append('8.0' & Self.CRLF)
            Self.St1.Append(Records(Self.ClarionFields) & Self.CRLF)

            Free(Self.ClarionFields)

            Self.GetClaDataReflectionAnalyze(_claQueue)

            R# = Records(Self.ClarionFields)
            Loop R# TIMES
                I# = I# + 1
                Get(Self.ClarionFields,I#)
                Clear(TheLine)
                !TheLine = Self.ClarionFields.Id
            End
            Return ''

c25_MsSqlClass.ConvertBCPToQ                                                     Procedure(*QUEUE _claQueue, <*String _bcpImport>, <String _fromTable>, <String _formatFileNameUtf8>, <String _bulkFileNameUtf8>)

    Code



        Return ''

c25_MsSqlClass.BcpBulkImport_ImporBulkFile                                       Procedure(String _formatFileA, String _hostFileA, <*queue _ouputClaQ>)

S               Long
P               Long
T               Long
L               Long
TheLine         String(1024)
F               Long
FindNextField   BOOL
Sz              Long

    Code


        If Self.BCPFormatFileCols &= null
            Self.BCPFormatFileCols &= NEW BCPFormatFileCols_TYPE()
        ELSE
            Free(Self.BCPFormatFileCols)
        End
        Self.St1.Start()
        Self.St1.LoadFile(_formatFileA)
        Self.St1.Split( Chr(13) & Chr(10) )

        R# = Records(Self.St1.lines)
        Self.P = 0
        Loop R# TIMES
            Self.P = Self.P + 1
            If Self.P < 3
                CYCLE
            End
            Get(Self.St1.lines,Self.P)
            If Errorcode() <> 0
                BREAK
            End
            Clear(Self.BCPFormatFileCols)
            TheLine = Self.St1.lines.line

            FindNextField = 0
            L = Len(Clip(TheLine))
            P = 0
            F = 1
            S = 1
            Loop
                P = P + 1
                If P >= L
                    Self.BCPFormatFileCols.Collation = Clip(Left(TheLine[S : P]))
                    If Self.BCPFormatFileCols.Ordinal <> 0
                        Add(Self.BCPFormatFileCols)
                    End
                    BREAK
                End
                If FindNextField
                    If TheLine[p] = ' '
                        CYCLE
                    End
                    FindNextField = 0
                End
                Case F
                Of 1
                    If TheLine[P] = ' '
                        Self.BCPFormatFileCols.Ordinal = TheLine[S : P]
                        F = F + 1
                        S = P + 1
                        FindNextField = True
                    End
                Of 2
                    If TheLine[P] = ' '
                        Self.BCPFormatFileCols.UserDataType = Clip(Left(TheLine[S : P]))
                        F = F + 1
                        S = P + 1
                        FindNextField = True
                    End
                Of 3
                    If TheLine[P] = ' '
                        Self.BCPFormatFileCols.IndicatorLength = Clip(Left(TheLine[S : P]))
                        F = F + 1
                        S = P + 1
                        FindNextField = True
                    End
                Of 4
                    If TheLine[P] = ' '
                        Self.BCPFormatFileCols.UserDataLength = Clip(Left(TheLine[S : P]))
                        F = F + 1
                        S = P + 1
                        FindNextField = True
                    End
                Of 5
                    If TheLine[P] = ' '
                        F = F + 1
                        S = P + 1
                        FindNextField = True
                    End
                Of 6
                    If TheLine[P] = ' '
                        Self.BCPFormatFileCols.IndexServer = Clip(Left(TheLine[S : P]))
                        F = F + 1
                        S = P + 1
                        FindNextField = True
                    End
                Of 7
                    If TheLine[P] = ' '
                        Self.BCPFormatFileCols.ColumnName = Clip(Left(TheLine[S : P]))
                        F = F + 1
                        S = P + 1
                        FindNextField = True
                    End
                End
            End
        End
        Self.BitConverter.QueueToJsonString(Self.BCPFormatFileCols, , , ,'m:\log\BCPFormatFileCols.json')
        Clear(Self.ClarionFieldsArray)

        Free(Self.ClarionFields)

        Self.GetClaDataReflectionAnalyze(_ouputClaQ)
        P = 0
        Loop Records(Self.BCPFormatFileCols) TIMES
            P = P + 1
            Get(Self.BCPFormatFileCols,P)

            I# = 0
            R# = Records(Self.ClarionFields)
            Loop R# TIMES
                I# = I# + 1
                Get(Self.ClarionFields,I#)
                If Clip(Upper(Self.ClarionFields.Name)) = Clip(Upper(Self.BCPFormatFileCols.ColumnName))
                    Self.BCPFormatFileCols.ClaFieldsIndex = I#
                    Put(Self.BCPFormatFileCols)
                    BREAK
                End
            End
        End

        I# = 0
        R# = Records(Self.ClarionFields)
        Loop R# TIMES
            I# = I# + 1
            Get(Self.ClarionFields,I#)
            !Self.ClarionFields.Id = I#
            Self.ClarionFields.Ordinal = I#
            Put(Self.ClarionFields)
            Self.ClarionFieldsArray[I#] = Self.ClarionFields
        End
        Self.ClarionFieldsMaxIndex = I#

        Self.St1.Start()
        Self.St1.LoadFile(_hostFileA)
        P = 0
        Sz = Self.St1.Length()
        Loop
            P = P + 1
            Break
        End

        Return ''

c25_MsSqlClass.BcpBulkImport_Init                                                Procedure(String _tableNameA, Long _batchSize, <*queue _inputClaQ>)

TheIntVal                                                                       Long

SQLRef                                                                          &String
TestString1K                                                                    String(1024)
TestString65K                                                                   String(65000)
Indicator                                                                       Short
IndicatorPtr                                                                    Long
IndicatorLong                                                                   Long

    Code


        Self.OffsetValue                            = 0
        Self.OffsetPtr                              = 0

        If Self.ConnHandle = 0
            Return 0
        End

        If Len(Clip(_tableNameA)) < 1
            Return -2
        End

        If omitted(_inputClaQ) = False
            If _inputClaQ &= NULL
                Return -3
            End
            If Records(_inputClaQ) < 1
                Return -4
            End
            Self.GetMetaColumns('select top 1 * from ' & Clip(_tableNameA), _inputClaQ)
        ELSE
            Self.GetMetaColumns('select top 1 * from ' & Clip(_tableNameA))
        End

        Self.StmtHandle = Self.AllocHandle(,True)
        If Self.StmtHandle = 0
            Return 0
        End

        If Not Self.BulkTableNameA &= NULL
            Dispose(Self.BulkTableNameA)
        End
        If Not Self.BulkTableNameW &= NULL
            Dispose(Self.BulkTableNameW)
        End
        If Not Self.BulkErrorFileW &= NULL
            Dispose(Self.BulkErrorFileW)
        End
        If Not Self.BulkHostFileW &= NULL
            Dispose(Self.BulkHostFileW)
        End
        If Not Self.BulkFormatFileW &= NULL
            Dispose(Self.BulkFormatFileW)
        End

        Self.BulkTableNameA &= Self.BitConverter.BinaryCopy(Clip(_tableNameA) & Chr(0))
        Self.BulkTableNameW     &= Self.BitConverter.AnsiToUtf16(Self.BulkTableNameA,,True)
        Self.BulkErrorFileW     &= Self.BitConverter.AnsiToUtf16('m:\Log\BCP_INIT_ERRORS.txt', , True)
        Self.BulkHostFileW      &= Self.BitConverter.AnsiToUtf16('m:\Log\BCP_HOSTFILE.bcp', , True)
        Self.BulkFormatFileW    &= Self.BitConverter.AnsiToUtf16('m:\Log\BCP_FormatFile.fmt', , True)


        Self.BulkSqlSelectA    &= Self.BitConverter.BinaryCopy('SELECT TOP (1000) * FROM [AllMyDrives].[dbo].[BTestTable]' & Chr(0) )



        Self.RETCODE = C25_Bcp_Init(Self.ConnHandle, 0, Address(Self.BulkHostFileW),  Address(Self.BulkErrorFileW), C25_ODBC_DB_OUT) ! works
        If Self.RETCODE = C25_ODBC_FAIL
            Message(Self.RETCODE & ', error C25_Bcp_Init ' & c25_getlasterror())
        End
        Self.RETCODE = C25_BCP_Control(Self.ConnHandle, C25_BCPHINTSA , Address(Self.BulkSqlSelectA))



        Self.SetTestValues = TRUE

        Self.MsSqlMetaArrayIndex = 0
        R# = Records(Self.MsSqlMeta)

        Self.RETCODE = C25_bcp_columns(Self.ConnHandle, R#)
        If Self.RETCODE = C25_ODBC_FAIL
            Message(Self.RETCODE & ', error C25_bcp_columns ' & c25_getlasterror())
        End


        Loop R# Times
            BREAK

            Self.MsSqlMetaArrayIndex = Self.MsSqlMetaArrayIndex + 1
            Get(Self.MsSqlMeta,Self.MsSqlMetaArrayIndex)
            Case Self.MsSqlMeta.DataType
            Of 'C25_SQL_DECIMAL'
            Of 'C25_SQL_TYPE_TIMESTAMP'
            Of 'C25_SQL_BIT'
            Of 'C25_SQL_BINARY'
            Of 'C25_SQL_LONGVARCHAR'
            Of 'C25_SQL_VARCHAR'
            Of 'C25_SQL_LONGVARBINARY'
            Of 'C25_SQL_VARBINARY'
            Of 'C25_SQL_LONGVARCHAR'
            Of 'C25_SQL_WCHAR'
            Of 'C25_SQL_WLONGVARCHAR'
            Of 'C25_SQL_WVARCHAR'
            Of 'C25_SQL_CHAR'
            Of 'C25_SQL_TINYINT'
            Of 'C25_SQL_SMALLINT'
            Of 'C25_SQL_INTEGER'
                Self.RETCODE = C25_BCP_ColFmt(Self.ConnHandle, Self.MsSqlMetaArrayIndex, C25_ODBC_SQLINT4, 1, C25_SQL_VARLEN_DATA, 0 , 0, Self.MsSqlMetaArrayIndex)
            Of 'C25_SQL_BIGINT'
            Else
            End

            If Self.RETCODE = C25_ODBC_FAIL
                Message(Self.RETCODE & ', error Self.MsSqlMeta.DataType ' & Self.MsSqlMeta.DataType)
            End
        End
        Self.RETCODE = C25_BCP_WriteFmt(Self.ConnHandle, Address(Self.BulkFormatFileW))
        If Self.RETCODE = C25_ODBC_FAIL
            Message(Self.RETCODE & ', error C25_BCP_WriteFmt ' & c25_getlasterror())
        End

        Self.RETCODE = C25_BCP_Exec(Self.ConnHandle, Address(Self.RowsFetched) )

        Message('Self.RowsFetched ' & Self.RowsFetched)


        Return 0

c25_MsSqlClass.BcpBulkSave_Init                                                  Procedure(String _tableNameA, Long _batchSize, <*queue _inputClaQ>)

TheIntVal                                                                       Long

SQLRef                                                                          &String
TestString1K                                                                    String(1024)
TestString65K                                                                   String(65000)
Indicator                                                                       Short
IndicatorPtr                                                                    Long
IndicatorLong                                                                   Long

    Code

        If Len(Clip(_tableNameA)) < 1
            Return -2
        End

        If omitted(_inputClaQ) = False
            If _inputClaQ &= NULL
                Return -3
            End
            If Records(_inputClaQ) < 1
                Return -4
            End
            Self.GetMetaColumns('select top 1 * from ' & Clip(_tableNameA), _inputClaQ)
        Else
            Self.GetMetaColumns('select top 1 * from ' & Clip(_tableNameA))
        End

        Self.StmtHandle = Self.AllocHandle(,True)
        If Self.StmtHandle = 0
            Return 0
        End

        If Not Self.BulkTableNameA &= NULL
            Dispose(Self.BulkTableNameA)
        End
        Self.BulkTableNameA &= Self.BitConverter.BinaryCopy(Clip(_tableNameA) & Chr(0))

        If Not Self.BulkTableNameW &= NULL
            Dispose(Self.BulkTableNameW)
        End

        Self.BulkTableNameW &= Self.BitConverter.AnsiToUtf16(Self.BulkTableNameA,,True)

        Self.OffsetValue                            = 0
        Self.OffsetPtr                              = 0

        If Self.ConnHandle = 0
            Return 0
        End
        If not Self.BulkErrorFileW &= NULL
            Dispose(Self.BulkErrorFileW)
        End
        Self.BulkErrorFileA &= Self.BitConverter.BinaryCopy('m:\Log\BCP_INIT_ERRORS.txt' & Chr(0) )
        Self.BulkErrorFileW &= Self.BitConverter.AnsiToUtf16('m:\Log\BCP_INIT_ERRORS.txt', , True)

        Self.RETCODE = C25_Bcp_Init(Self.ConnHandle, Address(Self.BulkTableNameW), 0, Address(Self.BulkErrorFileW), C25_ODBC_DB_IN)
        If Self.RETCODE = C25_ODBC_FAIL
            Message('error C25_Bcp_Init ' & c25_getlasterror())
            Return 0
        End

        Self.SetTestValues = TRUE

        Self.MsSqlMetaArrayIndex = 0
        R# = Records(Self.MsSqlMeta)
        Loop R# Times
            Self.MsSqlMetaArrayIndex = Self.MsSqlMetaArrayIndex + 1
            Get(Self.MsSqlMeta,Self.MsSqlMetaArrayIndex)
            Self.RETCODE = C25_BCP_Bind(Self.ConnHandle, Self.BcpBoundEmptyStringPtr[Self.MsSqlMetaArrayIndex] , 0, C25_SQL_NULL_DATA ,Self.BcpBoundEmptyStringPtr[Self.MsSqlMetaArrayIndex], 1, C25_ODBC_SQLCHARACTER, Self.MsSqlMetaArrayIndex)
            Self.AssignedNullArray[Self.MsSqlMetaArrayIndex] = TRUE

            If Self.MsSqlMeta.MappedClaQueueIndex = 0 !Self.GetMappedClaQMetaField(Self.MsSqlMeta) = 0
                Cycle
            End


            Case Self.MsSqlMeta.DataType
            Of 'C25_SQL_DECIMAL'
                Self.Bind_Decimal(Self.MsSqlMetaArrayIndex, Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].SQL_DESC_NULLABLE, Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].SQL_DESC_OCTET_LENGTH, |
                    Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].SQL_DESC_PRECISION, |
                    Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].SQL_DESC_SCALE, |
                    Self.ClarionFieldsArray[Self.MsSqlMeta.MappedClaQueueIndex].Characters, |
                    Self.ClarionFieldsArray[Self.MsSqlMeta.MappedClaQueueIndex].Places)
            Of 'C25_SQL_TYPE_TIMESTAMP'
                Self.Bind_DateTime23(Self.MsSqlMetaArrayIndex, Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].SQL_DESC_NULLABLE, Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].SQL_DESC_OCTET_LENGTH)
            Of 'C25_SQL_BIT'
                Self.Bind_Int(Self.MsSqlMetaArrayIndex, Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].SQL_DESC_NULLABLE, 1)
            Of 'C25_SQL_BINARY'
                Self.Bind_Binary(Self.MsSqlMetaArrayIndex, Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].SQL_DESC_NULLABLE, Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].SQL_DESC_OCTET_LENGTH)
            Of 'C25_SQL_LONGVARCHAR'
                Self.Bind_LongVarCharacter(Self.MsSqlMetaArrayIndex, Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].SQL_DESC_NULLABLE, Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].SQL_DESC_OCTET_LENGTH)
            Of 'C25_SQL_VARCHAR'
                Self.Bind_VarBinary(Self.MsSqlMetaArrayIndex, Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].SQL_DESC_NULLABLE, Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].SQL_DESC_OCTET_LENGTH)
            Of 'C25_SQL_LONGVARBINARY'
                Self.Bind_LongVarBinary(Self.MsSqlMetaArrayIndex, Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].SQL_DESC_NULLABLE, Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].SQL_DESC_OCTET_LENGTH)
            Of 'C25_SQL_VARBINARY'
                Self.Bind_VarBinary(Self.MsSqlMetaArrayIndex, Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].SQL_DESC_NULLABLE, Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].SQL_DESC_OCTET_LENGTH)
            Of 'C25_SQL_LONGVARCHAR'
                Self.Bind_LongVarBinary(Self.MsSqlMetaArrayIndex, Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].SQL_DESC_NULLABLE, Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].SQL_DESC_OCTET_LENGTH)
            Of 'C25_SQL_WCHAR'
                Self.Bind_NCharacter(Self.MsSqlMetaArrayIndex, Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].SQL_DESC_NULLABLE, Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].SQL_DESC_OCTET_LENGTH)
             Of 'C25_SQL_WLONGVARCHAR'
                Self.Bind_LongNVarCharacter(Self.MsSqlMetaArrayIndex, Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].SQL_DESC_NULLABLE, Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].SQL_DESC_OCTET_LENGTH)
            Of 'C25_SQL_WVARCHAR'
                If Self.MsSqlMeta.SQL_DESC_PRECISION = 27
                    Self.Bind_DateTime27(Self.MsSqlMetaArrayIndex, Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].SQL_DESC_NULLABLE, Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].SQL_DESC_OCTET_LENGTH)
                Else
                    Self.Bind_NVarCharacter(Self.MsSqlMetaArrayIndex, Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].SQL_DESC_NULLABLE, Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].SQL_DESC_OCTET_LENGTH)
                End
            Of 'C25_SQL_CHAR'
                Self.Bind_Character(Self.MsSqlMetaArrayIndex, Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].SQL_DESC_NULLABLE, Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].SQL_DESC_OCTET_LENGTH)
            Of 'C25_SQL_TINYINT'
                Self.Bind_Int(Self.MsSqlMetaArrayIndex, Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].SQL_DESC_NULLABLE, 1)
            Of 'C25_SQL_SMALLINT'
                Self.Bind_Int(Self.MsSqlMetaArrayIndex, Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].SQL_DESC_NULLABLE, 2)
            Of 'C25_SQL_INTEGER'
                Self.Bind_Int(Self.MsSqlMetaArrayIndex, Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].SQL_DESC_NULLABLE, 4)
            Of 'C25_SQL_BIGINT'
                Self.Bind_Int(Self.MsSqlMetaArrayIndex, Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].SQL_DESC_NULLABLE, 8)
            Else
            End
        End
        Return 0

c25_MsSqlClass.BcpBulkSave_SendRows                                              Procedure(*queue _inputClaQ, <*Long _from>, <*Long _until>, <*Long _currentPointer>, <*real _currentPerc>)

ClaIndex        Long
OffSetStart     Long
OffSetEnd       Long
QRecStr         String(2000000)
QRecStrPtr      Long
Dec20           Decimal(20,0)
Dec20Ptr        Long
UINT64Val       Like(UINT64)
INT64Val        Like(INT64)
UINT64ValPtr    Long
INT64ValPtr     Long
SomeString      String(1024)

    Code

        If _inputClaQ &= NULL
            Return ''
        End


        Self.GetZeroBlockPtr(16000000)

        QRecStrPtr          = Address(QRecStr)
        Dec20Ptr            = Address(Dec20)
        UINT64ValPtr        = Address(UINT64Val)
        INT64ValPtr         = Address(INT64Val)

        Self.NanoSync.StartStopwatch()

        If omitted(_from) = False
            If _from > Records(_inputClaQ)
                _from = Records(_inputClaQ)
                Self.EnumQueueFrom = _from
            Else
                Self.EnumQueueFrom = _from
            End

            If _until < 1
                Self.EnumQueueUntil = Records(_inputClaQ)
            Else
                If _until > Records(_inputClaQ)
                    _until = Records(_inputClaQ)
                    Self.EnumQueueUntil = _until
                Else
                    Self.EnumQueueUntil = _until
                End
            End
            Self.EnumQueueIndex     = Self.EnumQueueFrom - 1
        Else
            Self.EnumQueueFrom      = 1
            Self.EnumQueueUntil     = Records(_inputClaQ)
            Self.EnumQueueIndex     = Self.EnumQueueFrom - 1
        End

        If omitted(_currentPointer) = False
            Self.EnumQueueUpdateStats = True
        ELSE
            Self.EnumQueueUpdateStats = False
        End




L1      Loop 10 times
            loop 300 Times
                Self.EnumQueueIndex = Self.EnumQueueIndex + 1
                Get(_inputClaQ,Self.EnumQueueIndex)
                If Errorcode() <> 0
                    BREAK L1
                End
                QRecStr = _inputClaQ
                Self.MsSqlMetaArrayIndex = 0
                Loop Self.MsSqlMetaArrayMaxIndex Times
                    Self.MsSqlMetaArrayIndex = Self.MsSqlMetaArrayIndex + 1



                    If Self.MsSqlMetaAutoIdColumnIndex = Self.MsSqlMetaArrayIndex
                        Cycle
                    End

                    ClaIndex = Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].MappedClaQueueIndex
                    If ClaIndex = 0
                        Cycle
                    End


                    Execute Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].ExecDataEnum
                        BEGIN ! 1 - BIGINT
                            Self.SetValue_BigInt_ByClaDecimal(Self.MsSqlMetaArrayIndex,  QRecStr[Self.ClarionFieldsArray[ClaIndex].Offset : Self.ClarionFieldsArray[ClaIndex].OffsetEnd])
                            Cycle
                        End
                        BEGIN ! 2 - BINARY
                            If Self.ClarionFieldsArray[ClaIndex].IsRef And Self.ClarionFieldsArray[ClaIndex].IsQueue = 0 And Self.ClarionFieldsArray[ClaIndex].SizeBytes = 8
                                Self.SetValue_Binary_ByRef(Self.MsSqlMetaArrayIndex,QRecStr[Self.ClarionFieldsArray[ClaIndex].Offset : Self.ClarionFieldsArray[ClaIndex].OffsetEnd])
                                Cycle
                            Else
                                Self.SetValue_Binary(Self.MsSqlMetaArrayIndex, QRecStr[Self.ClarionFieldsArray[ClaIndex].Offset : Self.ClarionFieldsArray[ClaIndex].OffsetEnd], Self.ClarionFieldsArray[ClaIndex].SizeBytes)
                                Cycle
                            End
                        End
                        BEGIN ! 3 - BIT
                            Self.SetValue_Bit_ByString(Self.MsSqlMetaArrayIndex,  QRecStr[Self.ClarionFieldsArray[ClaIndex].Offset : Self.ClarionFieldsArray[ClaIndex].OffsetEnd])
                            Cycle
                        End
                        BEGIN ! 4 - CHAR
                            If Self.ClarionFieldsArray[ClaIndex].IsRef And Self.ClarionFieldsArray[ClaIndex].IsQueue = 0 And Self.ClarionFieldsArray[ClaIndex].SizeBytes = 8
                                Self.SetValue_Character_ByRef(Self.MsSqlMetaArrayIndex,QRecStr[Self.ClarionFieldsArray[ClaIndex].Offset : Self.ClarionFieldsArray[ClaIndex].OffsetEnd])
                                Cycle
                            Else
                                Self.SetValue_Character(Self.MsSqlMetaArrayIndex, QRecStr[Self.ClarionFieldsArray[ClaIndex].Offset : Self.ClarionFieldsArray[ClaIndex].OffsetEnd], Self.ClarionFieldsArray[ClaIndex].SizeBytes)
                                Cycle
                            End
                        End
                        BEGIN ! 5 - DATETIME
                        End
                        BEGIN ! 6 - DECIMAL
                            Self.SetValue_Decimal(Self.MsSqlMetaArrayIndex,  QRecStr[Self.ClarionFieldsArray[ClaIndex].Offset : Self.ClarionFieldsArray[ClaIndex].OffsetEnd], Self.ClarionFieldsArray[ClaIndex].SizeBytes)
                        End
                        BEGIN ! 7 - DOUBLE
                        End
                        BEGIN ! 8 - FLOAT
                        End
                        BEGIN ! 9 - GUID
                        End
                        BEGIN ! 10 - INT
                            Self.SetValue_Int4_ByString(Self.MsSqlMetaArrayIndex,  QRecStr[Self.ClarionFieldsArray[ClaIndex].Offset : Self.ClarionFieldsArray[ClaIndex].OffsetEnd])
                            Cycle
                        End
                        BEGIN ! 11 - INTERVAL
                        End
                        BEGIN ! 12 - INTERVAL_DAY
                        End
                        BEGIN ! 13 - INTERVAL_DAY_TO_HOUR
                        End
                        BEGIN ! 14 - INTERVAL_DAY_TO_MINUTE
                        End
                        BEGIN ! 15 - INTERVAL_DAY_TO_SECOND
                        End
                        BEGIN ! 16 - INTERVAL_HOUR
                        End
                        BEGIN ! 17 - INTERVAL_HOUR_TO_MINUTE
                        End
                        BEGIN ! 18 - INTERVAL_HOUR_TO_SECOND
                        End
                        BEGIN ! 19 - INTERVAL_MINUTE
                        End
                        BEGIN ! 20 - INTERVAL_MINUTE_TO_SECOND
                        End
                        BEGIN ! 21 - INTERVAL_MONTH
                        End
                        BEGIN ! 22 - INTERVAL_SECOND
                        End
                        BEGIN ! 23 - INTERVAL_YEAR
                        End
                        BEGIN ! 24 - INTERVAL_YEAR_TO_MONTH
                        End
                        BEGIN ! 25 - LONGVARBINARY
                            If Self.ClarionFieldsArray[ClaIndex].IsRef And Self.ClarionFieldsArray[ClaIndex].IsQueue = 0 And Self.ClarionFieldsArray[ClaIndex].SizeBytes = 8
                                Self.SetValue_LongVarBinary_ByRef(Self.MsSqlMetaArrayIndex,QRecStr[Self.ClarionFieldsArray[ClaIndex].Offset : Self.ClarionFieldsArray[ClaIndex].OffsetEnd])
                                Cycle
                            Else
                                Self.SetValue_LongVarBinary(Self.MsSqlMetaArrayIndex, QRecStr[Self.ClarionFieldsArray[ClaIndex].Offset : Self.ClarionFieldsArray[ClaIndex].OffsetEnd], Self.ClarionFieldsArray[ClaIndex].SizeBytes)
                                Cycle
                            End
                        End
                        BEGIN ! 26 - LONGVARCHAR
                            If Self.ClarionFieldsArray[ClaIndex].IsRef And Self.ClarionFieldsArray[ClaIndex].IsQueue = 0 And Self.ClarionFieldsArray[ClaIndex].SizeBytes = 8
                                Self.SetValue_LongVarCharacter_ByRef(Self.MsSqlMetaArrayIndex,QRecStr[Self.ClarionFieldsArray[ClaIndex].Offset : Self.ClarionFieldsArray[ClaIndex].OffsetEnd])
                                Cycle
                            Else
                                Self.SetValue_LongVarCharacter(Self.MsSqlMetaArrayIndex, QRecStr[Self.ClarionFieldsArray[ClaIndex].Offset : Self.ClarionFieldsArray[ClaIndex].OffsetEnd], Self.ClarionFieldsArray[ClaIndex].SizeBytes)
                                Cycle
                            End
                        End
                        BEGIN ! 27 - NUMERIC
                        End
                        BEGIN ! 28 - REAL
                        End
                        BEGIN ! 29 - SMALLINT
                            Self.SetValue_Int2_ByString(Self.MsSqlMetaArrayIndex,  QRecStr[Self.ClarionFieldsArray[ClaIndex].Offset : Self.ClarionFieldsArray[ClaIndex].OffsetEnd])
                            Cycle
                        End
                        BEGIN ! 30 - TIMESTAMP
                        End
                        BEGIN ! 31 - TINYINT
                            Self.SetValue_Int1_ByString(Self.MsSqlMetaArrayIndex,  QRecStr[Self.ClarionFieldsArray[ClaIndex].Offset : Self.ClarionFieldsArray[ClaIndex].OffsetEnd])
                            Cycle
                        End
                        BEGIN ! 32 - TYPE_DATE
                        End
                        BEGIN ! 33 - TYPE_TIME
                        End
                        BEGIN ! 34 - TYPE_TIMESTAMP
                            Self.SetValue_DateTime23(Self.MsSqlMetaArrayIndex, QRecStr[Self.ClarionFieldsArray[ClaIndex].Offset : Self.ClarionFieldsArray[ClaIndex].OffsetEnd], Self.ClarionFieldsArray[ClaIndex].SizeBytes )
                            Cycle
                        End
                        BEGIN ! 35 - VARBINARY
                            If Self.ClarionFieldsArray[ClaIndex].IsRef And Self.ClarionFieldsArray[ClaIndex].IsQueue = 0 And Self.ClarionFieldsArray[ClaIndex].SizeBytes = 8
                                Self.SetValue_VarBinary_ByRef(Self.MsSqlMetaArrayIndex,QRecStr[Self.ClarionFieldsArray[ClaIndex].Offset : Self.ClarionFieldsArray[ClaIndex].OffsetEnd])
                                Cycle
                            Else
                                Self.SetValue_VarBinary(Self.MsSqlMetaArrayIndex, QRecStr[Self.ClarionFieldsArray[ClaIndex].Offset : Self.ClarionFieldsArray[ClaIndex].OffsetEnd], Self.ClarionFieldsArray[ClaIndex].SizeBytes)
                                Cycle
                            End
                        End
                        BEGIN ! 36 - VARCHAR
                            If Self.ClarionFieldsArray[ClaIndex].IsRef And Self.ClarionFieldsArray[ClaIndex].IsQueue = 0 And Self.ClarionFieldsArray[ClaIndex].SizeBytes = 8
                                Self.SetValue_VarCharacter_ByRef(Self.MsSqlMetaArrayIndex,QRecStr[Self.ClarionFieldsArray[ClaIndex].Offset : Self.ClarionFieldsArray[ClaIndex].OffsetEnd])
                                Cycle
                            Else
                                Self.SetValue_VarCharacter(Self.MsSqlMetaArrayIndex, QRecStr[Self.ClarionFieldsArray[ClaIndex].Offset : Self.ClarionFieldsArray[ClaIndex].OffsetEnd], Self.ClarionFieldsArray[ClaIndex].SizeBytes)
                                Cycle
                            End
                        End
                        BEGIN ! 37 - WCHAR
                            If Self.ClarionFieldsArray[ClaIndex].IsRef And Self.ClarionFieldsArray[ClaIndex].IsQueue = 0 And Self.ClarionFieldsArray[ClaIndex].SizeBytes = 8
                                Self.SetValue_NCharacter_ByRef(Self.MsSqlMetaArrayIndex,QRecStr[Self.ClarionFieldsArray[ClaIndex].Offset : Self.ClarionFieldsArray[ClaIndex].OffsetEnd])
                                Cycle
                            Else
                                Self.SetValue_NCharacter(Self.MsSqlMetaArrayIndex, QRecStr[Self.ClarionFieldsArray[ClaIndex].Offset : Self.ClarionFieldsArray[ClaIndex].OffsetEnd], Len(Clip(QRecStr[Self.ClarionFieldsArray[ClaIndex].Offset : Self.ClarionFieldsArray[ClaIndex].OffsetEnd])) )
                                Cycle
                            End
                        End
                        BEGIN ! 38 - WLONGVARCHAR
                            If Self.ClarionFieldsArray[ClaIndex].IsRef And Self.ClarionFieldsArray[ClaIndex].IsQueue = 0 And Self.ClarionFieldsArray[ClaIndex].SizeBytes = 8
                                Self.SetValue_LongNVarCharacter_ByRef(Self.MsSqlMetaArrayIndex,QRecStr[Self.ClarionFieldsArray[ClaIndex].Offset : Self.ClarionFieldsArray[ClaIndex].OffsetEnd])
                                Cycle
                            Else
                                Self.SetValue_LongNVarCharacter(Self.MsSqlMetaArrayIndex, QRecStr[Self.ClarionFieldsArray[ClaIndex].Offset : Self.ClarionFieldsArray[ClaIndex].OffsetEnd], Len(Clip(QRecStr[Self.ClarionFieldsArray[ClaIndex].Offset : Self.ClarionFieldsArray[ClaIndex].OffsetEnd])) )
                                Cycle
                            End
                        End
                        BEGIN ! 39 - WVARCHAR
                            If Self.MsSqlMetaArray[Self.MsSqlMetaArrayIndex].SQL_DESC_PRECISION <> 27
                                If Self.ClarionFieldsArray[ClaIndex].IsRef And Self.ClarionFieldsArray[ClaIndex].IsQueue = 0 And Self.ClarionFieldsArray[ClaIndex].SizeBytes = 8
                                    Self.SetValue_NVarCharacter_ByRef(Self.MsSqlMetaArrayIndex,QRecStr[Self.ClarionFieldsArray[ClaIndex].Offset : Self.ClarionFieldsArray[ClaIndex].OffsetEnd])
                                    Cycle
                                Else
                                    Self.SetValue_NVarCharacter(Self.MsSqlMetaArrayIndex, QRecStr[Self.ClarionFieldsArray[ClaIndex].Offset : Self.ClarionFieldsArray[ClaIndex].OffsetEnd], Len(Clip(QRecStr[Self.ClarionFieldsArray[ClaIndex].Offset : Self.ClarionFieldsArray[ClaIndex].OffsetEnd])) )
                                    Cycle
                                End
                            Else
                                Self.SetValue_DateTime27(Self.MsSqlMetaArrayIndex, QRecStr[Self.ClarionFieldsArray[ClaIndex].Offset : Self.ClarionFieldsArray[ClaIndex].OffsetEnd], Self.ClarionFieldsArray[ClaIndex].SizeBytes )
                                Cycle
                            End
                        End
                        BEGIN ! 40 - UNKNOWN
                        End
                    End

                End

                Self.RETCODE = C25_bcp_sendrow(Self.ConnHandle)
                If Self.RETCODE = C25_ODBC_FAIL
                Else
                End
            End
            Self.RETCODE = C25_bcp_batch(Self.ConnHandle)
        End
        Self.RETCODE = C25_bcp_done(Self.ConnHandle)
        If Self.RETCODE = C25_ODBC_FAIL
        End
        Self.NanoSync.StopStopWatch()
        Message('done in ' & Self.NanoSync.StopStopWatch())

        Return 0

c25_MsSqlClass.Bind_DisposeColumnArrays                                          Procedure(Long _columnOrdinal)

    Code

        If Self.MemAllocHandle[_columnOrdinal] <> 0
            c25_HeapFree(Self.ProcessHeapHandle, 0, Self.MemAllocHandle[_columnOrdinal])
        End
        Self.MemAllocFullLen[_columnOrdinal]        = 0
        Self.MemAllocHandle[_columnOrdinal]         = 0
        Self.MemAllocValueLen[_columnOrdinal]       = 0
        Self.MemAllocValuePtr[_columnOrdinal]       = 0
        Self.MemIndicatorLen[_columnOrdinal]        = 0
        Self.MemIndicatorValue[_columnOrdinal]      = 0
        Self.MemIsFixedLen[_columnOrdinal]          = 0
        Self.MemNullable[_columnOrdinal]            = 0
        Self.MemValueLen[_columnOrdinal]            = 0
        Self.OctedLen[_columnOrdinal]               = 0

c25_MsSqlClass.Bind_NULL                                                         Procedure(Long _columnOrdinal)

    Code

        Self.RETCODE = C25_BCP_Bind(Self.ConnHandle, Self.BcpBoundEmptyStringPtr[Self.MsSqlMetaArrayIndex] , 0, C25_SQL_NULL_DATA ,Self.BcpBoundEmptyStringPtr[Self.MsSqlMetaArrayIndex], 1, C25_ODBC_SQLCHARACTER, Self.MsSqlMetaArrayIndex)

c25_MsSqlClass.Set_NULL                                                          Procedure(Long _columnOrdinal)

    Code

        Self.SetValue_Indicator(_columnOrdinal, -1)

c25_MsSqlClass.Bind_Int                                                          Procedure(Long _columnOrdinal, Byte _allowNulls, Byte _integerWidth)

    Code

        Case _integerWidth
        Of 1
            Self.Bind_Create(_columnOrdinal, _allowNulls, 1, -1, 1, 1, BindOption:FixedLength)
            Self.RETCODE = C25_BCP_Bind(Self.ConnHandle,Self.MemAllocHandle[_columnOrdinal] , Self.MemIndicatorLen[_columnOrdinal], C25_SQL_VARLEN_DATA, 0, 0, C25_ODBC_SQLINT1, _columnOrdinal)
            Case Self.RETCODE
            Of C25_ODBC_FAIL
                Message('fatal error c25_MsSqlClass.Bind_Int1')
            End
            Self.SetValue_Indicator(_columnOrdinal, -1)
        Of 2
            Self.Bind_Create(_columnOrdinal, _allowNulls, 1, -1, 2, 2, BindOption:FixedLength)
            Self.RETCODE = C25_BCP_Bind(Self.ConnHandle,Self.MemAllocHandle[_columnOrdinal] , Self.MemIndicatorLen[_columnOrdinal], C25_SQL_VARLEN_DATA, 0, 0, C25_ODBC_SQLINT2, _columnOrdinal)
            Case Self.RETCODE
            Of C25_ODBC_FAIL
                Message('fatal error c25_MsSqlClass.Bind_Int2')
            End
            Self.SetValue_Indicator(_columnOrdinal, -1)
        Of 4
            Self.Bind_Create(_columnOrdinal, _allowNulls, 1, -1, 4, 4, BindOption:FixedLength)
            Self.RETCODE = C25_BCP_Bind(Self.ConnHandle,Self.MemAllocHandle[_columnOrdinal] , Self.MemIndicatorLen[_columnOrdinal], C25_SQL_VARLEN_DATA, 0, 0, C25_ODBC_SQLINT4, _columnOrdinal)
            Case Self.RETCODE
            Of C25_ODBC_FAIL
                Message('fatal error c25_MsSqlClass.Bind_Int4')
            End
            Self.SetValue_Indicator(_columnOrdinal, -1)
        Of 8
            Self.Bind_Create(_columnOrdinal, _allowNulls, 1, -1, 8, 8, BindOption:FixedLength)
            Self.RETCODE = C25_BCP_Bind(Self.ConnHandle,Self.MemAllocHandle[_columnOrdinal] , Self.MemIndicatorLen[_columnOrdinal], C25_SQL_VARLEN_DATA, 0, 0, C25_ODBC_SQLINT8, _columnOrdinal)
            Case Self.RETCODE
            Of C25_ODBC_FAIL
                Message('fatal error c25_MsSqlClass.Bind_Int8')
            End
            Self.SetValue_Indicator(_columnOrdinal, -1)
        End

c25_MsSqlClass.Bind_DateTime23                                                   Procedure(Long _columnOrdinal, Byte _allowNulls, Long _octetLength)

    Code

        Self.Bind_Create(_columnOrdinal, _allowNulls, 4, -1, _octetLength, _octetLength, BindOption:FixedLength)
        Self.RETCODE = C25_BCP_Bind(Self.ConnHandle,Self.MemAllocHandle[_columnOrdinal] , Self.MemIndicatorLen[_columnOrdinal], C25_SQL_VARLEN_DATA, 0, 0, C25_ODBC_SQLVARCHAR, _columnOrdinal)
        Case Self.RETCODE
        Of C25_ODBC_FAIL
            Message('fatal error c25_MsSqlClass.Bind_DateTime23')
        End
        Self.SetValue_Indicator(_columnOrdinal, -1)

c25_MsSqlClass.Bind_DateTime27                                                   Procedure(Long _columnOrdinal, Byte _allowNulls, Long _octetLength)

    Code

        Self.Bind_Create(_columnOrdinal, _allowNulls, 4, -1, _octetLength, _octetLength, BindOption:FixedLength)
        Self.RETCODE = C25_BCP_Bind(Self.ConnHandle,Self.MemAllocHandle[_columnOrdinal] , Self.MemIndicatorLen[_columnOrdinal], C25_SQL_VARLEN_DATA, 0, 0, C25_ODBC_SQLVARCHAR, _columnOrdinal)
        Case Self.RETCODE
        Of C25_ODBC_FAIL
            Message('fatal error c25_MsSqlClass.Bind_DateTime27')
        End
        Self.SetValue_Indicator(_columnOrdinal, -1)

c25_MsSqlClass.Bind_Binary                                                       Procedure(Long _columnOrdinal, Byte _allowNulls, Long _octetLength)

    Code

        Self.Bind_Create(_columnOrdinal, _allowNulls, 4, -1, _octetLength, _octetLength, BindOption:FixedLength)
        Self.RETCODE = C25_BCP_Bind(Self.ConnHandle,Self.MemAllocHandle[_columnOrdinal] , Self.MemIndicatorLen[_columnOrdinal], C25_SQL_VARLEN_DATA, 0, 0, C25_ODBC_SQLBINARY, _columnOrdinal)
        Case Self.RETCODE
        Of C25_ODBC_FAIL
            Message('fatal error c25_MsSqlClass.Bind_Binary')
        End
        Self.SetValue_Indicator(_columnOrdinal, -1)

c25_MsSqlClass.Bind_Decimal                                                      Procedure(Long _columnOrdinal, Byte _allowNulls, Long _octetLength, <Long _precision>, <Long _scale>, <Long _claCharacters>, <Long _claPlaces>)

    Code

        Self.DecPrecision[_columnOrdinal] = _precision
        Self.DecScale[_columnOrdinal] = _scale
        Self.DecClaCharacters[_columnOrdinal] = _claCharacters
        Self.DecClaPlaces[_columnOrdinal] = _claPlaces

        Self.Bind_Create(_columnOrdinal, _allowNulls, 4, -1, 50, _octetLength, BindOption:FixedLength)

        Self.RETCODE = C25_BCP_Bind(Self.ConnHandle,Self.MemAllocHandle[_columnOrdinal] , Self.MemIndicatorLen[_columnOrdinal], C25_SQL_VARLEN_DATA, 0, 0, C25_ODBC_SQLVARCHAR, _columnOrdinal)
        Case Self.RETCODE
        Of C25_ODBC_FAIL
            Message('fatal error c25_MsSqlClass.Bind_Decimal')
        End
        Self.SetValue_Indicator(_columnOrdinal, -1)

c25_MsSqlClass.Bind_VarBinary                                                    Procedure(Long _columnOrdinal, Byte _allowNulls, Long _octetLength, <Long _setLength>)

    Code

        If Omitted(_setLength) = False And _setLength > 1
            Self.Bind_Create(_columnOrdinal, _allowNulls, 4, -1, _setLength, _octetLength, BindOption:FixedLength)
        Else
            Self.Bind_Create(_columnOrdinal, _allowNulls, 4, -1, 1, _octetLength, BindOption:FixedLength)
        End
        Self.RETCODE = C25_BCP_Bind(Self.ConnHandle,Self.MemAllocHandle[_columnOrdinal] , Self.MemIndicatorLen[_columnOrdinal], C25_SQL_VARLEN_DATA, 0, 0, C25_ODBC_SQLVARBINARY, _columnOrdinal)
        Case Self.RETCODE
        Of C25_ODBC_FAIL
            Message('fatal error c25_MsSqlClass.Bind_VarBinary')
        End
        Self.SetValue_Indicator(_columnOrdinal, -1)

c25_MsSqlClass.Bind_LongVarBinary                                                Procedure(Long _columnOrdinal, Byte _allowNulls, Long _octetLength, <Long _setLength>)

    Code

        If Omitted(_setLength) = False And _setLength > 1
            Self.Bind_Create(_columnOrdinal, _allowNulls, 4, -1, _setLength, _octetLength, BindOption:FixedLength)
        Else
            Self.Bind_Create(_columnOrdinal, _allowNulls, 4, -1, 1, _octetLength, BindOption:FixedLength)
        End
        Self.RETCODE = C25_BCP_Bind(Self.ConnHandle,Self.MemAllocHandle[_columnOrdinal] , Self.MemIndicatorLen[_columnOrdinal], C25_SQL_VARLEN_DATA, 0, 0, C25_ODBC_SQLBIGBINARY, _columnOrdinal)
        Case Self.RETCODE
        Of C25_ODBC_FAIL
            Message('fatal error c25_MsSqlClass.Bind_LongVarBinary')
        End
        Self.SetValue_Indicator(_columnOrdinal, -1)

c25_MsSqlClass.Bind_Character                                                    Procedure(Long _columnOrdinal, Byte _allowNulls, Long _octetLength)

    Code

        Self.Bind_Create(_columnOrdinal, _allowNulls, 4, -1, _octetLength, _octetLength, BindOption:FixedLength)
        Self.RETCODE = C25_BCP_Bind(Self.ConnHandle,Self.MemAllocHandle[_columnOrdinal] , Self.MemIndicatorLen[_columnOrdinal], C25_SQL_VARLEN_DATA, 0, 0, C25_ODBC_SQLCHARACTER, _columnOrdinal)
        Case Self.RETCODE
        Of C25_ODBC_FAIL
            Message('fatal error c25_MsSqlClass.Bind_Character')
        End
        Self.SetValue_Indicator(_columnOrdinal, -1)

c25_MsSqlClass.Bind_NCharacter                                                   Procedure(Long _columnOrdinal, Byte _allowNulls, Long _octetLength)

    Code

        Self.Bind_Create(_columnOrdinal, _allowNulls, 4, -1, _octetLength, _octetLength, BindOption:FixedLength)
        Self.RETCODE = C25_BCP_Bind(Self.ConnHandle,Self.MemAllocHandle[_columnOrdinal] , Self.MemIndicatorLen[_columnOrdinal], C25_SQL_VARLEN_DATA, 0, 0, C25_ODBC_SQLNCHAR, _columnOrdinal)
        Case Self.RETCODE
        Of C25_ODBC_FAIL
            Message('fatal error c25_MsSqlClass.Bind_NCharacter')
        End
        Self.SetValue_Indicator(_columnOrdinal, -1)

c25_MsSqlClass.Bind_VarCharacter                                                 Procedure(Long _columnOrdinal, Byte _allowNulls, Long _octetLength, <Long _setLength>)

    Code

        If Omitted(_setLength) = False And _setLength > 1
            Self.Bind_Create(_columnOrdinal, _allowNulls, 4, -1, _setLength, _octetLength, BindOption:FixedLength)
        Else
            Self.Bind_Create(_columnOrdinal, _allowNulls, 4, -1, 1, _octetLength, BindOption:FixedLength)
        End
        Self.RETCODE = C25_BCP_Bind(Self.ConnHandle,Self.MemAllocHandle[_columnOrdinal] , Self.MemIndicatorLen[_columnOrdinal], C25_SQL_VARLEN_DATA, 0, 0, C25_ODBC_SQLVARCHAR, _columnOrdinal)
        Case Self.RETCODE
        Of C25_ODBC_FAIL
            Message('fatal error c25_MsSqlClass.Bind_VarCharacter')
        End
        Self.SetValue_Indicator(_columnOrdinal, -1)

c25_MsSqlClass.Bind_NVarCharacter                                                Procedure(Long _columnOrdinal, Byte _allowNulls, Long _octetLength, <Long _setLength>)

    Code

        If Omitted(_setLength) = False And _setLength > 1
            Self.Bind_Create(_columnOrdinal, _allowNulls, 4, -1, _setLength, _octetLength, BindOption:FixedLength)
        Else
            Self.Bind_Create(_columnOrdinal, _allowNulls, 4, -1, 1, _octetLength, BindOption:FixedLength)
        End
        Self.RETCODE = C25_BCP_Bind(Self.ConnHandle,Self.MemAllocHandle[_columnOrdinal] , Self.MemIndicatorLen[_columnOrdinal], C25_SQL_VARLEN_DATA, 0, 0, C25_ODBC_SQLNVARCHAR, _columnOrdinal)
        Case Self.RETCODE
        Of C25_ODBC_FAIL
            Message('fatal error c25_MsSqlClass.Bind_VarCharacter')
        End
        Self.SetValue_Indicator(_columnOrdinal, -1)

c25_MsSqlClass.Bind_LongVarCharacter                                             Procedure(Long _columnOrdinal, Byte _allowNulls, Long _octetLength, <Long _setLength>)

    Code

        If Omitted(_setLength) = False And _setLength > 1
            Self.Bind_Create(_columnOrdinal, _allowNulls, 4, -1, _setLength, _octetLength, BindOption:FixedLength)
        Else
            Self.Bind_Create(_columnOrdinal, _allowNulls, 4, -1, 1, _octetLength, BindOption:FixedLength)
        End
        Self.RETCODE = C25_BCP_Bind(Self.ConnHandle,Self.MemAllocHandle[_columnOrdinal] , Self.MemIndicatorLen[_columnOrdinal], C25_SQL_VARLEN_DATA, 0, 0, C25_ODBC_SQLBIGCHAR, _columnOrdinal)
        Case Self.RETCODE
        Of C25_ODBC_FAIL
            Message('fatal error c25_MsSqlClass.Bind_VarCharacter')
        End
        Self.SetValue_Indicator(_columnOrdinal, -1)

c25_MsSqlClass.Bind_LongNVarCharacter                                            Procedure(Long _columnOrdinal, Byte _allowNulls, Long _octetLength, <Long _setLength>)

    Code

        If Omitted(_setLength) = False And _setLength > 1
            Self.Bind_Create(_columnOrdinal, _allowNulls, 4, -1, _setLength, _octetLength, BindOption:FixedLength)
        Else
            Self.Bind_Create(_columnOrdinal, _allowNulls, 4, -1, 1, _octetLength, BindOption:FixedLength)
        End
        Self.RETCODE = C25_BCP_Bind(Self.ConnHandle,Self.MemAllocHandle[_columnOrdinal] , Self.MemIndicatorLen[_columnOrdinal], C25_SQL_VARLEN_DATA, 0, 0, C25_ODBC_SQLNTEXT, _columnOrdinal)
        Case Self.RETCODE
        Of C25_ODBC_FAIL
            Message('fatal error c25_MsSqlClass.Bind_LongNVarCharacter')
        End
        Self.SetValue_Indicator(_columnOrdinal, -1)

c25_MsSqlClass.SetValue_Bit_ByString                                             Procedure(Long _columnOrdinal, String _value)

    Code

        If Self.MemIndicatorValue[_columnOrdinal] <> 1
            Self.SetValue_Indicator(_columnOrdinal, 1)
        End
        If Val(_value[1]) = 0 Or Val(_value[1]) = 1
            c25_memset(Self.MemAllocValuePtr[_columnOrdinal], Val(_value[1]), 1)
        Else
            Self.SetValue_Indicator(_columnOrdinal, -1)
        End

c25_MsSqlClass.SetValue_Int1_ByString                                            Procedure(Long _columnOrdinal, String _value)

    Code

        If Self.MemIndicatorValue[_columnOrdinal] <> 1
            Self.SetValue_Indicator(_columnOrdinal, 1)
        End
        c25_memset(Self.MemAllocValuePtr[_columnOrdinal], Val(_value[1]), 1)

c25_MsSqlClass.SetValue_Int1                                                     Procedure(Long _columnOrdinal, Long _value)

    Code

        If Self.MemIndicatorValue[_columnOrdinal] <> 1
            Self.SetValue_Indicator(_columnOrdinal, 1)
        End
        c25_memset(Self.MemAllocValuePtr[_columnOrdinal], _value, 1)

c25_MsSqlClass.SetValue_Int2_ByString                                            Procedure(Long _columnOrdinal, String _value)

    Code

        If Self.MemIndicatorValue[_columnOrdinal] <> 2
            Self.SetValue_Indicator(_columnOrdinal, 2)
        End
        c25_memcpy(Self.MemAllocValuePtr[_columnOrdinal], Address(_value), 2)

c25_MsSqlClass.SetValue_Int2                                                     Procedure(Long _columnOrdinal, Long _value)

    Code

        If Self.MemIndicatorValue[_columnOrdinal] <> 2
            Self.SetValue_Indicator(_columnOrdinal, 2)
        End
        c25_memcpy(Self.MemAllocValuePtr[_columnOrdinal], Address(_value), 4)

c25_MsSqlClass.SetValue_Int4_ByString                                            Procedure(Long _columnOrdinal, String _value)

    Code

        If Self.MemIndicatorValue[_columnOrdinal] <> 4
            Self.SetValue_Indicator(_columnOrdinal, 4)
        End
        If Size(_value) = 4
            c25_memcpy(Self.MemAllocValuePtr[_columnOrdinal], Address(_value), 4)
        ELSE
            Message('error size int4')
        End

c25_MsSqlClass.SetValue_Int4                                                     Procedure(Long _columnOrdinal, Long _value)

    Code

        If Self.MemIndicatorValue[_columnOrdinal] <> 4
            Self.SetValue_Indicator(_columnOrdinal, 4)
        End
        c25_memcpy(Self.MemAllocValuePtr[_columnOrdinal], _value, 4)

c25_MsSqlClass.SetValue_DateTime23                                               Procedure(Long _columnOrdinal, String _clarionDecValue, Long _size)

    Code

        Self.Dec20 = Self.ClaDecToDecimal(_clarionDecValue,0)
        If Self.Dec20 = 0
            Self.SetValue_Indicator(_columnOrdinal, -1)
        Else
            Self.DateTime23String = Self.NanoSync.DecToSQL_TIMESTAMP_STRUCT(Format(Self.Dec20,@N_20))
            c25_memcpy(Self.MemAllocValuePtr[_columnOrdinal], Self.DateTime23StringPtr, 23)
            Self.SetValue_Indicator(_columnOrdinal, 23)
        End

c25_MsSqlClass.SetValue_DateTime27                                               Procedure(Long _columnOrdinal, String _clarionDecValue, Long _size)

    Code

        Self.Dec20 = Self.ClaDecToDecimal(_clarionDecValue,0)
        If Self.Dec20 = 0
            Self.SetValue_Indicator(_columnOrdinal, -1)
        Else
            Self.DateTime27String = Self.NanoSync.DecToSQL_TIMESTAMP_STRUCT(Format(Self.Dec20,@N_20))
            c25_memcpy(Self.MemAllocValuePtr[_columnOrdinal], Self.DateTime27StringPtr, 27)
            Self.SetValue_Indicator(_columnOrdinal, 27)
        End

c25_MsSqlClass.SetValue_Decimal                                                  Procedure(Long _columnOrdinal, String _clarionDecValue, Long _size)

    Code

        Self.DecimalInString = Self.ClaDecToDecimal(_clarionDecValue , Self.DecClaPlaces[_columnOrdinal])
        If len(Clip(Self.DecimalInString)) < 1
            Self.DecimalInString = '0'
        End
        Self.ClearAnsiBlock(Self.MemAllocValuePtr[_columnOrdinal], Self.MemAllocValueLen[_columnOrdinal])
        If Len(Clip(Self.DecimalInString)) < Self.MemAllocValueLen[_columnOrdinal]
            c25_memcpy(Self.MemAllocValuePtr[_columnOrdinal], Self.DecimalInStringPtr,Self.OctedLen[_columnOrdinal])
            If Self.MemIndicatorValue[_columnOrdinal] <> Self.OctedLen[_columnOrdinal]
                Self.SetValue_Indicator(_columnOrdinal,Self.OctedLen[_columnOrdinal])
            End
        End

c25_MsSqlClass.SetValue_Binary                                                   Procedure(Long _columnOrdinal, String _BinaryValue, Long _size)

    Code

        If _size <= Self.MemAllocValueLen[_columnOrdinal] And _size > 0
            c25_memcpy(Self.MemAllocValuePtr[_columnOrdinal], Address(_BinaryValue), _size)
        Else
            c25_memcpy(Self.MemAllocValuePtr[_columnOrdinal], Address(_BinaryValue), Self.MemAllocValueLen[_columnOrdinal])
        End
        Self.SetValue_Indicator(_columnOrdinal, Self.MemAllocValueLen[_columnOrdinal])

c25_MsSqlClass.SetValue_Binary_ByRef                                             Procedure(Long _columnOrdinal, String _BinaryValueRef)

    Code

        Self.EF_AddressAndSizeFromAny = _BinaryValueRef
        If Self.EF_AdrGroup.EF_PtrAddress <> 0 And Self.EF_AdrGroup.EF_PtrSize > 0
            If Self.EF_AdrGroup.EF_PtrSize <= Self.MemAllocValueLen[_columnOrdinal]
                Self.ZeroOutBlock(Self.MemAllocValuePtr[_columnOrdinal], Self.MemAllocValueLen[_columnOrdinal])
                c25_memcpy(Self.MemAllocValuePtr[_columnOrdinal],  Self.EF_AdrGroup.EF_PtrAddress, Self.EF_AdrGroup.EF_PtrSize)
                Self.SetValue_Indicator(_columnOrdinal, Self.MemAllocValueLen[_columnOrdinal])
            ELSE
                c25_memcpy(Self.MemAllocValuePtr[_columnOrdinal],  Self.EF_AdrGroup.EF_PtrAddress, Self.MemAllocValueLen[_columnOrdinal])
                Self.SetValue_Indicator(_columnOrdinal, Self.MemAllocValueLen[_columnOrdinal])
            End
        Else
            Self.SetValue_Indicator(_columnOrdinal, -1)
        End

c25_MsSqlClass.SetValue_VarBinary                                                Procedure(Long _columnOrdinal, String _binaryValue, Long _size)

    Code

        If _size > Self.MemAllocValueLen[_columnOrdinal]
            Self.Bind_VarBinary(_columnOrdinal, Self.MemNullable[_columnOrdinal], Self.OctedLen[_columnOrdinal], _size)
        Else
            Self.MemAllocValueLen[_columnOrdinal] = _size
        End
        Self.SetValue_Indicator(_columnOrdinal, _size)
        c25_memcpy(Self.MemAllocValuePtr[_columnOrdinal], Address(_binaryValue), _size)

c25_MsSqlClass.SetValue_VarBinary_ByRef                                          Procedure(Long _columnOrdinal, String _binaryValue)

    Code

        Self.EF_AddressAndSizeFromAny = _binaryValue
        If Self.EF_AdrGroup.EF_PtrAddress <> 0 And Self.EF_AdrGroup.EF_PtrSize > 0
            If Self.EF_AdrGroup.EF_PtrSize > Self.MemAllocValueLen[_columnOrdinal]
                Self.Bind_VarBinary(_columnOrdinal, Self.MemNullable[_columnOrdinal], Self.OctedLen[_columnOrdinal], Self.EF_AdrGroup.EF_PtrSize)
            End
            Self.ZeroOutBlock(Self.MemAllocValuePtr[_columnOrdinal], Self.MemAllocValueLen[_columnOrdinal])
            c25_memcpy(Self.MemAllocValuePtr[_columnOrdinal],  Self.EF_AdrGroup.EF_PtrAddress, Self.EF_AdrGroup.EF_PtrSize)
            Self.SetValue_Indicator(_columnOrdinal, Self.EF_AdrGroup.EF_PtrSize)
        Else
            Self.SetValue_Indicator(_columnOrdinal, -1)
        End

c25_MsSqlClass.SetValue_LongVarBinary                                            Procedure(Long _columnOrdinal, String _binaryValue, Long _size)

    Code

        If _size > Self.MemAllocValueLen[_columnOrdinal]
            Self.Bind_LongVarBinary(_columnOrdinal, Self.MemNullable[_columnOrdinal], Self.OctedLen[_columnOrdinal], _size)
        Else
            Self.MemAllocValueLen[_columnOrdinal] = _size
        End
        Self.SetValue_Indicator(_columnOrdinal, _size)
        Self.ZeroOutBlock(Self.MemAllocValuePtr[_columnOrdinal], Self.MemAllocValueLen[_columnOrdinal])
        c25_memcpy(Self.MemAllocValuePtr[_columnOrdinal], Address(_binaryValue), _size)

c25_MsSqlClass.SetValue_LongVarBinary_ByRef                                      Procedure(Long _columnOrdinal, String _binaryValueRef)

    Code

        Self.EF_AddressAndSizeFromAny = _binaryValueRef
        If Self.EF_AdrGroup.EF_PtrAddress <> 0 And Self.EF_AdrGroup.EF_PtrSize > 0
            If Self.EF_AdrGroup.EF_PtrSize > Self.MemAllocValueLen[_columnOrdinal]
                Self.Bind_LongVarBinary(_columnOrdinal, Self.MemNullable[_columnOrdinal], Self.OctedLen[_columnOrdinal], Self.EF_AdrGroup.EF_PtrSize)
            End
            Self.ZeroOutBlock(Self.MemAllocValuePtr[_columnOrdinal], Self.MemAllocValueLen[_columnOrdinal])
            c25_memcpy(Self.MemAllocValuePtr[_columnOrdinal],  Self.EF_AdrGroup.EF_PtrAddress, Self.EF_AdrGroup.EF_PtrSize)
            Self.SetValue_Indicator(_columnOrdinal, Self.EF_AdrGroup.EF_PtrSize)
        Else
            Self.SetValue_Indicator(_columnOrdinal, -1)
        End

c25_MsSqlClass.SetValue_Character                                                Procedure(Long _columnOrdinal, String _characterValue, Long _size)

    Code

        If _size <= Self.MemAllocValueLen[_columnOrdinal] And _size > 0
            c25_memcpy(Self.MemAllocValuePtr[_columnOrdinal], Address(_characterValue), _size)
        Else
            c25_memcpy(Self.MemAllocValuePtr[_columnOrdinal], Address(_characterValue), Self.MemAllocValueLen[_columnOrdinal])
        End
        Self.SetValue_Indicator(_columnOrdinal, Self.MemAllocValueLen[_columnOrdinal])

c25_MsSqlClass.SetValue_Character_ByRef                                          Procedure(Long _columnOrdinal, String _characterValueRef)

    Code

        Self.EF_AddressAndSizeFromAny = _characterValueRef
        If Self.EF_AdrGroup.EF_PtrAddress <> 0 And Self.EF_AdrGroup.EF_PtrSize > 0
            If Self.EF_AdrGroup.EF_PtrSize <= Self.MemAllocValueLen[_columnOrdinal]
                Self.ZeroOutBlock(Self.MemAllocValuePtr[_columnOrdinal], Self.MemAllocValueLen[_columnOrdinal])
                c25_memcpy(Self.MemAllocValuePtr[_columnOrdinal],  Self.EF_AdrGroup.EF_PtrAddress, Self.EF_AdrGroup.EF_PtrSize)
                Self.SetValue_Indicator(_columnOrdinal, Self.MemAllocValueLen[_columnOrdinal])
            ELSE
                c25_memcpy(Self.MemAllocValuePtr[_columnOrdinal],  Self.EF_AdrGroup.EF_PtrAddress, Self.MemAllocValueLen[_columnOrdinal])
                Self.SetValue_Indicator(_columnOrdinal, Self.MemAllocValueLen[_columnOrdinal])
            End
        Else
            Self.SetValue_Indicator(_columnOrdinal, -1)
        End

c25_MsSqlClass.GetUtf16SpacesBlockPtr                                            Procedure(Long _size)

    Code

        If Self.Utf16SpacesBlockSize < _size

            If Self.Utf16SpacesBlockPtr <> 0
                c25_HeapFree(Self.ProcessHeapHandle, 0, Self.Utf16SpacesBlockPtr)
                Self.Utf16SpacesBlockPtr = 0
            End
            Self.Utf16SpacesBlockPtr = c25_HeapAlloc(Self.ProcessHeapHandle, 8, _size)
            Self.P = Self.Utf16SpacesBlockPtr - 2
            Self.T = Self.Utf16SpacesBlockPtr + _size - 1
            Loop
                Self.P = Self.P + 2
                If Self.P >= Self.T
                    BREAK
                End
                c25_memset(Self.P , 32, 1)
            End
            Self.Utf16SpacesBlockSize = _size
        End
        Return Self.Utf16SpacesBlockPtr

c25_MsSqlClass.GetZeroBlockPtr                                                   Procedure(Long _size)

    Code

        If Self.ZeroBlockSize < _size

            If Self.ZeroBlockPtr <> 0
                c25_HeapFree(Self.ProcessHeapHandle, 0, Self.ZeroBlockPtr)
                Self.Utf16SpacesBlockPtr = 0
            End
            Self.ZeroBlockPtr = c25_HeapAlloc(Self.ProcessHeapHandle, 8, _size)
            Self.ZeroBlockSize = _size
        End
        Return Self.ZeroBlockPtr

c25_MsSqlClass.GetClearedAnsiBlockPtr                                                   Procedure(Long _size)

    Code

        If Self.AnsiBlockSize < _size
            If Self.AnsiBlockPtr <> 0
                c25_HeapFree(Self.ProcessHeapHandle, 0, Self.AnsiBlockPtr)
                Self.AnsiBlockPtr = 0
            End
            Self.AnsiBlockPtr = c25_HeapAlloc(Self.ProcessHeapHandle, 8, _size)
            Self.AnsiBlockSize = _size
            c25_memset(Self.AnsiBlockPtr , 32, Self.AnsiBlockSize)
        End
        Return Self.AnsiBlockPtr

c25_MsSqlClass.ClearUtf16Block                                                   Procedure(Long _targetPtr, Long _size)

    Code

        c25_memcpy(_targetPtr, Self.GetUtf16SpacesBlockPtr(_size), _size)

c25_MsSqlClass.ZeroOutBlock                                                      Procedure(Long _targetPtr, Long _size)

    Code

        c25_memcpy(_targetPtr, Self.GetZeroBlockPtr(_size), _size)

c25_MsSqlClass.ClearAnsiBlock                                                      Procedure(Long _targetPtr, Long _size)

    Code

        c25_memcpy(_targetPtr, Self.GetClearedAnsiBlockPtr(_size), _size)

c25_MsSqlClass.SetValue_NCharacter                                               Procedure(Long _columnOrdinal, String _nCharacterValue, Long _size)

ThisLine  String(65000)

    Code

        Self.ClearUtf16Block(Self.MemAllocValuePtr[_columnOrdinal], Self.MemAllocValueLen[_columnOrdinal])

        If _size <= Self.MemAllocValueLen[_columnOrdinal] And _size > 0
            c25_memcpy(Self.MemAllocValuePtr[_columnOrdinal], Address(_nCharacterValue), _size)
            Self.SetValue_Indicator(_columnOrdinal, Self.MemAllocValueLen[_columnOrdinal])
        ElsIf _size > 0
            c25_memcpy(Self.MemAllocValuePtr[_columnOrdinal], Address(_nCharacterValue), Self.MemAllocValueLen[_columnOrdinal])
            Self.SetValue_Indicator(_columnOrdinal, Self.MemAllocValueLen[_columnOrdinal])
        ELSE
            Self.SetValue_Indicator(_columnOrdinal, -1)
        End

c25_MsSqlClass.SetValue_NCharacter_ByRef                                         Procedure(Long _columnOrdinal, String _nCharacterValueRef)

    Code

        Self.ClearUtf16Block(Self.MemAllocValuePtr[_columnOrdinal], Self.MemAllocValueLen[_columnOrdinal])
        Self.EF_AddressAndSizeFromAny = _nCharacterValueRef
        If Self.EF_AdrGroup.EF_PtrAddress <> 0 And Self.EF_AdrGroup.EF_PtrSize > 0
            If Self.EF_AdrGroup.EF_PtrSize <= Self.MemAllocValueLen[_columnOrdinal]
                Self.ZeroOutBlock(Self.MemAllocValuePtr[_columnOrdinal], Self.MemAllocValueLen[_columnOrdinal])
                c25_memcpy(Self.MemAllocValuePtr[_columnOrdinal],  Self.EF_AdrGroup.EF_PtrAddress, Self.EF_AdrGroup.EF_PtrSize)
                Self.SetValue_Indicator(_columnOrdinal, Self.MemAllocValueLen[_columnOrdinal])
            ELSE
                c25_memcpy(Self.MemAllocValuePtr[_columnOrdinal],  Self.EF_AdrGroup.EF_PtrAddress, Self.MemAllocValueLen[_columnOrdinal])
                Self.SetValue_Indicator(_columnOrdinal, Self.MemAllocValueLen[_columnOrdinal])
            End
        Else
            Self.SetValue_Indicator(_columnOrdinal, -1)
        End

c25_MsSqlClass.SetValue_VarCharacter                                             Procedure(Long _columnOrdinal, String _CharacterValue, Long _size)

    Code

        If _size > Self.MemAllocValueLen[_columnOrdinal]
            Self.Bind_VarCharacter(_columnOrdinal, Self.MemNullable[_columnOrdinal], Self.OctedLen[_columnOrdinal], _size)
        Else
            Self.MemAllocValueLen[_columnOrdinal] = _size
        End
        Self.SetValue_Indicator(_columnOrdinal, _size)
        c25_memcpy(Self.MemAllocValuePtr[_columnOrdinal], Address(_CharacterValue), _size)

c25_MsSqlClass.SetValue_VarCharacter_ByRef                                       Procedure(Long _columnOrdinal, String _characterValueRef)

    Code

        Self.EF_AddressAndSizeFromAny = _characterValueRef
        If Self.EF_AdrGroup.EF_PtrAddress <> 0 And Self.EF_AdrGroup.EF_PtrSize > 0
            If Self.EF_AdrGroup.EF_PtrSize > Self.MemAllocValueLen[_columnOrdinal]
                Self.Bind_VarCharacter(_columnOrdinal, Self.MemNullable[_columnOrdinal], Self.OctedLen[_columnOrdinal], Self.EF_AdrGroup.EF_PtrSize)
            End
            c25_memcpy(Self.MemAllocValuePtr[_columnOrdinal],  Self.EF_AdrGroup.EF_PtrAddress, Self.EF_AdrGroup.EF_PtrSize)
            Self.SetValue_Indicator(_columnOrdinal, Self.EF_AdrGroup.EF_PtrSize)
        Else
            Self.SetValue_Indicator(_columnOrdinal, -1)
        End

c25_MsSqlClass.SetValue_LongVarCharacter                                         Procedure(Long _columnOrdinal, String _CharacterValue, Long _size)

    Code

        If _size > Self.MemAllocValueLen[_columnOrdinal]
            Self.Bind_LongVarCharacter(_columnOrdinal, Self.MemNullable[_columnOrdinal], Self.OctedLen[_columnOrdinal], _size)
        Else
            Self.MemAllocValueLen[_columnOrdinal] = _size
        End
        Self.SetValue_Indicator(_columnOrdinal, _size)
        Self.ZeroOutBlock(Self.MemAllocValuePtr[_columnOrdinal], Self.MemAllocValueLen[_columnOrdinal])
        c25_memcpy(Self.MemAllocValuePtr[_columnOrdinal], Address(_CharacterValue), _size)

c25_MsSqlClass.SetValue_LongVarCharacter_ByRef                                   Procedure(Long _columnOrdinal, String _CharacterValueRef)

    Code

        Self.EF_AddressAndSizeFromAny = _CharacterValueRef
        If Self.EF_AdrGroup.EF_PtrAddress <> 0 And Self.EF_AdrGroup.EF_PtrSize > 0
            If Self.EF_AdrGroup.EF_PtrSize > Self.MemAllocValueLen[_columnOrdinal]
                Self.Bind_LongVarCharacter(_columnOrdinal, Self.MemNullable[_columnOrdinal], Self.OctedLen[_columnOrdinal], Self.EF_AdrGroup.EF_PtrSize)
            End
            Self.ZeroOutBlock(Self.MemAllocValuePtr[_columnOrdinal], Self.MemAllocValueLen[_columnOrdinal])
            c25_memcpy(Self.MemAllocValuePtr[_columnOrdinal],  Self.EF_AdrGroup.EF_PtrAddress, Self.EF_AdrGroup.EF_PtrSize)
            Self.SetValue_Indicator(_columnOrdinal, Self.EF_AdrGroup.EF_PtrSize)
        Else
            Self.SetValue_Indicator(_columnOrdinal, -1)
        End

c25_MsSqlClass.SetValue_LongNVarCharacter                                        Procedure(Long _columnOrdinal, String _nCharacterValue, Long _size)

    Code

        If _size > Self.MemAllocValueLen[_columnOrdinal]
            Self.Bind_LongNVarCharacter(_columnOrdinal, Self.MemNullable[_columnOrdinal], Self.OctedLen[_columnOrdinal], _size)
            Self.SetValue_Indicator(_columnOrdinal, _size)
            c25_memcpy(Self.MemAllocValuePtr[_columnOrdinal], Address(_nCharacterValue), _size)
        ElsIf _size > 0
            Self.MemAllocValueLen[_columnOrdinal] = _size
            Self.SetValue_Indicator(_columnOrdinal, _size)
            c25_memcpy(Self.MemAllocValuePtr[_columnOrdinal], Address(_nCharacterValue), _size)
        ELSE
            Self.SetValue_Indicator(_columnOrdinal, -1)
        End

c25_MsSqlClass.SetValue_LongNVarCharacter_ByRef                                  Procedure(Long _columnOrdinal, String _nCharacterValueRef)

    Code

        Self.EF_AddressAndSizeFromAny = _nCharacterValueRef
        If Self.EF_AdrGroup.EF_PtrAddress <> 0 And Self.EF_AdrGroup.EF_PtrSize > 0
            If Self.EF_AdrGroup.EF_PtrSize > Self.MemAllocValueLen[_columnOrdinal]
                Self.Bind_LongNVarCharacter(_columnOrdinal, Self.MemNullable[_columnOrdinal], Self.OctedLen[_columnOrdinal], Self.EF_AdrGroup.EF_PtrSize)
            End
            c25_memcpy(Self.MemAllocValuePtr[_columnOrdinal],  Self.EF_AdrGroup.EF_PtrAddress, Self.EF_AdrGroup.EF_PtrSize)
            Self.SetValue_Indicator(_columnOrdinal, Self.EF_AdrGroup.EF_PtrSize)
        Else
            Self.SetValue_Indicator(_columnOrdinal, -1)
        End

c25_MsSqlClass.SetValue_NVarCharacter                                            Procedure(Long _columnOrdinal, String _nCharacterValue, Long _size)

    Code

        If _size > Self.MemAllocValueLen[_columnOrdinal]
            Self.Bind_nVarCharacter(_columnOrdinal, Self.MemNullable[_columnOrdinal], Self.OctedLen[_columnOrdinal], _size)
            Self.MemAllocValueLen[_columnOrdinal] = _size
            Self.SetValue_Indicator(_columnOrdinal, _size)
            c25_memcpy(Self.MemAllocValuePtr[_columnOrdinal], Address(_nCharacterValue), _size)
        ElsIf _size > 0
            Self.MemAllocValueLen[_columnOrdinal] = _size
            Self.SetValue_Indicator(_columnOrdinal, _size)
            c25_memcpy(Self.MemAllocValuePtr[_columnOrdinal], Address(_nCharacterValue), _size)
        Else
            Self.SetValue_Indicator(_columnOrdinal, -1)
        End

c25_MsSqlClass.SetValue_nVarCharacter_ByRef                                      Procedure(Long _columnOrdinal, String _nCharacterValueRef)

    Code

        Self.EF_AddressAndSizeFromAny = _nCharacterValueRef
        If Self.EF_AdrGroup.EF_PtrAddress <> 0 And Self.EF_AdrGroup.EF_PtrSize > 0
            If Self.EF_AdrGroup.EF_PtrSize > Self.MemAllocValueLen[_columnOrdinal]
                Self.Bind_nVarCharacter(_columnOrdinal, Self.MemNullable[_columnOrdinal], Self.OctedLen[_columnOrdinal], Self.EF_AdrGroup.EF_PtrSize)
            End
            c25_memcpy(Self.MemAllocValuePtr[_columnOrdinal],  Self.EF_AdrGroup.EF_PtrAddress, Self.EF_AdrGroup.EF_PtrSize)
            Self.SetValue_Indicator(_columnOrdinal, Self.EF_AdrGroup.EF_PtrSize)
        Else
            Self.SetValue_Indicator(_columnOrdinal, -1)
        End

c25_MsSqlClass.SetValue_NULL                                                     Procedure(Long _columnOrdinal)

    Code

        If Self.MemNullable[_columnOrdinal] = False
            Message('ERROR c25_MsSqlClass.SetValue_NULL at columnOridinal ' &  _columnOrdinal & ', column is not nullable.')
        Else
            Self.MemIndicatorValue[_columnOrdinal] = -1
            c25_memcpy(Self.MemAllocHandle[_columnOrdinal], Self.MemIndicatorValuePtr[_columnOrdinal], Self.MemIndicatorLen[_columnOrdinal])
        End

c25_MsSqlClass.SetValue_Indicator                                                Procedure(Long _columnOrdinal, Long _indicator)

    Code

    Self.MemIndicatorValue[_columnOrdinal] = _indicator
    c25_memcpy(Self.MemAllocHandle[_columnOrdinal], Self.MemIndicatorValuePtr[_columnOrdinal], Self.MemIndicatorLen[_columnOrdinal])

c25_MsSqlClass.SetValue_BigInt_ByNumeric                                         Procedure(Long _columnOrdinal, String _formattedDecValue)

    Code

        Self.Decimal20 = _formattedDecValue
        i64FromDecimal(Self.Int64Val, Self.Decimal20)
        Self.SetValue_BigInt_ByInt64(_columnOrdinal,Self.Int64Val)

c25_MsSqlClass.SetValue_BigInt_ByClaDecimal                                      Procedure(Long _columnOrdinal, String _value)

    Code

        Self.SetValue_BigInt_ByNumeric(_columnOrdinal, Self.ClaDecToDecimal(_value, 0))

c25_MsSqlClass.SetValue_BigInt_ByInt64                                           Procedure(Long _columnOrdinal, String _value)

    Code

        If Self.MemIndicatorValue[_columnOrdinal] <> 8
            Self.SetValue_Indicator(_columnOrdinal, 8)
        End
            If Size(_value) <> 8
            End
        c25_memcpy(Self.MemAllocValuePtr[_columnOrdinal], Address(_value), 8)

c25_MsSqlClass.Bind_Create                                                       Procedure(Long _columnOrdinal, bool _allowNulls, Long _indicatorLen, Long _indicatorValue, Long _memAllocValueLen, Long _octedLen, Long _bindOptions)

    Code

        Self.Bind_DisposeColumnArrays(_columnOrdinal)

        Self.MemAllocValueLen[_columnOrdinal]       = _memAllocValueLen
        Self.MemIndicatorLen[_columnOrdinal]        = _indicatorLen
        Self.MemIndicatorValue[_columnOrdinal]      = _indicatorValue
        If BAND(_bindOptions,BindOption:FixedLength) <> 0
            Self.MemIsFixedLen[_columnOrdinal] = True
        End
        Self.MemNullable[_columnOrdinal]            = _allowNulls
        Self.OctedLen[_columnOrdinal]               = _octedLen

        If _memAllocValueLen > 0
            Self.MemAllocFullLen[_columnOrdinal]        = Self.MemIndicatorLen[_columnOrdinal] + Self.MemAllocValueLen[_columnOrdinal]
            Self.MemAllocHandle[_columnOrdinal]         = c25_HeapAlloc(Self.ProcessHeapHandle, 8, Self.MemAllocFullLen[_columnOrdinal])
            Self.MemAllocValuePtr[_columnOrdinal]       = Self.MemAllocHandle[_columnOrdinal] + Self.MemIndicatorLen[_columnOrdinal]

        End

c25_MsSqlClass.Connect                                                           Procedure(<String _connString>,<Byte _disconnectFirst>,<Long _driver> , <Byte _useBCP>)

    Code

        If OMITTED(_disconnectFirst) = False
            If Self.ConnHandle <> 0
                Return Self.ConnHandle
            End
        End
        If OMITTED(_connString)
            If Len(Clip(Self.ConnectionStringAnsi)) = 0
                Self.ConnectionStringAnsi = 'Driver=' & Chr(07Bh) & 'SQL Server Native Client 11.0' & Chr(07Dh) & ';Server=.;Database=' & 'Master' & ';Trusted_Connection=Yes;Packet Size=32768;MultipleActiveResultSets=True'
                If not Self.ConnectionStringUtf16 &= NULL
                    Dispose(Self.ConnectionStringUtf16)
                End
                Self.ConnectionStringUtf16 &= Self.BitConverter.AnsiToUtf16(Self.ConnectionStringAnsi,,true)
            End
        ELSE
            Self.ConnectionStringAnsi = _connString
            If not Self.ConnectionStringUtf16 &= NULL
                Dispose(Self.ConnectionStringUtf16)
            End
            Self.ConnectionStringUtf16 &= Self.BitConverter.AnsiToUtf16(Self.ConnectionStringAnsi,,true)
        End
        If Self.EnvHandle = 0
            Self.SQLRETURN = C25_SQLAllocHandle(C25_SQL_HANDLE_ENV,0,Address(Self.EnvHandle))
        End
        Self.SQLRETURN = C25_SQLSetEnvAttr(Self.EnvHandle, C25_SQL_ATTR_ODBC_VERSION, 380, C25_SQL_IS_INTEGER)
        If _useBCP = TRUE
            Self.SQLRETURN  = C25_SQLAllocHandle(C25_SQL_HANDLE_DBC,Self.EnvHandle,ADDRESS(Self.ConnHandle))
            If Self.SQLRETURN <> C25_SQL_SUCCESS and Self.SQLRETURN <> C25_SQL_SUCCESS_WITH_INFO
                Return 0
            End
            Self.SQLRETURN  = C25_SQLSetConnectAttr(Self.ConnHandle, C25_SQL_COPT_SS_BCP, C25_SQL_BCP_ON, C25_SQL_IS_INTEGER)
            If Self.SQLRETURN <> C25_SQL_SUCCESS and Self.SQLRETURN <> C25_SQL_SUCCESS_WITH_INFO
                Return 0
            End
            Self.SQLRETURN = C25_SqlDriverConnectW(Self.ConnHandle, 0, Address(Self.ConnectionStringUtf16), C25_SQL_NTS, 0, 0, 0, C25_SQL_DRIVER_COMPLETE_REQUIRED)
            If Self.SQLRETURN = C25_SQL_SUCCESS Or Self.SQLRETURN = C25_SQL_SUCCESS_WITH_INFO
                Self.ConnectionIsOpen = True
            Else
                Self.SQLGetDiagRec(Self.ConnHandle)
                Message('conn failed ' & Self.SQLRETURN)
            End
        Else
            Self.SQLRETURN  = C25_SQLAllocHandle(C25_SQL_HANDLE_DBC,Self.EnvHandle,ADDRESS(Self.ConnHandle))
            If Self.SQLRETURN <> C25_SQL_SUCCESS and Self.SQLRETURN <> C25_SQL_SUCCESS_WITH_INFO
                Return 0
            End
            Self.SQLRETURN = C25_SqlDriverConnectW(Self.ConnHandle, 0, Address(Self.ConnectionStringUtf16), C25_SQL_NTS, 0, 0, 0, 1)
            If Self.SQLRETURN = C25_SQL_SUCCESS Or Self.SQLRETURN = C25_SQL_SUCCESS_WITH_INFO
                Self.ConnectionIsOpen = True
            Else
                Message('conn failed')
            End
        End

        Return Self.ConnHandle

c25_MsSqlClass.ClaDecToDecimal                                                   Procedure(String _claDecStored, Long _places)

    Code

        Clear(Self.DecimalString)
        Self.ClaDecStoredLen = Size(_claDecStored)
        If Self.ClaDecStoredLen < 1
            Return '0'
        End
        Self.T = -1
        Self.S = 0
        Loop Self.ClaDecStoredLen Times
            Self.S = Self.S + 1
            Self.T = Self.T + 2
            Self.DecimalString[Self.T : Self.T + 1] = BYTETOHEX(Val(_claDecStored[Self.S]),0)
        End
        If _places = 0
            If Self.DecimalString[1] = 'F'
                Self.DecimalString[1] = '-'
            End
            Return Self.DecimalString[1 : Self.T + 1]
        End
        Self.P = Self.T - _places + 1
        If Self.DecimalString[1] = 'F'
            Self.DecimalString[1] = '-'
        End

        Return Self.DecimalString[1 : Self.P] & '.' & Self.DecimalString[Self.P + 1 : Self.T + 1]

c25_MsSqlClass.AnsiToUtf16_ByRef                                                 Procedure(Long _c, *String _ansi,  Long _lenAnsi, Long _utf16Ptr, Long _maxUtf16Len)

    Code

        c25_memset(_utf16Ptr, 0 , _maxUtf16Len)
        If _maxUtf16Len >= _lenAnsi * 2
            Self.P = 1
            Self.T = 0
            Loop _lenAnsi Times
                c25_memset(_utf16Ptr + Self.T, Val(_ansi[Self.P]) , 1)
                Self.P = Self.P + 1
                Self.T = Self.T + 2
            End
        End

c25_MsSqlClass.AnsiToUtf16                                                       Procedure(Long _c, String _ansi,  Long _lenAnsi, Long _utf16Ptr, Long _maxUtf16Len)

    Code

        c25_memset(_utf16Ptr, 0 , _maxUtf16Len)
        If _maxUtf16Len >= _lenAnsi * 2
            Self.P = 1
            Self.T = 0
            Loop _lenAnsi Times
                c25_memset(_utf16Ptr + Self.T, Val(_ansi[Self.P]) , 1)
                Self.P = Self.P + 1
                Self.T = Self.T + 2
            End
        End

c25_MsSqlClass.BinaryCopy                                                        Procedure(Long _c, String _utf16Source,  Long _lenUtf16Source, Long _utf16Ptr, Long _maxUtf16Len)

    Code

        c25_memcpy(_utf16Ptr, Self.Utf16SpacesBufferPtr , _maxUtf16Len)
        If _maxUtf16Len >= _lenUtf16Source And _lenUtf16Source > 0
            c25_memcpy(_utf16Ptr, Address(_utf16Source) , _lenUtf16Source)
        End

c25_MsSqlClass.GetMappedClaQMetaField                                            Procedure(MsSqlInformationSchema_TYPE _msSqlInformationSchema)

Idx         Long

    Code

        Idx = 0
        Loop Records(Self.ClarionFields) TIMES
            Idx = Idx + 1
            Get(Self.ClarionFields, Idx)
            If Upper(clip(Self.ClarionFields.Name)) = Upper(clip(_msSqlInformationSchema.ColumnName))
                Return Idx
            End
        End
        Return 0

c25_MsSqlClass.GetMetaColumns                                                    Procedure(String _sqlMeta, <*queue _inputClaQ>)

SQLRETURN       Long
SQLRef          &String
SomeLongValue   Long
QueueRowDefault &String
QueueRow        &String

    Code

        Clear(Self.MsSqlMetaArray)
        Clear(Self.ClarionFieldsArray)

        Self.ClarionFieldsMaxIndex = 0
        Self.MsSqlMetaArrayMaxIndex = 0

        If not Self.ClarionFields &= NULL
            Free(Self.ClarionFields)
        ELSE
            Self.ClarionFields &= NEW ClarionFields_TYPE
        End

        If omitted(_inputClaQ) = False
            If not _inputClaQ &= null
                Self.GetClaDataReflectionAnalyze(_inputClaQ)

                I# = 0
                R# = Records(Self.ClarionFields)
                Loop R# TIMES
                    I# = I# + 1
                    Get(Self.ClarionFields,I#)
                    !Self.ClarionFields.Id = I#
                    Self.ClarionFields.Ordinal = I#
                    Put(Self.ClarionFields)
                    Self.ClarionFieldsArray[I#] = Self.ClarionFields
                End
                Self.ClarionFieldsMaxIndex = I#
            End
        End

        Self.GetMsSqlInformationSchema(_sqlMeta)

        I# = 0
        R# = Records(Self.MsSqlMeta)
        Self.MsSqlMetaAutoIdColumnIndex = 0
        Loop R# TIMES
            I# = I# + 1
            Get(Self.MsSqlMeta,I#)
            Self.MsSqlMeta.Id = I#
            Self.MsSqlMeta.Index = I#
            Self.MsSqlMeta.MappedClaQueueIndex = Self.GetMappedClaQMetaField(Self.MsSqlMeta)

            If Self.MsSqlMeta.SQL_DESC_AUTO_UNIQUE_VALUE = 1
                Self.MsSqlMetaAutoIdColumnIndex = I#
            End
            Put(Self.MsSqlMeta)
            Self.MsSqlMetaArray[I#] = Self.MsSqlMeta
        End
        Self.MsSqlMetaArrayMaxIndex = I#

        If Self.DebugLog
            Self.BitConverter.QueueToJsonString(Self.ClarionFields,,,,'m:\log\ClarionFields.json')
            Self.BitConverter.QueueToJsonString(Self.MsSqlMeta,,,,'m:\log\MsSqlMeta.json')
        End
        Return 0

c25_MsSqlClass.SQLFetch_InitGetMeta                  Procedure(String _sqlMeta, <*queue _inputClaQ>, <Mssqlinformationschema_TYPE _msSqlMetaQ>, <ClarionFields_TYPE _clarionFields>)

I   long
    Code

        If omitted(_inputClaQ) = False
            Self.GetMetaColumns(_sqlMeta, _inputClaQ)
        Else
            Self.GetMetaColumns(_sqlMeta)
        End
        If omitted(_msSqlMetaQ) = False
            Clear(_msSqlMetaQ)
            I = 0
            Loop
                I = I + 1
                Get(Self.MsSqlMeta,I)
                If Errorcode() <> 0
                    Break
                End
                _msSqlMetaQ = Self.MsSqlMeta
                Add(_msSqlMetaQ)
            End
        End
        If omitted(_clarionFields) = False
            Clear(_clarionFields)
            I = 0
            Loop
                I = I + 1
                Get(Self.ClarionFields,I)
                If Errorcode() <> 0
                    Break
                End
                _clarionFields = Self.ClarionFields
                Add(_clarionFields)
            End
        End

        Return 0


c25_MsSqlClass.ExecuteScalarReturnRef                        Procedure(String _sql, <long _claDataTypeEnum>, <long _maxSize>, <*bool _isNull>, <*bool _notFound>, <*bool _isError>)

ResultString        &string
IsNull              BOOL
NotFound            BOOL
IsError             BOOL
ClaDataTypeEnum     long
MaxSize             Long

Code

    If omitted(_claDataTypeEnum) = FALSE
        ClaDataTypeEnum = _claDataTypeEnum
    ELSE
        ClaDataTypeEnum = ClaDataTypeEnum:String
    End

    If omitted(_maxSize) = FALSE
        If _maxSize < 1
            Message('error _maxSize < 1 at c25_MsSqlClass.ExecuteScalarReturnRef ' & Clip(_sql))
            Return null
        End
        MaxSize = _maxSize
    ELSE
        MaxSize = 65000
    END
    ResultString &= NEW STRING(MaxSize)

    Self.ExecuteScalarHandler(_sql, ClaDataTypeEnum, MaxSize, ResultString,  ,IsNull, NotFound, IsError)

    If Omitted(_isNull) = FALSE
        _isNull = IsNull
    End
    If Omitted(_notFound) = FALSE
        _notFound = NotFound
    End
    If Omitted(_isError) = FALSE
        _isError = IsError
    End
    If IsNull
        Return NULL
    Else
        Return ResultString
    End


c25_MsSqlClass.ExecuteScalarReturnInt                       Procedure(String _sql, <long _claDataTypeEnum>, <long _maxSize>, <*bool _isNull>, <*bool _notFound>, <*bool _isError>)


ResultInt           Long
IsNull              BOOL
NotFound            BOOL
IsError             BOOL
ClaDataTypeEnum     long
MaxSize             Long

Code

    If omitted(_claDataTypeEnum) = FALSE
        ClaDataTypeEnum = _claDataTypeEnum
    ELSE
        ClaDataTypeEnum = ClaDataTypeEnum:Long
    End

    If omitted(_maxSize) = FALSE
        If _maxSize < 1
            Message('error _maxSize < 1 at c25_MsSqlClass.ExecuteScalarReturnRef ' & Clip(_sql))
            Return 0
        End
        MaxSize = _maxSize
    ELSE
        MaxSize = 4
    END
    ResultInt = 0

    Self.ExecuteScalarHandler(_sql, ClaDataTypeEnum, MaxSize, ,ResultInt ,IsNull, NotFound, IsError)

    If Omitted(_isNull) = FALSE
        _isNull = IsNull
    End
    If Omitted(_notFound) = FALSE
        _notFound = NotFound
    End
    If Omitted(_isError) = FALSE
        _isError = IsError
    End
    If IsNull
        Return 0
    Else
        Return ResultInt
    End

c25_MsSqlClass.ExecuteScalarReturnString                     Procedure(String _sql, <long _claDataTypeEnum>, <long _maxSize>, <*bool IsNull>, <*bool _notFound>, <*bool _isError>)


Code

    Return ''


c25_MsSqlClass.ExecuteScalarHandler                          Procedure(String _sql, long _claDataTypeEnum,  long _maxSize, <*string _resultString>, <*long _resultInt>, <*bool _isNull>, <*bool _notFound>, <*bool _error>)

SQLRETURN       Long
SQLRef          &String
SomeLongValue   Long
QueueRowDefault &String
QueueRow        &String
stLog           &StringTheory
ReturnResult    &String
IntValue        Long
IntValueStr4    string(4),Over(IntValue)

    Code

        If Self.ClarionFieldsTEMP &= null
            Self.ClarionFieldsTEMP &= NEW ClarionFields_TYPE()
        ELSE
            Free(Self.ClarionFieldsTEMP)
            Clear(Self.ClarionFieldsTEMP)
        End
        Self.ClarionFieldsTEMP.DataTypeEnum     = _claDataTypeEnum
        Self.ClarionFieldsTEMP.SizeBytes        = _maxSize

        Self.ClarionFieldsTEMP.DataTypeEnum = _claDataTypeEnum
        Add(Self.ClarionFields)

        Self.GetMetaColumns(_sql)

        Self.StmtHandle = Self.AllocHandle(,True)
        If Self.StmtHandle = 0
            Return 0
        End

        Self.StSql.SetValue(Clip(_sql))

        SQLRef &= Self.BitConverter.AnsiToUtf16(Self.StSql.GetValue() & Chr(0) ,,true)

        Self.SQLRowCount        = 0
        Self.SQLColumnsCount    = 0

        Self.SQLRETURN = C25_SQLSetStmtAttrW(Self.StmtHandle, C25_SQL_ATTR_CONCURRENCY            , C25_SQL_CONCUR_VALUES , 0)
        Self.SQLRETURN = C25_SQLSetStmtAttrW(Self.StmtHandle, C25_SQL_ATTR_CURSOR_TYPE            , C25_Sql_Cursor_Keyset_Driven,0)

        Self.SQLRETURN = C25_SQLExecDirectW(Self.StmtHandle, Address(SQLRef), C25_SQL_NTS)
        If Self.SQLRETURN <> 0 And Self.SQLRETURN <> 1 And Self.SQLRETURN <> 100
            Message('Error C25_SQLExecDirectW')
            Self.SQLGetDiagRec_STMT()
            Return 0
        End
        Self.SQLRETURN = C25_SQLRowCount(Self.StmtHandle,Address(Self.SQLRowCount))



        If Self.SQLRowCount < 1
            If omitted(_notFound) = FALSE
                _notFound = TRUE
            END
            Return 'not found'
        End


        Self.SQLRETURN = C25_SQLFetchScroll(Self.StmtHandle, C25_SQL_FETCH_FIRST, 0)
        If Self.SQLRETURN <> 0 And Self.SQLRETURN <> 1 And Self.SQLRETURN <> 100
            Message('Error C25_SQLFetchScroll')
            Return 0
        End

        Self.SQLRETURN = C25_SQLNumResultCols(Self.StmtHandle,Address(Self.SQLNumResultCols))

        If Self.SQLNumResultCols < 1
            Return 0
        End

        Case Self.ClarionFieldsTEMP.DataTypeEnum
        Of ClaDataTypeEnum:Dec20
            ReturnResult &= NEW STRING(20)
            Self.ClarionFieldsTEMP.SizeBytes = 20
        Else
            ReturnResult &= NEW STRING(_maxSize)
            Self.ClarionFieldsTEMP.SizeBytes = _maxSize
        End

        Self.QueueRowPtr = Address(ReturnResult)

        Self.SQLRETURN = C25_SQLFetchScroll(Self.StmtHandle, C25_SQL_FETCH_FIRST, 0)

        CL# = 1
        Case Self.MsSqlMeta.DataTypeEnum
        Of C25_SQL_BIGINT
            If Self.ClarionFieldsTEMP.DataTypeEnum = ClaDataTypeEnum:Dec20
                Self.SQLGetData_SQL_BIGINT(False, CL# , Self.QueueRowPtr + Self.ClarionFieldsTEMP.Offset, Self.IsNull, 'NULL', Self.ClarionFieldsTEMP.SizeBytes, Self.ClarionFieldsTEMP.DataTypeEnum, ConvertFunction:SQLC_UBIGINT_ToDec20)
            ELSE
                Self.SQLGetData_SQL_BIGINT(False, CL# , Self.QueueRowPtr + Self.ClarionFieldsTEMP.Offset, Self.IsNull, 'NULL', Self.ClarionFieldsTEMP.SizeBytes, Self.ClarionFieldsTEMP.DataTypeEnum, ConvertFunction:SQLC_SBIGINT_ToDec20)
            End
        Of C25_SQL_CHAR
            Case Self.ClarionFieldsTEMP.DataTypeEnum
            Of ClaDataTypeEnum:String
            OrOf ClaDataTypeEnum:STRINGREF
                If Self.ClarionFieldsTEMP.EncodingEnum = EncodingEnum:Utf8
                    Self.SQLGetData_SQL_CHAR(False, CL# , Self.QueueRowPtr + Self.ClarionFieldsTEMP.Offset, Self.IsNull, 'NULL', Self.ClarionFieldsTEMP.SizeBytes, Self.ClarionFieldsTEMP.DataTypeEnum, ConvertFunction:SQLC_CHAR_ToUtf8)
                ElsIf Self.ClarionFieldsTEMP.EncodingEnum = EncodingEnum:Utf16
                    Self.SQLGetData_SQL_CHAR(False, CL# , Self.QueueRowPtr + Self.ClarionFieldsTEMP.Offset, Self.IsNull, 'NULL', Self.ClarionFieldsTEMP.SizeBytes, Self.ClarionFieldsTEMP.DataTypeEnum, ConvertFunction:SQLC_CHAR_ToUtf16)
                Else
                    Self.SQLGetData_SQL_CHAR(False, CL# , Self.QueueRowPtr + Self.ClarionFieldsTEMP.Offset, Self.IsNull, 'NULL', Self.ClarionFieldsTEMP.SizeBytes, Self.ClarionFieldsTEMP.DataTypeEnum, ConvertFunction:SQLC_CHAR)
                End
            End
        Of C25_SQL_INTEGER
            If Self.ClarionFieldsTEMP.DataTypeEnum = ClaDataTypeEnum:Long
                Self.SQLGetData_SQL_INTEGER(False, CL# , Self.QueueRowPtr + Self.ClarionFieldsTEMP.Offset, Self.IsNull, 'NULL', Self.ClarionFieldsTEMP.SizeBytes, Self.ClarionFieldsTEMP.DataTypeEnum, ConvertFunction:SQLC_LONG)
            ElsIf Self.ClarionFieldsTEMP.DataTypeEnum = ClaDataTypeEnum:ULong
                Self.SQLGetData_SQL_INTEGER(False, CL# , Self.QueueRowPtr + Self.ClarionFieldsTEMP.Offset, Self.IsNull, 'NULL', Self.ClarionFieldsTEMP.SizeBytes, Self.ClarionFieldsTEMP.DataTypeEnum, ConvertFunction:SQLC_ULONG)
            End
        Of C25_SQL_SMALLINT
            If Self.ClarionFieldsTEMP.DataTypeEnum = ClaDataTypeEnum:Short
                Self.SQLGetData_SQL_SMALLINT(False, CL# , Self.QueueRowPtr + Self.ClarionFieldsTEMP.Offset, Self.IsNull, 'NULL', Self.ClarionFieldsTEMP.SizeBytes, Self.ClarionFieldsTEMP.DataTypeEnum, ConvertFunction:SQLC_SHORT)
            ElsIf Self.ClarionFieldsTEMP.DataTypeEnum = ClaDataTypeEnum:UShort
                Self.SQLGetData_SQL_SMALLINT(False, CL# , Self.QueueRowPtr + Self.ClarionFieldsTEMP.Offset, Self.IsNull, 'NULL', Self.ClarionFieldsTEMP.SizeBytes, Self.ClarionFieldsTEMP.DataTypeEnum, ConvertFunction:SQLC_USHORT)
            End
        Of C25_SQL_BIT
            If Self.ClarionFieldsTEMP.DataTypeEnum = ClaDataTypeEnum:Byte
                Self.SQLGetData_SQL_BIT(False, CL# , Self.QueueRowPtr + Self.ClarionFieldsTEMP.Offset, Self.IsNull, 'NULL', Self.ClarionFieldsTEMP.SizeBytes, Self.ClarionFieldsTEMP.DataTypeEnum, ConvertFunction:SQLC_BIT)
            End
        Of C25_SQL_TINYINT
            If Self.ClarionFieldsTEMP.DataTypeEnum = ClaDataTypeEnum:Byte
                Self.SQLGetData_SQL_TINYINT(False, CL# , Self.QueueRowPtr + Self.ClarionFieldsTEMP.Offset, Self.IsNull, 'NULL', Self.ClarionFieldsTEMP.SizeBytes, Self.ClarionFieldsTEMP.DataTypeEnum, ConvertFunction:SQLC_UTINYINT)
            End
        Of C25_SQL_VARCHAR
            Case Self.ClarionFieldsTEMP.DataTypeEnum
            Of ClaDataTypeEnum:String
            OrOf ClaDataTypeEnum:STRINGREF
                If Self.ClarionFieldsTEMP.EncodingEnum = EncodingEnum:Utf8
                    Self.SQLGetData_SQL_VARCHAR(False, CL# , Self.QueueRowPtr + Self.ClarionFieldsTEMP.Offset, Self.IsNull, 'NULL', Self.ClarionFieldsTEMP.SizeBytes, Self.ClarionFieldsTEMP.DataTypeEnum, ConvertFunction:SQLC_CHAR_ToUtf8)
                ElsIf Self.ClarionFieldsTEMP.EncodingEnum = EncodingEnum:Utf16
                    Self.SQLGetData_SQL_VARCHAR(False, CL# , Self.QueueRowPtr + Self.ClarionFieldsTEMP.Offset, Self.IsNull, 'NULL', Self.ClarionFieldsTEMP.SizeBytes, Self.ClarionFieldsTEMP.DataTypeEnum, ConvertFunction:SQLC_CHAR_ToUtf16)
                Else
                    Self.SQLGetData_SQL_VARCHAR(False, CL# , Self.QueueRowPtr + Self.ClarionFieldsTEMP.Offset, Self.IsNull, 'NULL', Self.ClarionFieldsTEMP.SizeBytes, Self.ClarionFieldsTEMP.DataTypeEnum, ConvertFunction:SQLC_CHAR)
                End
            End
        Of C25_SQL_WCHAR
            Case Self.ClarionFieldsTEMP.DataTypeEnum
            Of ClaDataTypeEnum:String
            OrOf ClaDataTypeEnum:STRINGREF
                If Self.ClarionFieldsTEMP.EncodingEnum = EncodingEnum:Utf8
                    Self.SQLGetData_SQL_WCHAR(False, CL# , Self.QueueRowPtr + Self.ClarionFieldsTEMP.Offset, Self.IsNull, 'NULL', Self.ClarionFieldsTEMP.SizeBytes, Self.ClarionFieldsTEMP.DataTypeEnum, ConvertFunction:SQLC_CHAR_ToUtf8)
                ElsIf Self.ClarionFieldsTEMP.EncodingEnum = EncodingEnum:Utf16
                    Self.SQLGetData_SQL_WCHAR(False, CL# , Self.QueueRowPtr + Self.ClarionFieldsTEMP.Offset, Self.IsNull, 'NULL', Self.ClarionFieldsTEMP.SizeBytes, Self.ClarionFieldsTEMP.DataTypeEnum, ConvertFunction:SQLC_CHAR_ToUtf16)
                Else
                    Self.SQLGetData_SQL_WCHAR(False, CL# , Self.QueueRowPtr + Self.ClarionFieldsTEMP.Offset, Self.IsNull, 'NULL', Self.ClarionFieldsTEMP.SizeBytes, Self.ClarionFieldsTEMP.DataTypeEnum, ConvertFunction:SQLC_CHAR)
                End
            End
        Of C25_SQL_WVARCHAR
            Case Self.ClarionFieldsTEMP.DataTypeEnum
            Of ClaDataTypeEnum:String
            OrOf ClaDataTypeEnum:STRINGREF
                If Self.ClarionFieldsTEMP.EncodingEnum = EncodingEnum:Utf8
                    Self.SQLGetData_SQL_WVARCHAR(False, CL# , Self.QueueRowPtr + Self.ClarionFieldsTEMP.Offset, Self.IsNull, 'NULL', Self.ClarionFieldsTEMP.SizeBytes, Self.ClarionFieldsTEMP.DataTypeEnum, ConvertFunction:SQLC_CHAR_ToUtf8)
                ElsIf Self.ClarionFieldsTEMP.EncodingEnum = EncodingEnum:Utf16
                    Self.SQLGetData_SQL_WVARCHAR(False, CL# , Self.QueueRowPtr + Self.ClarionFieldsTEMP.Offset, Self.IsNull, 'NULL', Self.ClarionFieldsTEMP.SizeBytes, Self.ClarionFieldsTEMP.DataTypeEnum, ConvertFunction:SQLC_CHAR_ToUtf16)
                Else
                    Self.SQLGetData_SQL_WVARCHAR(False, CL# , Self.QueueRowPtr + Self.ClarionFieldsTEMP.Offset, Self.IsNull, 'NULL', Self.ClarionFieldsTEMP.SizeBytes, Self.ClarionFieldsTEMP.DataTypeEnum, ConvertFunction:SQLC_CHAR)
                End
            End
        Of C25_SQL_VARBINARY
            Case Self.ClarionFieldsTEMP.DataTypeEnum
            Of ClaDataTypeEnum:String
            OrOf ClaDataTypeEnum:STRINGREF
                If Self.ClarionFieldsTEMP.EncodingEnum = EncodingEnum:Utf8
                    Self.SQLGetData_SQL_VARBINARY(False, CL# , Self.QueueRowPtr + Self.ClarionFieldsTEMP.Offset, Self.IsNull, 'NULL', Self.ClarionFieldsTEMP.SizeBytes, Self.ClarionFieldsTEMP.DataTypeEnum, ConvertFunction:SQLC_CHAR_ToUtf8)
                ElsIf Self.ClarionFieldsTEMP.EncodingEnum = EncodingEnum:Utf16
                    Self.SQLGetData_SQL_VARBINARY(False, CL# , Self.QueueRowPtr + Self.ClarionFieldsTEMP.Offset, Self.IsNull, 'NULL', Self.ClarionFieldsTEMP.SizeBytes, Self.ClarionFieldsTEMP.DataTypeEnum, ConvertFunction:SQLC_CHAR_ToUtf16)
                Else
                    Self.SQLGetData_SQL_VARBINARY(False, CL# , Self.QueueRowPtr + Self.ClarionFieldsTEMP.Offset, Self.IsNull, 'NULL', Self.ClarionFieldsTEMP.SizeBytes, Self.ClarionFieldsTEMP.DataTypeEnum, ConvertFunction:SQLC_CHAR)
                End
            End
        ELSE
            Message(clip(Self.MsSqlMeta.ColumnName) & ', error datatype unknown ' & Self.MsSqlMeta.DataTypeEnum)
        End

        If omitted(_resultString) = FALSE
            _resultString = ReturnResult
        End
        If omitted(_resultInt) = FALSE
            IntValueStr4 = ReturnResult[1 : 4]
            _resultInt = IntValue
        End
        If not ReturnResult &= NULL
            Dispose(ReturnResult)
        END
        If omitted(_isNull) = FALSE
            _isNull = Self.IsNull
        End


        Return 0




c25_MsSqlClass.SQLFetch_Rows                         Procedure(String _sql, <*queue _inputClaQ>)

SQLRETURN       Long
SQLRef          &String
SomeLongValue   Long
QueueRowDefault &String
QueueRow        &String
stLog           &StringTheory
InputQueue      &Queue

    Code

        InputQueue &= _inputClaQ
        Self.StmtHandle = Self.AllocHandle(,True)
        If Self.StmtHandle = 0
            Return 0
        End

        Self.StSql.SetValue(Clip(_sql))

        SQLRef &= Self.BitConverter.AnsiToUtf16(Self.StSql.GetValue() & Chr(0) ,,true)

        Self.SQLRowCount        = 0
        Self.SQLColumnsCount    = 0

        Self.SQLRETURN = C25_SQLSetStmtAttrW(Self.StmtHandle, C25_SQL_ATTR_CONCURRENCY            , C25_SQL_CONCUR_VALUES , 0)
        Self.SQLRETURN = C25_SQLSetStmtAttrW(Self.StmtHandle, C25_SQL_ATTR_CURSOR_TYPE            , C25_Sql_Cursor_Keyset_Driven,0)

        Self.SQLRETURN = C25_SQLExecDirectW(Self.StmtHandle, Address(SQLRef), C25_SQL_NTS)
        If Self.SQLRETURN <> 0 And Self.SQLRETURN <> 1 And Self.SQLRETURN <> 100
            Message('Error C25_SQLExecDirectW')
            Self.SQLGetDiagRec_STMT()
            Return 0
        End
        Self.SQLRETURN = C25_SQLRowCount(Self.StmtHandle,Address(Self.SQLRowCount))


        Self.SQLRETURN = C25_SQLFetchScroll(Self.StmtHandle, C25_SQL_FETCH_FIRST, 0)
        If Self.SQLRETURN <> 0 And Self.SQLRETURN <> 1 And Self.SQLRETURN <> 100
            Message('Error C25_SQLFetchScroll')
            Return 0
        End

        Self.SQLRETURN = C25_SQLNumResultCols(Self.StmtHandle,Address(Self.SQLNumResultCols))



        Clear(InputQueue)
        QueueRowDefault     &= NEW String(Size( InputQueue ))
        QueueRow            &= NEW String(Size( InputQueue ))
        Self.QueueRowPtr    = Address(QueueRow)
        QueueRowDefault = InputQueue

        Self.SQLRETURN = C25_SQLFetchScroll(Self.StmtHandle, C25_SQL_FETCH_FIRST, 0)




        RW# = 0
        Loop !1 Times !10 Times
            RW# = RW# + 1
            QueueRow = QueueRowDefault
            CL# = 0
            Loop Self.SQLNumResultCols TIMES
                CL# = CL# + 1

                Get(Self.MsSqlMeta,CL#)
                If Errorcode() <> 0
                    BREAK
                End

                FND# = 0

                IX# = 0
                Loop Records(Self.ClarionFields) TIMES
                    IX# = IX# + 1
                    Get(Self.ClarionFields, IX#)
                    If Upper(clip(Self.ClarionFields.Name)) = Upper(clip(Self.MsSqlMeta.ColumnName))
                        FND# = TRUE
                        BREAK
                    End
                End
                If FND# = 0
                    Message('not found : ' & clip(Self.ClarionFields.Name) & ' ' & clip(Self.MsSqlMeta.ColumnName))
                    Cycle
                End



                Case Self.MsSqlMeta.DataTypeEnum
                Of C25_SQL_BIGINT
                    If Self.ClarionFields.DataTypeEnum = ClaDataTypeEnum:Dec20
                        Self.SQLGetData_SQL_BIGINT(False, CL# , Self.QueueRowPtr + Self.ClarionFields.Offset, Self.IsNull, 'NULL', Self.ClarionFields.SizeBytes, Self.ClarionFields.DataTypeEnum, ConvertFunction:SQLC_UBIGINT_ToDec20)
                    ELSE
                        Self.SQLGetData_SQL_BIGINT(False, CL# , Self.QueueRowPtr + Self.ClarionFields.Offset, Self.IsNull, 'NULL', Self.ClarionFields.SizeBytes, Self.ClarionFields.DataTypeEnum, ConvertFunction:SQLC_SBIGINT_ToDec20)
                    End
                Of C25_SQL_CHAR
                    Case Self.ClarionFields.DataTypeEnum
                    Of ClaDataTypeEnum:String
                    OrOf ClaDataTypeEnum:STRINGREF
                        If Self.ClarionFields.EncodingEnum = EncodingEnum:Utf8
                            Self.SQLGetData_SQL_CHAR(False, CL# , Self.QueueRowPtr + Self.ClarionFields.Offset, Self.IsNull, 'NULL', Self.ClarionFields.SizeBytes, Self.ClarionFields.DataTypeEnum, ConvertFunction:SQLC_CHAR_ToUtf8)
                        ElsIf Self.ClarionFields.EncodingEnum = EncodingEnum:Utf16
                            Self.SQLGetData_SQL_CHAR(False, CL# , Self.QueueRowPtr + Self.ClarionFields.Offset, Self.IsNull, 'NULL', Self.ClarionFields.SizeBytes, Self.ClarionFields.DataTypeEnum, ConvertFunction:SQLC_CHAR_ToUtf16)
                        Else
                            Self.SQLGetData_SQL_CHAR(False, CL# , Self.QueueRowPtr + Self.ClarionFields.Offset, Self.IsNull, 'NULL', Self.ClarionFields.SizeBytes, Self.ClarionFields.DataTypeEnum, ConvertFunction:SQLC_CHAR)
                        End
                    End
                Of C25_SQL_INTEGER
                    If Self.ClarionFields.DataTypeEnum = ClaDataTypeEnum:Long
                        Self.SQLGetData_SQL_INTEGER(False, CL# , Self.QueueRowPtr + Self.ClarionFields.Offset, Self.IsNull, 'NULL', Self.ClarionFields.SizeBytes, Self.ClarionFields.DataTypeEnum, ConvertFunction:SQLC_LONG)
                    ElsIf Self.ClarionFields.DataTypeEnum = ClaDataTypeEnum:ULong
                        Self.SQLGetData_SQL_INTEGER(False, CL# , Self.QueueRowPtr + Self.ClarionFields.Offset, Self.IsNull, 'NULL', Self.ClarionFields.SizeBytes, Self.ClarionFields.DataTypeEnum, ConvertFunction:SQLC_ULONG)
                    End
                Of C25_SQL_SMALLINT
                    If Self.ClarionFields.DataTypeEnum = ClaDataTypeEnum:Short
                        Self.SQLGetData_SQL_SMALLINT(False, CL# , Self.QueueRowPtr + Self.ClarionFields.Offset, Self.IsNull, 'NULL', Self.ClarionFields.SizeBytes, Self.ClarionFields.DataTypeEnum, ConvertFunction:SQLC_SHORT)
                    ElsIf Self.ClarionFields.DataTypeEnum = ClaDataTypeEnum:UShort
                        Self.SQLGetData_SQL_SMALLINT(False, CL# , Self.QueueRowPtr + Self.ClarionFields.Offset, Self.IsNull, 'NULL', Self.ClarionFields.SizeBytes, Self.ClarionFields.DataTypeEnum, ConvertFunction:SQLC_USHORT)
                    End
                Of C25_SQL_BIT
                    If Self.ClarionFields.DataTypeEnum = ClaDataTypeEnum:Byte
                        Self.SQLGetData_SQL_BIT(False, CL# , Self.QueueRowPtr + Self.ClarionFields.Offset, Self.IsNull, 'NULL', Self.ClarionFields.SizeBytes, Self.ClarionFields.DataTypeEnum, ConvertFunction:SQLC_BIT)
                    End
                Of C25_SQL_TINYINT
                    If Self.ClarionFields.DataTypeEnum = ClaDataTypeEnum:Byte
                        Self.SQLGetData_SQL_TINYINT(False, CL# , Self.QueueRowPtr + Self.ClarionFields.Offset, Self.IsNull, 'NULL', Self.ClarionFields.SizeBytes, Self.ClarionFields.DataTypeEnum, ConvertFunction:SQLC_UTINYINT)
                    End
                Of C25_SQL_VARCHAR
                    Case Self.ClarionFields.DataTypeEnum
                    Of ClaDataTypeEnum:String
                    OrOf ClaDataTypeEnum:STRINGREF
                        If Self.ClarionFields.EncodingEnum = EncodingEnum:Utf8
                            Self.SQLGetData_SQL_VARCHAR(False, CL# , Self.QueueRowPtr + Self.ClarionFields.Offset, Self.IsNull, 'NULL', Self.ClarionFields.SizeBytes, Self.ClarionFields.DataTypeEnum, ConvertFunction:SQLC_CHAR_ToUtf8)
                        ElsIf Self.ClarionFields.EncodingEnum = EncodingEnum:Utf16
                            Self.SQLGetData_SQL_VARCHAR(False, CL# , Self.QueueRowPtr + Self.ClarionFields.Offset, Self.IsNull, 'NULL', Self.ClarionFields.SizeBytes, Self.ClarionFields.DataTypeEnum, ConvertFunction:SQLC_CHAR_ToUtf16)
                        Else
                            Self.SQLGetData_SQL_VARCHAR(False, CL# , Self.QueueRowPtr + Self.ClarionFields.Offset, Self.IsNull, 'NULL', Self.ClarionFields.SizeBytes, Self.ClarionFields.DataTypeEnum, ConvertFunction:SQLC_CHAR)
                        End
                    End
                Of C25_SQL_WCHAR
                    Case Self.ClarionFields.DataTypeEnum
                    Of ClaDataTypeEnum:String
                    OrOf ClaDataTypeEnum:STRINGREF
                        If Self.ClarionFields.EncodingEnum = EncodingEnum:Utf8
                            Self.SQLGetData_SQL_WCHAR(False, CL# , Self.QueueRowPtr + Self.ClarionFields.Offset, Self.IsNull, 'NULL', Self.ClarionFields.SizeBytes, Self.ClarionFields.DataTypeEnum, ConvertFunction:SQLC_CHAR_ToUtf8)
                        ElsIf Self.ClarionFields.EncodingEnum = EncodingEnum:Utf16
                            Self.SQLGetData_SQL_WCHAR(False, CL# , Self.QueueRowPtr + Self.ClarionFields.Offset, Self.IsNull, 'NULL', Self.ClarionFields.SizeBytes, Self.ClarionFields.DataTypeEnum, ConvertFunction:SQLC_CHAR_ToUtf16)
                        Else
                            Self.SQLGetData_SQL_WCHAR(False, CL# , Self.QueueRowPtr + Self.ClarionFields.Offset, Self.IsNull, 'NULL', Self.ClarionFields.SizeBytes, Self.ClarionFields.DataTypeEnum, ConvertFunction:SQLC_CHAR)
                        End
                    End
                Of C25_SQL_WVARCHAR
                    Case Self.ClarionFields.DataTypeEnum
                    Of ClaDataTypeEnum:String
                    OrOf ClaDataTypeEnum:STRINGREF

                        If Self.ClarionFields.EncodingEnum = EncodingEnum:Utf8
                            Self.SQLGetData_SQL_WVARCHAR(False, CL# , Self.QueueRowPtr + Self.ClarionFields.Offset, Self.IsNull, 'NULL', Self.ClarionFields.SizeBytes, Self.ClarionFields.DataTypeEnum, ConvertFunction:SQLC_CHAR_ToUtf16)
                        ElsIf Self.ClarionFields.EncodingEnum = EncodingEnum:Utf16
                            Self.SQLGetData_SQL_WVARCHAR(False, CL# , Self.QueueRowPtr + Self.ClarionFields.Offset, Self.IsNull, 'NULL', Self.ClarionFields.SizeBytes, Self.ClarionFields.DataTypeEnum, ConvertFunction:SQLC_CHAR_ToUtf16)
                        Else
                            Self.SQLGetData_SQL_WVARCHAR(False, CL# , Self.QueueRowPtr + Self.ClarionFields.Offset, Self.IsNull, 'NULL', Self.ClarionFields.SizeBytes, Self.ClarionFields.DataTypeEnum, ConvertFunction:SQLC_CHAR_ToUtf16)
                        End
                    End
                Of C25_SQL_VARBINARY
                    Case Self.ClarionFields.DataTypeEnum
                    Of ClaDataTypeEnum:String
                    OrOf ClaDataTypeEnum:STRINGREF
                        If Self.ClarionFields.EncodingEnum = EncodingEnum:Utf8
                            Self.SQLGetData_SQL_VARBINARY(False, CL# , Self.QueueRowPtr + Self.ClarionFields.Offset, Self.IsNull, 'NULL', Self.ClarionFields.SizeBytes, Self.ClarionFields.DataTypeEnum, ConvertFunction:SQLC_CHAR_ToUtf8)
                        ElsIf Self.ClarionFields.EncodingEnum = EncodingEnum:Utf16
                            Self.SQLGetData_SQL_VARBINARY(False, CL# , Self.QueueRowPtr + Self.ClarionFields.Offset, Self.IsNull, 'NULL', Self.ClarionFields.SizeBytes, Self.ClarionFields.DataTypeEnum, ConvertFunction:SQLC_CHAR_ToUtf16)
                        Else
                            Self.SQLGetData_SQL_VARBINARY(False, CL# , Self.QueueRowPtr + Self.ClarionFields.Offset, Self.IsNull, 'NULL', Self.ClarionFields.SizeBytes, Self.ClarionFields.DataTypeEnum, ConvertFunction:SQLC_CHAR)
                        End
                    End
                ELSE
                    Message(clip(Self.MsSqlMeta.ColumnName) & ', error datatype unknown ' & Self.MsSqlMeta.DataTypeEnum)
                End
            End
            InputQueue = QueueRow
            Add(InputQueue)

            Self.SQLRETURN = C25_SQLFetchScroll(Self.StmtHandle, C25_SQL_FETCH_NEXT, 0)
            If Self.SQLRETURN <> C25_Sql_Success
                Break
            End
        End

        If Self.DebugLog
            Self.BitConverter.QueueToJsonString(InputQueue,False,False,False, 'm:\log\testqueue.json')
        End

        InputQueue &= null
        Return 0

c25_MsSqlClass.SQLGetData_SQL_BIGINT                 Procedure |
                                        ( |
                                        <Byte       _returnData            >, |
                                        Long        _columnOrdinal          , |
                                        <Long       _targetPtr             >, |
                                        <*Byte      _isNull                >, |
                                        <String     _returnValueIfNull     >, |
                                        <Long       _maxTargetBytesLen     >, |
                                        <Long       _clarionTargetType     >, |
                                        <Long       _convertFunction       >, |
                                        <Long       _trailingZero    >  |
                                        )

    Code

        If omitted(_isNull) = False
            _isNull = 0
        End
        Self.SQLGetDataReturnLength = 0
        Case _convertFunction
        Of ConvertFunction:SQLC_UBIGINT_ToDec20
            Self.UInt64Value = 0
            Self.SQLRETURN = C25_SQLGetData(Self.StmtHandle, _columnOrdinal, C25_SQLC_SBIGINT, Self.UInt64ValuePtr, 0, Self.SQLGetDataReturnLengthPtr)
            If Self.SQLRETURN = 0
                If Self.SQLGetDataReturnLength = 8
                    i64ToDecimal(Self.Dec20, Self.UInt64Value)
                    c25_memcpy(_targetPtr, Self.Str11OverDec20Ptr, 11)
                    Return Format(Self.Dec20,@n-28.0)
                ELSE
                    Self.Dec20 = 0
                    c25_memcpy(_targetPtr, Self.Str11OverDec20Ptr, 11)
                    If omitted(_isNull) = False
                        _isNull = TRUE
                    End
                    If omitted(_returnValueIfNull) = False
                        Return Clip(_returnValueIfNull)
                    Else
                        Return Format(Self.Dec20,@n-28.0)
                    End
                End
            End
        Of ConvertFunction:SQLC_SBIGINT_ToDec20
            Self.Int64Value = 0
            Self.SQLRETURN = C25_SQLGetData(Self.StmtHandle, _columnOrdinal, C25_SQLC_SBIGINT, Self.Int64ValuePtr, 0, Self.SQLGetDataReturnLengthPtr)
            If Self.SQLRETURN = 0
                If Self.SQLGetDataReturnLength = 8
                    i64ToDecimal(Self.Dec20, Self.Int64Value)
                    c25_memcpy(_targetPtr, Self.Str11OverDec20Ptr, 11)
                    Return Format(Self.Dec20,@n-28.0)
                ELSE
                    Self.Dec20 = 0
                    c25_memcpy(_targetPtr, Self.Str11OverDec20Ptr, 11)
                    If omitted(_isNull) = False
                        _isNull = TRUE
                    End
                    If omitted(_returnValueIfNull) = False
                        Return _returnValueIfNull
                    Else
                        Return Format(Self.Dec20,@n-28.0)
                    End
                End
            End
        End
        Return '0'

c25_MsSqlClass.SQLGetData_SQL_BINARY                 Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>)

    Code

    Return ''

c25_MsSqlClass.SQLGetData_SQL_BIT                    Procedure |
                                            ( |
                                        <Byte       _returnData            >, |
                                        Long        _columnOrdinal          , |
                                        <Long       _targetPtr             >, |
                                        <*Byte      _isNull                >, |
                                        <String     _returnValueIfNull     >, |
                                        <Long       _maxTargetBytesLen     >, |
                                        <Long       _clarionTargetType     >, |
                                        <Long       _convertFunction       >, |
                                        <Long       _trailingZero    >, |
                                        <Byte       _bandSourceLen         >, |
                                        <Byte       _bandBitPos            >  |
                                        )

    Code

        If omitted(_isNull) = False
            _isNull = 0
        End
        Self.BitValue = 0
        Self.SQLGetDataReturnLength = 0
        Case _convertFunction
        Of ConvertFunction:SQLC_BIT
            Self.SQLRETURN = C25_SQLGetData(Self.StmtHandle, _columnOrdinal, C25_SQLC_BIT, Self.BitValuePtr, 0, Self.SQLGetDataReturnLengthPtr)
            If Self.SQLRETURN = 0
                If Self.SQLGetDataReturnLength = 1
                    c25_memcpy(_targetPtr, Self.BitValuePtr, 1)
                    Return Self.IntValue
                ELSE
                    c25_memcpy(_targetPtr, Self.BitValuePtr, 1)
                    If omitted(_isNull) = False
                        _isNull = TRUE
                    End
                    If omitted(_returnValueIfNull) = False
                        Return Clip(_returnValueIfNull)
                    Else
                        Return '0'
                    End
                End
            End
        End
        Return '0'

c25_MsSqlClass.SQLGetData_SQL_CHAR                   Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>)

AdrGroup                        Group,pre(AdrGroup)
PtrAddress                          Long
PtrSize                             Long
                                End
AnyRef                          ANY
STRINGREF                       &String
GrpStringRef                    Group,Pre(GrpStringRef)
STRREF                              &String
                                End
AddressAndSizeFromAny           String(8),over(AdrGroup)
Str8                            String(8)

    Code

        If _maxTargetBytesLen < 1
            Return ''
        End
        If omitted(_isNull) = False
            _isNull = 0
        End
        Self.SQLGetDataReturnLength = 0
        Self.SQLRETURN = C25_SQLGetData(Self.StmtHandle, _columnOrdinal, C25_SQLC_CHAR, Self.CharBuffer2MBPtr, 0, Self.SQLGetDataReturnLengthPtr)
        If Self.SQLGetDataReturnLength > 0
            Self.StBufferRequiredLength = Self.SQLGetDataReturnLength
            If Omitted(_trailingZero) = False
                Case _convertFunction
                Of C25_SQLC_CHAR
                    Self.StBufferRequiredLength = Self.StBufferRequiredLength + 1
                ELSE
                    Self.StBufferRequiredLength = Self.StBufferRequiredLength + 2
                End
            End
            Case _clarionTargetType
            Of ClaDataTypeEnum:STRINGREF
                STRINGREF &= NEW String(Self.StBufferRequiredLength)
                Self.SQLRETURN = C25_SQLGetData(Self.StmtHandle, _columnOrdinal, C25_SQLC_CHAR, Address(STRINGREF), Self.SQLGetDataReturnLength, Self.SQLGetDataReturnLengthPtr)
                If Omitted(_trailingZero) = False
                    If _trailingZero
                        Case _convertFunction
                        Of C25_SQLC_CHAR
                            STRINGREF[Self.StBufferRequiredLength + 1 : Self.StBufferRequiredLength + 1] = Chr(0)
                        ELSE
                            STRINGREF[Self.StBufferRequiredLength + 1 : Self.StBufferRequiredLength + 2] = Chr(0) + Chr(0)
                        End
                    End
                End
                GrpStringRef.STRREF &= STRINGREF
                AnyRef &=  WHAT(GrpStringRef,1)
                AddressAndSizeFromAny = AnyRef
                AnyRef &= NULL
                GrpStringRef.STRREF &= NULL
                Str8 = AddressAndSizeFromAny
                c25_memcpy(_targetPtr, Address(Str8), 8)
                If _returnData
                    Return STRINGREF
                End
            Of ClaDataTypeEnum:String
                If not Self.StBuffer &= NULL
                    Dispose(Self.StBuffer)
                End
                Self.StBuffer &= NEW StringTheory()
                Self.StBuffer.Start()
                Self.StBuffer.SetValue(All(Chr(32),_maxTargetBytesLen))
                Self.SQLRETURN = C25_SQLGetData(Self.StmtHandle, _columnOrdinal, C25_SQLC_CHAR, Self.StBuffer.GetAddress(), Self.SQLGetDataReturnLength, Self.SQLGetDataReturnLengthPtr)
                If Omitted(_trailingZero) = False
                    If _trailingZero
                        Case _convertFunction
                        Of C25_SQLC_CHAR
                            Self.StBuffer.SetSlice(Self.StBufferRequiredLength + 1, Self.StBufferRequiredLength + 1, Chr(0) )
                        ELSE
                            Self.StBuffer.SetSlice(Self.StBufferRequiredLength + 1, Self.StBufferRequiredLength + 1 + 1, Chr(0) + Chr(0) )
                        End
                    End
                End
                c25_memcpy(_targetPtr, Self.StBuffer.GetAddress(), _maxTargetBytesLen)
                If _returnData
                    Return Self.StBuffer.GetValue()
                End
            End
        End
        Return ''

c25_MsSqlClass.SQLGetData_SQL_DATETIME               Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>)

    Code
    Return ''

c25_MsSqlClass.SQLGetData_SQL_DECIMAL                Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _precision>, <Long _places>, <String _formatPicture>, <Long _trailingZero>)

    Code
    Return ''

c25_MsSqlClass.SQLGetData_SQL_DOUBLE                 Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _precision>, <Long _places>, <String _formatPicture>, <Long _trailingZero>)

    Code
    Return ''

c25_MsSqlClass.SQLGetData_SQL_FLOAT                  Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _precision>, <Long _places>, <String _formatPicture>, <Long _trailingZero>)

    Code
    Return ''

c25_MsSqlClass.SQLGetData_SQL_GUID                   Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>)

    Code
    Return ''

c25_MsSqlClass.SQLGetData_SQL_INTEGER                Procedure |
                                        ( |
                                        <Byte       _returnData            >, |
                                        Long        _columnOrdinal          , |
                                        <Long       _targetPtr             >, |
                                        <*Byte      _isNull                >, |
                                        <String     _returnValueIfNull     >, |
                                        <Long       _maxTargetBytesLen     >, |
                                        <Long       _clarionTargetType     >, |
                                        <Long       _convertFunction       >, |
                                        <Long       _trailingZero    >  |
                                        )

    Code
        Self.IntValue = 0
        If omitted(_isNull) = False
            _isNull = 0
        End
        Self.IntValue = 0
        Self.SQLGetDataReturnLength = 0
        Case _convertFunction
        Of ConvertFunction:SQLC_LONG
            Self.SQLRETURN = C25_SQLGetData(Self.StmtHandle, _columnOrdinal, C25_SQLC_LONG, Self.IntValuePtr, 0, Self.SQLGetDataReturnLengthPtr)
            If Self.SQLRETURN = 0
                If Self.SQLGetDataReturnLength = 4
                    c25_memcpy(_targetPtr, Self.IntValuePtr, 4)
                    Return Self.IntValue
                ELSE
                    c25_memcpy(_targetPtr, Self.IntValuePtr, 4)
                    If omitted(_isNull) = False
                        _isNull = TRUE
                    End
                    If omitted(_returnValueIfNull) = False
                        Return Clip(_returnValueIfNull)
                    Else
                        Return '0'
                    End
                End
            End
        Of ConvertFunction:SQLC_ULONG
            Self.SQLRETURN = C25_SQLGetData(Self.StmtHandle, _columnOrdinal, C25_SQLC_LONG, Self.IntValuePtr, 0, Self.SQLGetDataReturnLengthPtr)
            If Self.SQLRETURN = 0
                If Self.SQLGetDataReturnLength = 4
                    c25_memcpy(_targetPtr, Self.IntValuePtr, 4)
                    Self.ULONGValue = Self.IntValue
                    Return Self.ULONGValue
                ELSE
                    c25_memcpy(_targetPtr, Self.IntValuePtr, 4)
                    If omitted(_isNull) = False
                        _isNull = TRUE
                    End
                    If omitted(_returnValueIfNull) = False
                        Return Clip(_returnValueIfNull)
                    Else
                        Return '0'
                    End
                End
            End
        End
        Return '0'

c25_MsSqlClass.SQLGetData_SQL_INTERVAL                Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>)

    Code
        Return ''

c25_MsSqlClass.SQLGetData_SQL_INTERVAL_DAY_TO_HOUR   Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>)

    Code
    Return ''

c25_MsSqlClass.SQLGetData_SQL_INTERVAL_DAY_TO_MINUTE Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>)

    Code
    Return ''

c25_MsSqlClass.SQLGetData_SQL_INTERVAL_DAY_TO_SECOND Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>)

    Code
    Return ''

c25_MsSqlClass.SQLGetData_SQL_INTERVAL_HOUR          Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>)

    Code
    Return ''

c25_MsSqlClass.SQLGetData_SQL_INTERVAL_HOUR_TO_MINUTE Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>)

    Code
    Return ''

c25_MsSqlClass.SQLGetData_SQL_INTERVAL_HOUR_TO_SECOND Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>)

    Code
    Return ''

c25_MsSqlClass.SQLGetData_SQL_INTERVAL_MINUTE        Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>)

    Code
    Return ''

c25_MsSqlClass.SQLGetData_SQL_INTERVAL_MINUTE_TO_SECOND    Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>)

    Code
    Return ''

c25_MsSqlClass.SQLGetData_SQL_INTERVAL_YEAR          Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>)

    Code
    Return ''

c25_MsSqlClass.SQLGetData_SQL_INTERVAL_YEAR_TO_MONTH Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>)

    Code
    Return ''

c25_MsSqlClass.SQLGetData_SQL_LONGVARBINARY          Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>)

    Code
    Return ''

c25_MsSqlClass.SQLGetData_SQL_LONGVARCHAR            Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>)

    Code
    Return ''

c25_MsSqlClass.SQLGetData_SQL_NUMERIC                Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>)

    Code
    Return ''

c25_MsSqlClass.SQLGetData_SQL_REAL                   Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>)

    Code
    Return ''

c25_MsSqlClass.SQLGetData_SQL_SMALLINT               Procedure |
                                        ( |
                                        <Byte       _returnData            >, |
                                        Long        _columnOrdinal          , |
                                        <Long       _targetPtr             >, |
                                        <*Byte      _isNull                >, |
                                        <String     _returnValueIfNull     >, |
                                        <Long       _maxTargetBytesLen     >, |
                                        <Long       _clarionTargetType     >, |
                                        <Long       _convertFunction       >, |
                                        <Long       _trailingZero    >  |
                                        )

    Code
        If omitted(_isNull) = False
            _isNull = 0
        End
        Self.ShortValue = 0
        Self.SQLGetDataReturnLength = 0
        Case _convertFunction
        Of ConvertFunction:SQLC_SHORT
            Self.SQLRETURN = C25_SQLGetData(Self.StmtHandle, _columnOrdinal, C25_SQLC_SHORT, Self.ShortValuePtr, 0, Self.SQLGetDataReturnLengthPtr)
            If Self.SQLRETURN = 0
                If Self.SQLGetDataReturnLength = 2
                    c25_memcpy(_targetPtr, Self.ShortValuePtr, 2)
                    Return Self.IntValue
                ELSE
                    c25_memcpy(_targetPtr, Self.ShortValuePtr, 2)
                    If omitted(_isNull) = False
                        _isNull = TRUE
                    End
                    If omitted(_returnValueIfNull) = False
                        Return Clip(_returnValueIfNull)
                    Else
                        Return '0'
                    End
                End
            End
        Of ConvertFunction:SQLC_USHORT
            Self.SQLRETURN = C25_SQLGetData(Self.StmtHandle, _columnOrdinal, C25_SQLC_SHORT, Self.ShortValuePtr, 0, Self.SQLGetDataReturnLengthPtr)
            If Self.SQLRETURN = 0
                If Self.SQLGetDataReturnLength = 2
                    c25_memcpy(_targetPtr, Self.ShortValuePtr, 2)
                    Self.USHORTValue = Self.ShortValue
                    Return Self.USHORTValue
                ELSE
                    c25_memcpy(_targetPtr, Self.ShortValuePtr, 2)
                    If omitted(_isNull) = False
                        _isNull = TRUE
                    End
                    If omitted(_returnValueIfNull) = False
                        Return Clip(_returnValueIfNull)
                    Else
                        Return '0'
                    End
                End
            End
        End
        Return '0'

c25_MsSqlClass.SQLGetData_SQL_TIMESTAMP              Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>)

    Code
    Return ''

c25_MsSqlClass.SQLGetData_SQL_TINYINT                Procedure |
                                         ( |
                                        <Byte       _returnData            >, |
                                        Long        _columnOrdinal          , |
                                        <Long       _targetPtr             >, |
                                        <*Byte      _isNull                >, |
                                        <String     _returnValueIfNull     >, |
                                        <Long       _maxTargetBytesLen     >, |
                                        <Long       _clarionTargetType     >, |
                                        <Long       _convertFunction       >, |
                                        <Long       _trailingZero    >  |
                                        )

    Code
        If omitted(_isNull) = False
            _isNull = 0
        End
        Self.TinyIntValue = 0
        Self.SQLGetDataReturnLength = 0
        Case _convertFunction
        Of ConvertFunction:SQLC_TINYINT
            Self.SQLRETURN = C25_SQLGetData(Self.StmtHandle, _columnOrdinal, C25_SQLC_TINYINT, Self.TinyIntValuePtr, 0, Self.SQLGetDataReturnLengthPtr)
            If Self.SQLRETURN = 0
                If Self.SQLGetDataReturnLength = 1
                    c25_memcpy(_targetPtr, Self.TinyIntValuePtr, 1)
                    Return Self.IntValue
                ELSE
                    c25_memcpy(_targetPtr, Self.TinyIntValuePtr, 1)
                    If omitted(_isNull) = False
                        _isNull = TRUE
                    End
                    If omitted(_returnValueIfNull) = False
                        Return Clip(_returnValueIfNull)
                    Else
                        Return '0'
                    End
                End
            End
        Of ConvertFunction:SQLC_UTinyInt
            Self.SQLRETURN = C25_SQLGetData(Self.StmtHandle, _columnOrdinal, C25_SQLC_TINYINT, Self.TinyIntValuePtr, 0, Self.SQLGetDataReturnLengthPtr)
            If Self.SQLRETURN = 0
                If Self.SQLGetDataReturnLength = 1
                    c25_memcpy(_targetPtr, Self.TinyIntValuePtr, 1)
                    Self.UTinyIntValue = Self.TinyIntValue
                    Return Self.UTinyIntValue
                ELSE
                    c25_memcpy(_targetPtr, Self.TinyIntValuePtr, 1)
                    If omitted(_isNull) = False
                        _isNull = TRUE
                    End
                    If omitted(_returnValueIfNull) = False
                        Return Clip(_returnValueIfNull)
                    Else
                        Return '0'
                    End
                End
            End
        End
        Return '0'

c25_MsSqlClass.SQLGetData_SQL_TYPE_DATE              Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>)

    Code
    Return ''

c25_MsSqlClass.SQLGetData_SQL_TYPE_TIME              Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>)

    Code
    Return ''

c25_MsSqlClass.SQLGetData_SQL_TYPE_TIMESTAMP         Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>)

    Code
    Return ''

c25_MsSqlClass.SQLGetData_SQL_TYPE_UTCDATETIME       Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>)

    Code
    Return ''

c25_MsSqlClass.SQLGetData_SQL_TYPE_UTCTIME           Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>)

    Code
    Return ''

c25_MsSqlClass.SQLGetData_SQL_VARBINARY              Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>)

AdrGroup                        Group,pre(AdrGroup)
PtrAddress                          Long
PtrSize                             Long
                                End
AnyRef                          ANY
STRINGREF                       &String
GrpStringRef                    Group,Pre(GrpStringRef)
STRREF                              &String
                                End
AddressAndSizeFromAny           String(8),over(AdrGroup)
Str8                            String(8)

    Code
        If _maxTargetBytesLen < 1
            Return ''
        End
        If omitted(_isNull) = False
            _isNull = 0
        End
        Self.SQLGetDataReturnLength = 0
        Self.SQLRETURN = C25_SQLGetData(Self.StmtHandle, _columnOrdinal, C25_SQLC_CHAR, Self.CharBuffer2MBPtr, 0, Self.SQLGetDataReturnLengthPtr)
        If Self.SQLGetDataReturnLength > 0
            Self.StBufferRequiredLength = Self.SQLGetDataReturnLength + 2
            Case _clarionTargetType
            Of ClaDataTypeEnum:STRINGREF
                STRINGREF &= NEW String(Self.StBufferRequiredLength)
                Self.SQLRETURN = C25_SQLGetData(Self.StmtHandle, _columnOrdinal, C25_SQLC_CHAR, Address(STRINGREF), Self.StBufferRequiredLength, Self.SQLGetDataReturnLengthPtr)
                GrpStringRef.STRREF &= STRINGREF
                AnyRef &=  WHAT(GrpStringRef,1)
                AddressAndSizeFromAny = AnyRef
                AnyRef &= NULL
                GrpStringRef.STRREF &= NULL
                Str8 = AddressAndSizeFromAny
                c25_memcpy(_targetPtr, Address(Str8), 8)
                If _returnData
                    Return STRINGREF
                End
            Of ClaDataTypeEnum:String
                If not Self.StBuffer &= NULL
                    Dispose(Self.StBuffer)
                End
                Self.StBuffer &= NEW StringTheory()
                Self.StBuffer.Start()
                Self.StBuffer.SetValue(All(Chr(32),_maxTargetBytesLen))
                Self.SQLRETURN = C25_SQLGetData(Self.StmtHandle, _columnOrdinal, C25_SQLC_CHAR, Self.StBuffer.GetAddress(), Self.StBufferRequiredLength, Self.SQLGetDataReturnLengthPtr)
                c25_memcpy(_targetPtr, Self.StBuffer.GetAddress(), _maxTargetBytesLen)
                If _returnData
                    Return Self.StBuffer.GetValue()
                End
            End
        End
        Return ''


c25_MsSqlClass.SQLGetData_SQL_VARCHAR                Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>)

AdrGroup                        Group,pre(AdrGroup)
PtrAddress                          Long
PtrSize                             Long
                                End
AnyRef                          ANY
STRINGREF                       &String
GrpStringRef                    Group,Pre(GrpStringRef)
STRREF                              &String
                                End
AddressAndSizeFromAny           String(8),over(AdrGroup)
Str8                            String(8)

    Code

        If _maxTargetBytesLen < 1
            Return ''
        End
        If omitted(_isNull) = False
            _isNull = 0
        End
        Self.SQLGetDataReturnLength = 0
        Self.SQLRETURN = C25_SQLGetData(Self.StmtHandle, _columnOrdinal, C25_SQLC_CHAR, Self.CharBuffer2MBPtr, 0, Self.SQLGetDataReturnLengthPtr)
        If Self.SQLGetDataReturnLength > 0
            Self.StBufferRequiredLength = Self.SQLGetDataReturnLength + 1

            Case _clarionTargetType
            Of ClaDataTypeEnum:STRINGREF
                STRINGREF &= NEW String(Self.StBufferRequiredLength)
                Self.SQLRETURN = C25_SQLGetData(Self.StmtHandle, _columnOrdinal, C25_SQLC_CHAR, Address(STRINGREF), Self.StBufferRequiredLength, Self.SQLGetDataReturnLengthPtr)

                GrpStringRef.STRREF &= STRINGREF
                AnyRef &=  WHAT(GrpStringRef,1)
                AddressAndSizeFromAny = AnyRef
                AnyRef &= NULL
                GrpStringRef.STRREF &= NULL
                Str8 = AddressAndSizeFromAny
                c25_memcpy(_targetPtr, Address(Str8), 8)
                If _returnData
                    Return STRINGREF
                End
            Of ClaDataTypeEnum:String
                If not Self.StBuffer &= NULL
                    Dispose(Self.StBuffer)
                End
                Self.StBuffer &= NEW StringTheory()
                Self.StBuffer.Start()
                Self.StBuffer.SetValue(All(Chr(32),_maxTargetBytesLen))
                Self.SQLRETURN = C25_SQLGetData(Self.StmtHandle, _columnOrdinal, C25_SQLC_CHAR, Self.StBuffer.GetAddress(), Self.SQLGetDataReturnLength, Self.SQLGetDataReturnLengthPtr)
                If Omitted(_trailingZero) = False
                    If _trailingZero
                        Case _convertFunction
                        Of C25_SQLC_CHAR
                            Self.StBuffer.SetSlice(Self.StBufferRequiredLength + 1, Self.StBufferRequiredLength + 1, Chr(0) )
                        ELSE
                            Self.StBuffer.SetSlice(Self.StBufferRequiredLength + 1, Self.StBufferRequiredLength + 1 + 1, Chr(0) + Chr(0) )
                        End
                    End
                End
                c25_memcpy(_targetPtr, Self.StBuffer.GetAddress(), _maxTargetBytesLen)
                If _returnData
                    Return Self.StBuffer.GetValue()
                End
            End
        End
        Return ''

c25_MsSqlClass.SQLGetData_SQL_WCHAR                  Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>)

AdrGroup                        Group,pre(AdrGroup)
PtrAddress                          Long
PtrSize                             Long
                                End
AnyRef                          ANY
STRINGREF                       &String
GrpStringRef                    Group,Pre(GrpStringRef)
STRREF                              &String
                                End
AddressAndSizeFromAny           String(8),over(AdrGroup)
Str8                            String(8)

    Code
        If _maxTargetBytesLen < 1
            Return ''
        End
        If omitted(_isNull) = False
            _isNull = 0
        End
        Self.SQLGetDataReturnLength = 0
        Self.SQLRETURN = C25_SQLGetData(Self.StmtHandle, _columnOrdinal, C25_SQLC_CHAR, Self.CharBuffer2MBPtr, 0, Self.SQLGetDataReturnLengthPtr)
        If Self.SQLGetDataReturnLength > 0
            Self.StBufferRequiredLength = Self.SQLGetDataReturnLength + 2
            Case _clarionTargetType
            Of ClaDataTypeEnum:STRINGREF
                STRINGREF &= NEW String(Self.StBufferRequiredLength)
                Self.SQLRETURN = C25_SQLGetData(Self.StmtHandle, _columnOrdinal, C25_SQLC_CHAR, Address(STRINGREF), Self.StBufferRequiredLength, Self.SQLGetDataReturnLengthPtr)
                GrpStringRef.STRREF &= STRINGREF
                AnyRef &=  WHAT(GrpStringRef,1)
                AddressAndSizeFromAny = AnyRef
                AnyRef &= NULL
                GrpStringRef.STRREF &= NULL
                Str8 = AddressAndSizeFromAny
                c25_memcpy(_targetPtr, Address(Str8), 8)
                If _returnData
                    Return STRINGREF
                End
            Of ClaDataTypeEnum:String
                If not Self.StBuffer &= NULL
                    Dispose(Self.StBuffer)
                End
                Self.StBuffer &= NEW StringTheory()
                Self.StBuffer.Start()
                Self.StBuffer.SetValue(All(Chr(32),_maxTargetBytesLen))
                Self.SQLRETURN = C25_SQLGetData(Self.StmtHandle, _columnOrdinal, C25_SQLC_CHAR, Self.StBuffer.GetAddress(), Self.StBufferRequiredLength, Self.SQLGetDataReturnLengthPtr)
                c25_memcpy(_targetPtr, Self.StBuffer.GetAddress(), _maxTargetBytesLen)
                If _returnData
                    Return Self.StBuffer.GetValue()
                End
            End
        End
        Return ''

c25_MsSqlClass.SQLGetData_SQL_WLONGVARCHAR           Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>)

    Code
    Return ''

c25_MsSqlClass.SQLGetData_SQL_WVARCHAR               Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>)

AdrGroup                        Group,pre(AdrGroup)
PtrAddress                          Long
PtrSize                             Long
                                End
AnyRef                          ANY
STRINGREF                       &String
GrpStringRef                    Group,Pre(GrpStringRef)
STRREF                              &String
                                End
AddressAndSizeFromAny           String(8),over(AdrGroup)
Str8                            String(8)

    Code

        If _maxTargetBytesLen < 1
            Return ''
        End
        If omitted(_isNull) = False
            _isNull = 0
        End
        Self.SQLGetDataReturnLength = 0
        Self.SQLRETURN = C25_SQLGetData(Self.StmtHandle, _columnOrdinal, C25_SQLC_WCHAR, Self.CharBuffer2MBPtr, 0, Self.SQLGetDataReturnLengthPtr)
        If Self.SQLGetDataReturnLength > 0
            Self.StBufferRequiredLength = Self.SQLGetDataReturnLength + 2
            Case _clarionTargetType
            Of ClaDataTypeEnum:STRINGREF
                STRINGREF &= NEW String(Self.StBufferRequiredLength)
                Self.SQLRETURN = C25_SQLGetData(Self.StmtHandle, _columnOrdinal, C25_SQLC_WCHAR, Address(STRINGREF), Self.StBufferRequiredLength, Self.SQLGetDataReturnLengthPtr)
                GrpStringRef.STRREF &= STRINGREF
                AnyRef &=  WHAT(GrpStringRef,1)
                AddressAndSizeFromAny = AnyRef
                AnyRef &= NULL
                GrpStringRef.STRREF &= NULL
                Str8 = AddressAndSizeFromAny
                c25_memcpy(_targetPtr, Address(Str8), 8)
                If _returnData
                    Return STRINGREF
                End
            Of ClaDataTypeEnum:String
                If not Self.StBuffer &= NULL
                    Dispose(Self.StBuffer)
                End
                Self.StBuffer &= NEW StringTheory()
                Self.StBuffer.Start()
                Self.StBuffer.SetValue(All(Chr(32),_maxTargetBytesLen))
                Self.SQLRETURN = C25_SQLGetData(Self.StmtHandle, _columnOrdinal, C25_SQLC_WCHAR, Self.StBuffer.GetAddress(), Self.StBufferRequiredLength, Self.SQLGetDataReturnLengthPtr)
                c25_memcpy(_targetPtr, Self.StBuffer.GetAddress(), _maxTargetBytesLen)
                If _returnData
                    Return Self.StBuffer.GetValue()
                End
            End
        End
        Return ''

c25_MsSqlClass.GetClaDataReflectionAnalyze           Procedure(*queue _qRows)

    Code
        If Self.ClarionFields &= NULL
            Self.ClarionFields &= New ClarionFields_TYPE()
        Else
            Free(Self.ClarionFields)
        End

        If not Self.DataReflection &= NULL
            Dispose(Self.DataReflection)
        End

        Self.DataReflection &= NEW c25_DataReflectionClass()
        Self.DataReflection.Analyze(_qRows, Self.ClarionFields, , , ,True)

        Return ''

c25_MsSqlClass.GetMsSqlInformationSchema             Procedure(String _sqlMeta)

SQLRef   &String

    Code
        If Self.MsSqlMeta &= NULL
            Self.MsSqlMeta &= New MsSqlInformationSchema_TYPE()
        ELSE
            Free(Self.MsSqlMeta)
        End

        Self.StmtHandle = Self.AllocHandle(,True)
        If Self.StmtHandle = 0
            Return 0
        End
        Self.StSql.SetValue(Clip(_sqlMeta))

        SQLRef &= Self.BitConverter.AnsiToUtf16(Self.StSql.GetValue() & Chr(0) ,,true)

        Self.SQLRowCount        = 0
        Self.SQLColumnsCount    = 0

        Self.SQLRETURN = C25_SQLSetStmtAttrW(Self.StmtHandle, C25_SQL_ATTR_CONCURRENCY            , C25_SQL_CONCUR_VALUES , 0)
        Self.SQLRETURN = C25_SQLSetStmtAttrW(Self.StmtHandle, C25_SQL_ATTR_CURSOR_TYPE            , C25_SQL_CURSOR_FORWARD_ONLY,0)

        Self.SQLRETURN = C25_SQLExecDirectW(Self.StmtHandle, Address(SQLRef), C25_SQL_NTS)
        If Self.SQLRETURN <> 0 And Self.SQLRETURN <> 1 And Self.SQLRETURN <> 100
            Message('Error C25_SQLExecDirectW')
            Self.SQLGetDiagRec_STMT()
            Return 0
        End
        Self.SQLRETURN = C25_SQLRowCount(Self.StmtHandle,Address(Self.SQLRowCount))

        If Self.SQLRowCount > 0
            Self.SQLRETURN = C25_SQLFetchScroll(Self.StmtHandle, C25_SQL_FETCH_FIRST, 0)
            If Self.SQLRETURN <> 0 And Self.SQLRETURN <> 1 And Self.SQLRETURN <> 100
                Message('Error C25_SQLFetchScroll')
                Return 0
            End
        End

        Self.SQLNumResultCols = 0
        Self.SQLRETURN = C25_SQLNumResultCols(Self.StmtHandle,Address(Self.SQLNumResultCols))

        I# = 0
        Loop Self.SQLNumResultCols Times
            I# = I# + 1

            Clear(Self.MsSqlMeta)

            Clear(Self.Describe_ColumnName)

            Self.Describe_NameLength        = 0
            Self.Describe_DataType          = 0
            Self.Describe_ColumnSize        = 0
            Self.Describe_DecimalDigits     = 0
            Self.Describe_Nullable          = 0

            Self.SQLRETURN = C25_SQLDescribeColW(Self.StmtHandle, I#, Self.Describe_ColumnNamePtr, Self.Describe_ColumnNameSize, Self.Describe_NameLengthPtr, Self.Describe_DataTypePtr, Self.Describe_ColumnSizePtr, Self.Describe_DecimalDigitsPtr,Self.Describe_NullablePtr)
            If Self.SQLRETURN <> 0 And Self.SQLRETURN <> 1 And Self.SQLRETURN <> 100
                Self.SQLGetDiagRec_STMT()
                Message('Error C25_SQLDescribeColW')
                Return 0
            End
            If Self.Describe_NameLength > 0
                Self.MsSqlMeta.ColumnName = Self.BitConverter.Utf16ToAnsiStr(Self.Describe_ColumnName[1 : (Self.Describe_NameLength*2)])
            End
            Self.MsSqlMeta.ColumnSize          = Self.Describe_ColumnSize
            Self.MsSqlMeta.DecimalDigits       = Self.Describe_DecimalDigits

            Self.MsSqlMeta.DataTypeEnum        = Self.Describe_DataType
            Self.MsSqlMeta.DataType            = Self.SqlType1ToString(Self.MsSqlMeta.DataTypeEnum)
            Self.MsSqlMeta.ExecDataEnum        = Self.SqlType1ToExecDataEnum(Self.MsSqlMeta.DataTypeEnum)

            Self.MsSqlMeta.IsUtf16             = Self.SqlType1IsUtf16(Self.MsSqlMeta.DataTypeEnum)
            Self.MsSqlMeta.IsAnsi              = Self.SqlType1IsAnsi(Self.MsSqlMeta.DataTypeEnum)
            Self.MsSqlMeta.IsByte              = Self.SqlType1IsByte(Self.MsSqlMeta.DataTypeEnum)
            Self.MsSqlMeta.IsShort             = Self.SqlType1IsShort(Self.MsSqlMeta.DataTypeEnum)
            Self.MsSqlMeta.IsLong              = Self.SqlType1IsLong(Self.MsSqlMeta.DataTypeEnum)
            Self.MsSqlMeta.IsInt64             = Self.SqlType1IsInt64(Self.MsSqlMeta.DataTypeEnum)
            Self.MsSqlMeta.IsReal              = Self.SqlType1IsReal(Self.MsSqlMeta.DataTypeEnum)
            Self.MsSqlMeta.IsDecimal           = Self.SqlType1IsDecimal(Self.MsSqlMeta.DataTypeEnum)
            Self.MsSqlMeta.IsNumeric           = Self.SqlType1IsNumeric(Self.MsSqlMeta.DataTypeEnum)
            Self.MsSqlMeta.IsBinary            = Self.SqlType1IsBinary(Self.MsSqlMeta.DataTypeEnum)
            Self.MsSqlMeta.IsVariableLength    = Self.SqlType1IsVariableLength(Self.MsSqlMeta.DataTypeEnum)

            Self.MsSqlMeta.IsNullable          = Self.Describe_Nullable

            If Self.Describe_NameLength > 0
                Self.MsSqlMeta.ColumnName = Self.BitConverter.Utf16ToAnsiStr(Self.Describe_ColumnName[1 : (Self.Describe_NameLength*2)])
            End

            Self.MsSqlMeta.SQL_DESC_ALLOC_TYPE             = Self.SQLColAttribute(I#,C25_SQL_DESC_ALLOC_TYPE)
            Self.MsSqlMeta.SQL_DESC_ARRAY_SIZE             = Self.SQLColAttribute(I#,C25_SQL_DESC_ARRAY_SIZE)
            Self.MsSqlMeta.SQL_DESC_ARRAY_STATUS_PTR       = Self.SQLColAttribute(I#,C25_SQL_DESC_ARRAY_STATUS_PTR)
            Self.MsSqlMeta.SQL_DESC_AUTO_UNIQUE_VALUE      = Self.SQLColAttribute(I#,C25_SQL_DESC_AUTO_UNIQUE_VALUE)
            Self.MsSqlMeta.SQL_DESC_BASE_COLUMN_NAME       = Self.SQLColAttribute(I#,C25_SQL_DESC_BASE_COLUMN_NAME)
            Self.MsSqlMeta.SQL_DESC_BASE_TABLE_NAME        = Self.SQLColAttribute(I#,C25_SQL_DESC_BASE_TABLE_NAME)
            Self.MsSqlMeta.SQL_DESC_BIND_OFFSET_PTR        = Self.SQLColAttribute(I#,C25_SQL_DESC_BIND_OFFSET_PTR)
            Self.MsSqlMeta.SQL_DESC_BIND_TYPE              = Self.SQLColAttribute(I#,C25_SQL_DESC_BIND_TYPE)
            Self.MsSqlMeta.SQL_DESC_CASE_SENSITIVE         = Self.SQLColAttribute(I#,C25_SQL_DESC_CASE_SENSITIVE)
            Self.MsSqlMeta.SQL_DESC_CATALOG_NAME           = Self.SQLColAttribute(I#,C25_SQL_DESC_CATALOG_NAME)
            Self.MsSqlMeta.SQL_DESC_CONCISE_TYPE           = Self.SQLColAttribute(I#,C25_SQL_DESC_CONCISE_TYPE)
            Self.MsSqlMeta.SQL_DESC_COUNT                  = Self.SQLColAttribute(I#,C25_SQL_DESC_COUNT)
            Self.MsSqlMeta.SQL_DESC_DATA_PTR               = Self.SQLColAttribute(I#,C25_SQL_DESC_DATA_PTR)
            Self.MsSqlMeta.SQL_DESC_DATETIME_INTERVAL_CODE = Self.SQLColAttribute(I#,C25_SQL_DESC_DATETIME_INTERVAL_CODE)
            Self.MsSqlMeta.SQL_DESC_DISPLAY_SIZE           = Self.SQLColAttribute(I#,C25_SQL_DESC_DISPLAY_SIZE)
            Self.MsSqlMeta.SQL_DESC_FIXED_PREC_SCALE       = Self.SQLColAttribute(I#,C25_SQL_DESC_FIXED_PREC_SCALE)
            Self.MsSqlMeta.SQL_DESC_INDICATOR_PTR          = Self.SQLColAttribute(I#,C25_SQL_DESC_INDICATOR_PTR)
            Self.MsSqlMeta.SQL_DESC_LABEL                  = Self.SQLColAttribute(I#,C25_SQL_DESC_LABEL)
            Self.MsSqlMeta.SQL_DESC_LENGTH                 = Self.SQLColAttribute(I#,C25_SQL_DESC_LENGTH)
            Self.MsSqlMeta.SQL_DESC_LITERAL_PREFIX         = Self.SQLColAttribute(I#,C25_SQL_DESC_LITERAL_PREFIX)
            Self.MsSqlMeta.SQL_DESC_LITERAL_SUFFIX         = Self.SQLColAttribute(I#,C25_SQL_DESC_LITERAL_SUFFIX)
            Self.MsSqlMeta.SQL_DESC_LOCAL_TYPE_NAME        = Self.SQLColAttribute(I#,C25_SQL_DESC_LOCAL_TYPE_NAME)
            Self.MsSqlMeta.SQL_DESC_MAXIMUM_SCALE          = Self.SQLColAttribute(I#,C25_SQL_DESC_MAXIMUM_SCALE)
            Self.MsSqlMeta.SQL_DESC_MINIMUM_SCALE          = Self.SQLColAttribute(I#,C25_SQL_DESC_MINIMUM_SCALE)
            Self.MsSqlMeta.SQL_DESC_NAME                   = Self.SQLColAttribute(I#,C25_SQL_DESC_NAME)
            Self.MsSqlMeta.SQL_DESC_NULLABLE               = Self.SQLColAttribute(I#,C25_SQL_DESC_NULLABLE)
            Self.MsSqlMeta.SQL_DESC_NUM_PREC_RADIX         = Self.SQLColAttribute(I#,C25_SQL_DESC_NUM_PREC_RADIX)
            Self.MsSqlMeta.SQL_DESC_OCTET_LENGTH           = Self.SQLColAttribute(I#,C25_SQL_DESC_OCTET_LENGTH)
            Self.MsSqlMeta.SQL_DESC_OCTET_LENGTH_PTR       = Self.SQLColAttribute(I#,C25_SQL_DESC_OCTET_LENGTH_PTR)
            Self.MsSqlMeta.SQL_DESC_PARAMETER_TYPE         = Self.SQLColAttribute(I#,C25_SQL_DESC_PARAMETER_TYPE)
            Self.MsSqlMeta.SQL_DESC_PRECISION              = Self.SQLColAttribute(I#,C25_SQL_DESC_PRECISION)
            Self.MsSqlMeta.SQL_DESC_ROWS_PROCESSED_PTR     = Self.SQLColAttribute(I#,C25_SQL_DESC_ROWS_PROCESSED_PTR)
            Self.MsSqlMeta.SQL_DESC_ROWVER                 = Self.SQLColAttribute(I#,C25_SQL_DESC_ROWVER)
            Self.MsSqlMeta.SQL_DESC_SCALE                  = Self.SQLColAttribute(I#,C25_SQL_DESC_SCALE)
            Self.MsSqlMeta.SQL_DESC_SCHEMA_NAME            = Self.SQLColAttribute(I#,C25_SQL_DESC_SCHEMA_NAME)
            Self.MsSqlMeta.SQL_DESC_SEARCHABLE             = Self.SQLColAttribute(I#,C25_SQL_DESC_SEARCHABLE)
            Self.MsSqlMeta.SQL_DESC_TABLE_NAME             = Self.SQLColAttribute(I#,C25_SQL_DESC_TABLE_NAME)
            Self.MsSqlMeta.SQL_DESC_TYPE                   = Self.SQLColAttribute(I#,C25_SQL_DESC_TYPE)
            Self.MsSqlMeta.SQL_DESC_TYPE_NAME              = Self.SQLColAttribute(I#,C25_SQL_DESC_TYPE_NAME)
            Self.MsSqlMeta.SQL_DESC_UNNAMED                = Self.SQLColAttribute(I#,C25_SQL_DESC_UNNAMED)
            Self.MsSqlMeta.SQL_DESC_UNSIGNED               = Self.SQLColAttribute(I#,C25_SQL_DESC_UNSIGNED)
            Self.MsSqlMeta.SQL_DESC_UPDATABLE              = Self.SQLColAttribute(I#,C25_SQL_DESC_UPDATABLE)

            If Self.MsSqlMeta.IsBinary
                If Self.MsSqlMeta.IsVariableLength
                    Self.MsSqlMeta.ClaDataBaseType         = 'STRINGREF'
                    Self.MsSqlMeta.ClaDataBaseTypeEnum     = ClaDataTypeEnum:STRINGREF
                Else
                    Self.MsSqlMeta.ClaDataBaseType         = 'String'
                    Self.MsSqlMeta.ClaDataBaseTypeEnum     = ClaDataTypeEnum:String
                End
                Self.MsSqlMeta.ClaDataType         = 'String'
                Self.MsSqlMeta.ClaDataTypeEnum     = ClaDataTypeEnum:String
                Self.MsSqlMeta.BindColLength = Self.MsSqlMeta.ColumnSize
            ElsIf Self.MsSqlMeta.IsAnsi
                If Self.MsSqlMeta.IsVariableLength
                    Self.MsSqlMeta.ClaDataBaseType         = 'STRINGREF'
                    Self.MsSqlMeta.ClaDataBaseTypeEnum     = ClaDataTypeEnum:STRINGREF
                Else
                    Self.MsSqlMeta.ClaDataBaseType         = 'String'
                    Self.MsSqlMeta.ClaDataBaseTypeEnum     = ClaDataTypeEnum:String
                End
                Self.MsSqlMeta.ClaDataType         = 'STRINGANSI'
                Self.MsSqlMeta.ClaDataTypeEnum     = ClaDataTypeEnum:STRINGANSI
                Self.MsSqlMeta.BindColLength = Self.MsSqlMeta.ColumnSize
            ElsIf Self.MsSqlMeta.IsUtf16 Or Self.MsSqlMeta.IsUtf8 Or Self.MsSqlMeta.IsUtf32
                If Self.MsSqlMeta.IsVariableLength
                    Self.MsSqlMeta.ClaDataBaseType         = 'STRINGREF'
                    Self.MsSqlMeta.ClaDataBaseTypeEnum     = ClaDataTypeEnum:STRINGREF
                Else
                    Self.MsSqlMeta.ClaDataBaseType         = 'String'
                    Self.MsSqlMeta.ClaDataBaseTypeEnum     = ClaDataTypeEnum:String
                End
                If Self.MsSqlMeta.IsUtf8
                    Self.MsSqlMeta.ClaDataType         = 'STRINGUTF8'
                    Self.MsSqlMeta.ClaDataTypeEnum     = ClaDataTypeEnum:STRINGUTF8
                ElsIf Self.MsSqlMeta.IsUtf16
                    Self.MsSqlMeta.ClaDataType         = 'STRINGUTF16'
                    Self.MsSqlMeta.ClaDataTypeEnum     = ClaDataTypeEnum:STRINGUTF16
                ElsIf Self.MsSqlMeta.IsUtf32
                    Self.MsSqlMeta.ClaDataType         = 'STRINGUTF32'
                    Self.MsSqlMeta.ClaDataTypeEnum     = ClaDataTypeEnum:STRINGUTF32
                End
                Self.MsSqlMeta.BindColLength = Self.MsSqlMeta.ColumnSize
            End

            If Self.MsSqlMeta.IsByte
                Self.MsSqlMeta.ClaDataBaseType         = 'Byte'
                Self.MsSqlMeta.ClaDataBaseTypeEnum     = ClaDataTypeEnum:Byte
                Self.MsSqlMeta.ClaDataType             = 'Byte'
                Self.MsSqlMeta.ClaDataTypeEnum         = ClaDataTypeEnum:Byte
                Self.MsSqlMeta.BindColLength = Self.MsSqlMeta.ColumnSize
            ElsIf Self.MsSqlMeta.IsShort
                Self.MsSqlMeta.ClaDataBaseType         = 'Short'
                Self.MsSqlMeta.ClaDataBaseTypeEnum     = ClaDataTypeEnum:Short
                Self.MsSqlMeta.ClaDataType             = 'Short'
                Self.MsSqlMeta.ClaDataTypeEnum         = ClaDataTypeEnum:Short
                Self.MsSqlMeta.BindColLength = Self.MsSqlMeta.ColumnSize
            ElsIf Self.MsSqlMeta.IsLong
                Self.MsSqlMeta.ClaDataBaseType         = 'Long'
                Self.MsSqlMeta.ClaDataBaseTypeEnum     = ClaDataTypeEnum:Long
                Self.MsSqlMeta.ClaDataType             = 'Long'
                Self.MsSqlMeta.ClaDataTypeEnum         = ClaDataTypeEnum:Long
                Self.MsSqlMeta.BindColLength = Self.MsSqlMeta.ColumnSize
            ElsIf Self.MsSqlMeta.IsDecimal
                Self.MsSqlMeta.ClaDataBaseType         = 'DECIMAL'
                Self.MsSqlMeta.ClaDataBaseTypeEnum     = ClaDataTypeEnum:DECIMAL
                Self.MsSqlMeta.ClaDataType             = 'DECIMAL'
                Self.MsSqlMeta.ClaDataTypeEnum         = ClaDataTypeEnum:DECIMAL
                Self.MsSqlMeta.BindColLength = Self.MsSqlMeta.ColumnSize
            ElsIf Self.MsSqlMeta.IsInt64
                Self.MsSqlMeta.ClaDataBaseType         = 'Dec20'
                Self.MsSqlMeta.ClaDataBaseTypeEnum     = ClaDataTypeEnum:Dec20
                Self.MsSqlMeta.ClaDataType             = 'Dec20'
                Self.MsSqlMeta.ClaDataTypeEnum         = ClaDataTypeEnum:Dec20
                Self.MsSqlMeta.BindColLength = Self.MsSqlMeta.ColumnSize

            End

            Case Self.MsSqlMeta.DataType
            Of 'C25_SQL_INTEGER'
                Case Self.MsSqlMeta.SQL_DESC_OCTET_LENGTH
                Of 1
                    Self.MsSqlMeta.BulkBindDateTypeEnum = C25_ODBC_SQLINT1
                    Self.MsSqlMeta.BulkBindDateType = 'C25_ODBC_SQLINT1'
                Of 2
                    Self.MsSqlMeta.BulkBindDateTypeEnum = C25_ODBC_SQLINT2
                    Self.MsSqlMeta.BulkBindDateType = 'C25_ODBC_SQLINT2'
                Of 4
                    Self.MsSqlMeta.BulkBindDateTypeEnum = C25_ODBC_SQLINT4
                    Self.MsSqlMeta.BulkBindDateType = 'C25_ODBC_SQLINT4'
                Of 8
                    Self.MsSqlMeta.BulkBindDateTypeEnum = C25_ODBC_SQLINT8
                    Self.MsSqlMeta.BulkBindDateType = 'C25_ODBC_SQLINT8'
                End
            End
            Add(Self.MsSqlMeta)
        End

        Return 0

c25_MsSqlClass.SQLColAttributeReturnType             Procedure(Long _descType)

    Code
        Case _descType
        Of C25_SQL_DESC_ALLOC_TYPE
            Return 3
        Of C25_SQL_DESC_ARRAY_SIZE
            Return 4
        Of C25_SQL_DESC_ARRAY_STATUS_PTR
            Return 3
        Of C25_SQL_DESC_AUTO_UNIQUE_VALUE
            Return 1
        Of C25_SQL_DESC_BASE_COLUMN_NAME
            Return 0
        Of C25_SQL_DESC_BASE_TABLE_NAME
            Return 0
        Of C25_SQL_DESC_BIND_OFFSET_PTR
            Return 1
        Of C25_SQL_DESC_BIND_TYPE
            Return 1
        Of C25_SQL_DESC_CASE_SENSITIVE
            Return 1
        Of C25_SQL_DESC_CATALOG_NAME
            Return 0
        Of C25_SQL_DESC_CONCISE_TYPE
            Return 3
        Of C25_SQL_DESC_COUNT
            Return 3
        Of C25_SQL_DESC_DATA_PTR
            Return 1
        Of C25_SQL_DESC_DATETIME_INTERVAL_CODE
            Return 3
        Of C25_SQL_DESC_DISPLAY_SIZE
            Return 1
        Of C25_SQL_DESC_FIXED_PREC_SCALE
            Return 3
        Of C25_SQL_DESC_INDICATOR_PTR
            Return 1
        Of C25_SQL_DESC_LABEL
            Return 0
        Of C25_SQL_DESC_LENGTH
            Return 1
        Of C25_SQL_DESC_LITERAL_PREFIX
            Return 0
        Of C25_SQL_DESC_LITERAL_SUFFIX
            Return 0
        Of C25_SQL_DESC_LOCAL_TYPE_NAME
            Return 0
        Of C25_SQL_DESC_MAXIMUM_SCALE
            Return 1
        Of C25_SQL_DESC_MINIMUM_SCALE
            Return 1
        Of C25_SQL_DESC_NAME
            Return 0
        Of C25_SQL_DESC_NULLABLE
            Return 1
        Of C25_SQL_DESC_NUM_PREC_RADIX
            Return 1
        Of C25_SQL_DESC_OCTET_LENGTH
            Return 1
        Of C25_SQL_DESC_OCTET_LENGTH_PTR
            Return 1
        Of C25_SQL_DESC_PARAMETER_TYPE
            Return 3
        Of C25_SQL_DESC_PRECISION
            Return 3
        Of C25_SQL_DESC_ROWS_PROCESSED_PTR
            Return 1
        Of C25_SQL_DESC_ROWVER
            Return 3
        Of C25_SQL_DESC_SCALE
            Return 3
        Of C25_SQL_DESC_SCHEMA_NAME
            Return 0
        Of C25_SQL_DESC_SEARCHABLE
            Return 3
        Of C25_SQL_DESC_TABLE_NAME
            Return 0
        Of C25_SQL_DESC_TYPE
            Return 3
        Of C25_SQL_DESC_TYPE_NAME
            Return 0
        Of C25_SQL_DESC_UNNAMED
            Return 3
        Of C25_SQL_DESC_UNSIGNED
            Return 3
        Of C25_SQL_DESC_UPDATABLE
            Return 3
        End

        Return -1

c25_MsSqlClass.SQLColAttribute                       Procedure( Long _columnOrdinal, Long _descType)

Num Byte

    Code
        Clear(Self.CharacterAttribute)
        Self.StringLength = 0
        Self.NumericAttribute = 0

        If Self.SQLColAttributeReturnType(_descType) <> 0
            Num = TRUE
        End

        Self.SQLRETURN = C25_SQLColAttributeW(Self.StmtHandle, _columnOrdinal, _descType, Self.CharacterAttributePtr,  16000, Self.StringLengthPtr, Self.NumericAttributePtr)
        If Self.SQLRETURN <> 0
            Case Num
            Of TRUE
                Return 0
            Else
                Return ''
            End
        End

        Case Num
        Of TRUE
            Return Self.NumericAttribute
        Else
            If Self.StringLength > 0 And Self.StringLength < 16000
                Return Self.BitConverter.Utf16ToAnsiStr(Self.CharacterAttribute[1 : (Self.StringLength * 2)])
            Else
                Return ''
            End
        End
        Return 'C25_SQLColAttributeW Return error'

c25_MsSqlClass.SqlType1ToExecDataEnum                Procedure(Long _sqlType1Enum)

    Code
        Case _sqlType1Enum
        Of C25_SQL_BIGINT
            Return ExecDateEnum:BIGINT
        Of C25_SQL_BINARY
            Return ExecDateEnum:BINARY
        Of C25_SQL_BIT
            Return ExecDateEnum:BIT
        Of C25_SQL_CHAR
            Return ExecDateEnum:CHAR
        Of C25_SQL_DATETIME
            Return ExecDateEnum:DATETIME
        Of C25_SQL_DECIMAL
            Return ExecDateEnum:DECIMAL
        Of C25_SQL_DOUBLE
            Return ExecDateEnum:DOUBLE
        Of C25_SQL_FLOAT
            Return ExecDateEnum:FLOAT
        Of C25_SQL_GUID
            Return ExecDateEnum:GUID
        Of C25_SQL_INTEGER
            Return ExecDateEnum:INTEGER
        Of C25_SQL_INTERVAL
            Return ExecDateEnum:INTERVAL
        Of C25_SQL_INTERVAL_DAY
            Return ExecDateEnum:INTERVAL_DAY
        Of C25_SQL_INTERVAL_DAY_TO_HOUR
            Return ExecDateEnum:INTERVAL_DAY_TO_HOUR
        Of C25_SQL_INTERVAL_DAY_TO_MINUTE
            Return ExecDateEnum:INTERVAL_DAY_TO_MINUTE
        Of C25_SQL_INTERVAL_DAY_TO_SECOND
            Return ExecDateEnum:INTERVAL_DAY_TO_SECOND
        Of C25_SQL_INTERVAL_HOUR
            Return ExecDateEnum:INTERVAL_HOUR
        Of C25_SQL_INTERVAL_HOUR_TO_MINUTE
            Return ExecDateEnum:INTERVAL_HOUR_TO_MINUTE
        Of C25_SQL_INTERVAL_HOUR_TO_SECOND
            Return ExecDateEnum:INTERVAL_HOUR_TO_SECOND
        Of C25_SQL_INTERVAL_MINUTE
            Return ExecDateEnum:INTERVAL_MINUTE
        Of C25_SQL_INTERVAL_MINUTE_TO_SECOND
            Return ExecDateEnum:INTERVAL_MINUTE_TO_SECOND
        Of C25_SQL_INTERVAL_MONTH
            Return ExecDateEnum:INTERVAL_MONTH
        Of C25_SQL_INTERVAL_SECOND
            Return ExecDateEnum:INTERVAL_SECOND
        Of C25_SQL_INTERVAL_YEAR
            Return ExecDateEnum:INTERVAL_YEAR
        Of C25_SQL_INTERVAL_YEAR_TO_MONTH
            Return ExecDateEnum:INTERVAL_YEAR_TO_MONTH
        Of C25_SQL_LONGVARBINARY
            Return ExecDateEnum:LONGVARBINARY
        Of C25_SQL_LONGVARCHAR
            Return ExecDateEnum:LONGVARCHAR
        Of C25_SQL_NUMERIC
            Return ExecDateEnum:NUMERIC
        Of C25_SQL_REAL
            Return ExecDateEnum:REAL
        Of C25_SQL_SMALLINT
            Return ExecDateEnum:SMALLINT
        Of C25_SQL_TIMESTAMP
            Return ExecDateEnum:TIMESTAMP
        Of C25_SQL_TINYINT
            Return ExecDateEnum:TINYINT
        Of C25_SQL_TYPE_DATE
            Return ExecDateEnum:TYPE_DATE
        Of C25_SQL_TYPE_TIME
            Return ExecDateEnum:TYPE_TIME
        Of C25_SQL_TYPE_TIMESTAMP
            Return ExecDateEnum:TYPE_TIMESTAMP
        Of C25_SQL_VARBINARY
            Return ExecDateEnum:VARBINARY
        Of C25_SQL_VARCHAR
            Return ExecDateEnum:VARCHAR
        Of C25_SQL_WCHAR
            Return ExecDateEnum:WCHAR
        Of C25_SQL_WLONGVARCHAR
            Return ExecDateEnum:WLONGVARCHAR
        Of C25_SQL_WVARCHAR
            Return ExecDateEnum:WVARCHAR
        End
        Return ExecDateEnum:UNKNOWN

c25_MsSqlClass.SqlType1ToString                      Procedure(Long _sqlType1Enum)

    Code
        Case _sqlType1Enum
        Of C25_SQL_BIGINT
            Return 'C25_SQL_BIGINT'
        Of C25_SQL_BINARY
            Return 'C25_SQL_BINARY'
        Of C25_SQL_BIT
            Return 'C25_SQL_BIT'
        Of C25_SQL_CHAR
            Return 'C25_SQL_CHAR'
        Of C25_SQL_DATETIME
            Return 'C25_SQL_DATETIME'
        Of C25_SQL_DECIMAL
            Return 'C25_SQL_DECIMAL'
        Of C25_SQL_DOUBLE
            Return 'C25_SQL_DOUBLE'
        Of C25_SQL_FLOAT
            Return 'C25_SQL_FLOAT'
        Of C25_SQL_GUID
            Return 'C25_SQL_GUID'
        Of C25_SQL_INTEGER
            Return 'C25_SQL_INTEGER'
        Of C25_SQL_INTERVAL
            Return 'C25_SQL_INTERVAL'
        Of C25_SQL_INTERVAL_DAY
            Return 'C25_SQL_INTERVAL_DAY'
        Of C25_SQL_INTERVAL_DAY_TO_HOUR
            Return 'C25_SQL_INTERVAL_DAY_TO_HOUR'
        Of C25_SQL_INTERVAL_DAY_TO_MINUTE
            Return 'C25_SQL_INTERVAL_DAY_TO_MINUTE'
        Of C25_SQL_INTERVAL_DAY_TO_SECOND
            Return 'C25_SQL_INTERVAL_DAY_TO_SECOND'
        Of C25_SQL_INTERVAL_HOUR
            Return 'C25_SQL_INTERVAL_HOUR'
        Of C25_SQL_INTERVAL_HOUR_TO_MINUTE
            Return 'C25_SQL_INTERVAL_HOUR_TO_MINUTE'
        Of C25_SQL_INTERVAL_HOUR_TO_SECOND
            Return 'C25_SQL_INTERVAL_HOUR_TO_SECOND'
        Of C25_SQL_INTERVAL_MINUTE
            Return 'C25_SQL_INTERVAL_MINUTE'
        Of C25_SQL_INTERVAL_MINUTE_TO_SECOND
            Return 'C25_SQL_INTERVAL_MINUTE_TO_SECOND'
        Of C25_SQL_INTERVAL_MONTH
            Return 'C25_SQL_INTERVAL_MONTH'
        Of C25_SQL_INTERVAL_SECOND
            Return 'C25_SQL_INTERVAL_SECOND'
        Of C25_SQL_INTERVAL_YEAR
            Return 'C25_SQL_INTERVAL_YEAR'
        Of C25_SQL_INTERVAL_YEAR_TO_MONTH
            Return 'C25_SQL_INTERVAL_YEAR_TO_MONTH'
        Of C25_SQL_LONGVARBINARY
            Return 'C25_SQL_LONGVARBINARY'
        Of C25_SQL_LONGVARCHAR
            Return 'C25_SQL_LONGVARCHAR'
        Of C25_SQL_NUMERIC
            Return 'C25_SQL_NUMERIC'
        Of C25_SQL_REAL
            Return 'C25_SQL_REAL'
        Of C25_SQL_SMALLINT
            Return 'C25_SQL_SMALLINT'
        Of C25_SQL_TIMESTAMP
            Return 'C25_SQL_TIMESTAMP'
        Of C25_SQL_TINYINT
            Return 'C25_SQL_TINYINT'
        Of C25_SQL_TYPE_DATE
            Return 'C25_SQL_TYPE_DATE'
        Of C25_SQL_TYPE_TIME
            Return 'C25_SQL_TYPE_TIME'
        Of C25_SQL_TYPE_TIMESTAMP
            Return 'C25_SQL_TYPE_TIMESTAMP'
        Of C25_SQL_VARBINARY
            Return 'C25_SQL_VARBINARY'
        Of C25_SQL_VARCHAR
            Return 'C25_SQL_VARCHAR'
        Of C25_SQL_WCHAR
            Return 'C25_SQL_WCHAR'
        Of C25_SQL_WLONGVARCHAR
            Return 'C25_SQL_WLONGVARCHAR'
        Of C25_SQL_WVARCHAR
            Return 'C25_SQL_WVARCHAR'
        End
        Return 'C25_SQL_UNKNOWN'

c25_MsSqlClass.SqlType1IsUtf16                       Procedure(Long _sqlType1Enum)

    Code
        Case _sqlType1Enum
        Of C25_SQL_WCHAR
            Return True
        Of C25_SQL_WLONGVARCHAR
            Return True
        Of C25_SQL_WVARCHAR
            Return True
        End
        Return 0

c25_MsSqlClass.SqlType1IsAnsi                        Procedure(Long _sqlType1Enum)

    Code
        Case _sqlType1Enum
        Of C25_SQL_BINARY
            Return True
        Of C25_SQL_CHAR
            Return True
        Of C25_SQL_GUID
            Return True
        Of C25_SQL_LONGVARBINARY
            Return True
        Of C25_SQL_LONGVARCHAR
            Return True
        Of C25_SQL_VARBINARY
            Return True
        Of C25_SQL_VARCHAR
            Return True
        End
        Return 0

c25_MsSqlClass.SqlType1IsByte                        Procedure(Long _sqlType1Enum)

    Code
        Case _sqlType1Enum
        Of C25_SQL_BIT
            Return TRUE
        Of C25_SQL_TINYINT
            Return TRUE
        End
        Return 0

c25_MsSqlClass.SqlType1IsShort                       Procedure(Long _sqlType1Enum)

    Code
        Case _sqlType1Enum
        Of C25_SQL_SMALLINT
            Return True
        End
        Return 0

c25_MsSqlClass.SqlType1IsLong                        Procedure(Long _sqlType1Enum)

    Code
        Case _sqlType1Enum
        Of C25_SQL_INTEGER
            Return True
        Of C25_SQL_INTERVAL
            Return True
        Of C25_SQL_INTERVAL_DAY
            Return True
        Of C25_SQL_INTERVAL_DAY_TO_HOUR
            Return True
        Of C25_SQL_INTERVAL_DAY_TO_MINUTE
            Return True
        Of C25_SQL_INTERVAL_DAY_TO_SECOND
            Return True
        Of C25_SQL_INTERVAL_HOUR
            Return True
        Of C25_SQL_INTERVAL_HOUR_TO_MINUTE
            Return True
        Of C25_SQL_INTERVAL_HOUR_TO_SECOND
            Return True
        Of C25_SQL_INTERVAL_MINUTE
            Return True
        Of C25_SQL_INTERVAL_MINUTE_TO_SECOND
            Return True
        Of C25_SQL_INTERVAL_MONTH
            Return True
        Of C25_SQL_INTERVAL_SECOND
            Return True
        Of C25_SQL_INTERVAL_YEAR
            Return True
        Of C25_SQL_INTERVAL_YEAR_TO_MONTH
            Return True
        End
        Return 0

c25_MsSqlClass.SqlType1IsInt64                       Procedure(Long _sqlType1Enum)

    Code
        Case _sqlType1Enum
        Of C25_SQL_BIGINT
            Return True
         Of C25_SQL_DATETIME
            Return True
        Of C25_SQL_NUMERIC
            Return True
        Of C25_SQL_REAL
            Return True
        End
        Return 0

c25_MsSqlClass.SqlType1IsReal                        Procedure(Long _sqlType1Enum)

    Code
        Case _sqlType1Enum
        Of C25_SQL_REAL
            Return True
        End
        Return 0

c25_MsSqlClass.SqlType1IsDecimal                     Procedure(Long _sqlType1Enum)

    Code
        Case _sqlType1Enum
        Of C25_SQL_DECIMAL
            Return True
        Of C25_SQL_DOUBLE
            Return True
        Of C25_SQL_FLOAT
            Return True
        End
        Return 0

c25_MsSqlClass.SqlType1IsNumeric                     Procedure(Long _sqlType1Enum)

    Code
        Case _sqlType1Enum
        Of C25_SQL_NUMERIC
            Return True
        End
        Return 0

c25_MsSqlClass.SqlType1IsBinary                      Procedure(Long _sqlType1Enum)

    Code
        Case _sqlType1Enum
        Of C25_SQL_BINARY
            Return True
        Of C25_SQL_LONGVARBINARY
            Return True
        Of C25_SQL_VARBINARY
            Return True
        End
        Return 0

c25_MsSqlClass.SqlType1IsVariableLength              Procedure(Long _sqlType1Enum)

    Code
        Case _sqlType1Enum
        Of C25_SQL_LONGVARBINARY
            Return True
        Of C25_SQL_LONGVARCHAR
            Return True
        Of C25_SQL_VARBINARY
            Return True
        Of C25_SQL_VARCHAR
            Return True
        Of C25_SQL_WLONGVARCHAR
            Return True
        Of C25_SQL_WVARCHAR
            Return True
        End
        Return 0

c25_MsSqlClass.SQLFetch_Init                         Procedure(<String _sql>, <Long _batchSize>, <Byte _countFirst>,<String _countSql>, <*queue _q>,<*queue _claQMetaFields>,<*queue _msSqlQMetaFields>)

SQLRETURN       Long
SQL             String(16000)
SQLRef          &String

    Code


        Self.StmtHandle = Self.AllocHandle(,True)
        If Self.StmtHandle = 0
            Message('Self.StmtHandle = 0')
            Return 0
        End

        SQL = _sql



        Self.SQLRETURN = C25_SQLSetStmtAttrW(Self.StmtHandle, C25_SQL_ATTR_CURSOR_TYPE , C25_SQL_CURSOR_KEYSET_DRIVEN,0)
        Self.SQLRETURN = C25_SQLSetStmtAttrW(Self.StmtHandle, C25_SQL_ATTR_CONCURRENCY, C25_SQL_CONCUR_VALUES , 0)

        Self.SQLRowCount = 0
        Self.RowsFetched = 0

        If omitted(_sql) = False
            SQLRef &= Self.BitConverter.AnsiToUtf16(Clip(SQL) & Chr(0) ,,true)
        ELSE
            SQLRef &= Self.BitConverter.AnsiToUtf16(Clip(Self.StSql.GetValue()) & Chr(0) ,,true)
        End

        Self.SQLRETURN = C25_SQLExecDirectW(Self.StmtHandle, Address(SQLRef), C25_SQL_NTS)
        If Self.SQLRETURN <> 0 And Self.SQLRETURN <> 1 And Self.SQLRETURN <> 100
            Message('Error C25_SQLExecDirectW :' & Self.SQLRETURN)
            Return 0
        End
        Self.SQLRETURN = C25_SQLFetchScroll(Self.StmtHandle, C25_SQL_FETCH_FIRST, 0)
        If Self.SQLRETURN <> 0 And Self.SQLRETURN <> 1 And Self.SQLRETURN <> 100
            Message('Error C25_SQLFetchScroll :' & Self.SQLRETURN)
            Self.SQLGetDiagRec_STMT()
            Return 0
        End
        Self.SQLRETURN = C25_SQLRowCount(Self.StmtHandle,Address(Self.SQLRowCount))


        Return 0

c25_MsSqlClass.SQLFetch_Page                         Procedure(<Long _fromRowId>, <Long _untilRowId>)

SQLRETURN               Long
Sql                     &String
SqlIntVal               Long
StrLen_or_IndPtr        Long
ValBuffer                                               String(65000)

SomeLongValue                                         Long

    Code

        Self.StSql.Start()
        Self.StSql.SetValue(Self.StSqlBase.GetValue())

        Self.StSql.Replace('*fromRowId*',_fromRowId)
        Self.StSql.Replace('*untilRowId*',_untilRowId)

        Sql &= Self.BitConverter.AnsiToUtf16('select top 1 SomeInt from ATestTable' & Chr(0))

        Self.RowsFetched = 0

        Self.SQLRETURN = C25_SQLExecDirectW(Self.StmtHandle, Address(Sql), C25_SQL_NTS)
        If Self.SQLRETURN <> 0 And Self.SQLRETURN <> 1 And Self.SQLRETURN <> 100
            Message('Error C25_SQLExecDirectW')
            Return 0
        End

        Self.SQLRETURN = C25_SQLFetch(Self.StmtHandle)

        Self.GetData_ColOrdinal                             = 1
        Self.GetData_BufferLength[Self.GetData_ColOrdinal]  = 4

        SomeLongValue = 0

        Self.SQLRETURN = C25_SQLGetData(Self.StmtHandle, Self.GetData_ColOrdinal, C25_SQL_INTEGER, Address(SomeLongValue), 0,  Self.StrLen_or_IndPtr)


        Self.SQLGetDiagRec_STMT()

        Return 0

c25_MsSqlClass.ExecDirect                            Procedure(String _sql)

    Code
        Return 0

c25_MsSqlClass.Disconnect                            Procedure(<Long _connHandle>)

    Code
        If omitted(_connHandle) = False
            If _connHandle <> 0
                Self.SQLRETURN = C25_SqlDisconnect(_connHandle)
            End
        Else
            If Self.ConnHandle <> 0
                Self.SQLRETURN = C25_SqlDisconnect(Self.ConnHandle)
            End
        End
        Return 0

c25_MsSqlClass.SQLExecute                            Procedure(<String _sql>, <Byte _dontReplaceGoToSemicolon>)

    Code
        If omitted(_sql) = True
            If Self.StmtHandle <> 0

                Self.SQLRETURN = C25_SQLSetStmtAttrW(Self.StmtHandle, C25_SQL_ATTR_CURSOR_TYPE , C25_SQL_CURSOR_KEYSET_DRIVEN,0)
                Self.SQLRETURN = C25_SQLSetStmtAttrW(Self.StmtHandle, C25_SQL_ATTR_CONCURRENCY, C25_SQL_CONCUR_VALUES , 0)

                Self.SQLRETURN = C25_SQLExecute(Self.StmtHandle)
                If Self.SQLRETURN = C25_SQL_SUCCESS OR Self.SQLRETURN = C25_SQL_SUCCESS_WITH_INFO
                ELSE
                End
            End
        End

        Return 0

c25_MsSqlClass.IsLastPreparedString                  Procedure(*String _sql)

    Code
        If not Self.LastSqlPrepareString &= null
            If Len(Clip(Self.LastSqlPrepareString)) = Len(Clip(_sql))
                If Self.LastSqlPrepareString = Clip(_sql)
                    Return True
                End
                Self.LastSqlPrepareString = Clip(_sql)
                Return 0
            End
        End

        If not Self.LastSqlPrepareString &= null
            Dispose(Self.LastSqlPrepareString)
        End

        If Len(Clip(_sql)) > 0
            Self.LastSqlPrepareString &= NEW String(Len(Clip(_sql)))
            Self.LastSqlPrepareString = Clip(_sql)
        End
        Return False

c25_MsSqlClass.SQLExecuteScript                      Procedure(<String _sql>,<String _filePathAndName>)

Sql     &String
P       Long
R       Long
G       Long
Result  Long

    Code
        If omitted(_sql) = False
            Self.st1.Start()
            Self.st1.Append(_sql)
            Self.st1.Replace('GO' & Chr(13) & Chr(10),'GO' & Chr(13) & Chr(10),,,,True)
            Self.st1.Split('GO' & Chr(13) & Chr(10))
            R = Records(Self.st1.lines)
            Loop R TIMES
                G = G + 1
                Get(Self.st1.lines,G)
                Self.st2.Start()
                Self.st2.Append(Self.st1.lines.line)
                Self.st2.Replace('GO' & Chr(13) & Chr(10),'' & Chr(13) & Chr(10))

                Self.ExecuteScriptQ.ScriptAnsi &= Self.BitConverter.AnsiToAnsi(Self.st2.GetValue())
                Self.ExecuteScriptQ.ScriptUtf16 &= Self.BitConverter.AnsiToUtf16(Self.st2.GetValue())
                Add(Self.ExecuteScriptQ)
            End
        End

        G = 0
        R = Records(Self.ExecuteScriptQ)

        Loop R TIMES
            G = G + 1
            Get(Self.ExecuteScriptQ,G)
            Result = Self.Prepare(Self.ExecuteScriptQ.ScriptUtf16, st:EncodeUtf16)
            If Result = 0
                Cycle
            End
            Result = Self.SQLExecute()
        End

        G = 0
        R = Records(Self.ExecuteScriptQ)
        Loop R TIMES
            G = G + 1
            Get(Self.ExecuteScriptQ,G)
            Dispose(Self.ExecuteScriptQ.ScriptAnsi)
            Dispose(Self.ExecuteScriptQ.ScriptUtf16)
        End
        Free(Self.ExecuteScriptQ)

        Return 0

c25_MsSqlClass.Prepare                               Procedure(<String _sql>,<Long _encoding>,<Byte _skipIfLastIsEqual>)

    Code
        If Self.StmtHandle <> 0
            C25_SQLFreeHandle(C25_SQL_HANDLE_STMT,Self.StmtHandle)
            Self.StmtHandle = 0
        End
        If Self.StmtHandle = 0
            Self.AllocHandle()
        End
        If Self.StmtHandle = 0
            Return 0
        End
        If omitted(_sql) = False
            If len(Clip(_sql)) < 1
                Return 0
            End
            If not Self.SqlUTf16 &= null
                Dispose(Self.SqlUTf16)
            End
            If OMITTED(_encoding)
                Self.st1.Start()
                Self.st1.Append(_sql)
                Self.st1.Append(Chr(0))
                Self.SqlUTf16 &= Self.BitConverter.AnsiToUtf16(Self.st1.GetValue())
            ELSE
                Case _encoding
                Of st:EncodeUtf16
                    Self.st1.Start()
                    Self.st1.Append(_sql)
                    Self.st1.Append(Chr(0) & Chr(0))
                    Self.SqlUTf16 &= Self.BitConverter.BinaryCopy(Self.st1.GetValue())
                End
            End
        End

        Self.SQLPrepareOK = False

        Self.SQLRETURN = C25_SQLPrepareW(Self.StmtHandle, Address(Self.SqlUTf16), C25_SQL_NTS)
        If Self.SQLRETURN = C25_SQL_SUCCESS
            Self.SQLPrepareOK = True
            Return Self.StmtHandle
        ELSE

        End
        Return 0

c25_MsSqlClass.SQLGetDiagRec                         Procedure(Long _connHandle)

RecNumber           Long
SQLState            CSTRING(14)
NativeErrorPtr      Long
BufferLength        Long
TextLengthPtr       Long
TextBuffer          String(65000)

    Code

        RecNumber = -1
        Loop 1 Times
            RecNumber = RecNumber + 1
            Clear(NativeErrorPtr)
            BufferLength = 65000
            TextLengthPtr = 0

            Clear(Self.DiagMessageTextW)

            Self.SQLRETURN = C25_SQLGetDiagRecW(C25_SQL_HANDLE_DBC, _connHandle, RecNumber,  Address(SQLState),Address(NativeErrorPtr),Address(Self.DiagMessageTextW),Size(Self.DiagMessageTextW)/2,Address(TextLengthPtr))
            Message('TextLengthPtr ' & TextLengthPtr)
            If TextLengthPtr > 0 And TextLengthPtr < 30000
                Self.DiagMessageTextA &= Self.BitConverter.Utf16ToAnsi(Self.DiagMessageTextW[1 : TextLengthPtr*2])
                Message(Self.DiagMessageTextA)
            ELSE
            End

            BREAK
        End

        Return ''

c25_MsSqlClass.SQLGetDiagRec_STMT                    Procedure()

RecNumber           Long
SQLState            CSTRING(14)
NativeErrorPtr      Long
BufferLength        Long
TextLengthPtr       Long
TextBuffer           String(65000)

    Code

        RecNumber = -1
        Loop 1 Times
            RecNumber = RecNumber + 1
            Clear(NativeErrorPtr)
            BufferLength = 65000
            TextLengthPtr = 0

            Clear(Self.DiagMessageTextW)

            Self.SQLRETURN = C25_SQLGetDiagRecW(C25_SQL_HANDLE_STMT, Self.StmtHandle, RecNumber,  Address(SQLState),Address(NativeErrorPtr),Address(Self.DiagMessageTextW),Size(Self.DiagMessageTextW)/2,Address(TextLengthPtr))

            If TextLengthPtr > 0 And TextLengthPtr < 30000
                Self.DiagMessageTextA &= Self.BitConverter.Utf16ToAnsi(Self.DiagMessageTextW[1 : TextLengthPtr*2])
                Message(Self.DiagMessageTextA)
            ELSE
            End

            Case Self.SQLRETURN
            Of C25_SQL_SUCCESS
            OrOf C25_SQL_SUCCESS_WITH_INFO
                If BufferLength > 0
                    Self.BitConverter.st1.SetValueByAddress(Address(Self.DiagMessageTextW),BufferLength)
                End
            Of C25_SQL_INVALID_HANDLE
                BREAK
            Of C25_SQL_ERROR
                BREAK
            Of C25_SQL_NO_DATA
                BREAK
            End
        End

        Return ''

c25_MsSqlClass.AllocHandle                           Procedure(<Long _connHandle>, <Byte _renewIfExist>)

StmtHandleTemp                  Long
ConnHandle                      Long

    Code
        If Omitted(_connHandle) = True
            ConnHandle = Self.ConnHandle
        Else
            ConnHandle = _connHandle
        End

        If omitted(_renewIfExist) = True
            If Self.StmtHandle <> 0
                C25_SQLFreeHandle(C25_SQL_HANDLE_STMT,Self.StmtHandle)
            End
        End

        Self.SQLRETURN  = C25_SQLAllocHandle(C25_SQL_HANDLE_STMT,ConnHandle,ADDRESS(Self.StmtHandleTemp))
        If Self.SQLRETURN <> C25_SQL_SUCCESS And Self.SQLRETURN <> C25_SQL_SUCCESS_WITH_INFO
            Message('error in c25_MsSqlClass.AllocHandle')
        Else
            Self.StmtHandle = Self.StmtHandleTemp
            Return Self.StmtHandle
        End

        Return 0


