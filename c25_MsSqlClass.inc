    Include('c25_ProgramHandlerClass.inc'),Once

c25_MsSqlClass                                                          Class(),type, Module('c25_MsSqlClass.clw'), Link('c25_MsSqlClass.clw',1),DLL(0)

Construct                                                                   Procedure()
Destruct                                                                    Procedure(),virtual

AnsiBlockPtr                                                                Long
AnsiBlockSize                                                               Long
AssignedNullArray                                                           Long,dim(256)
AssignNull                                                                  Long
BcpBoundEmptyString                                                         cstring(2),dim(256)
BcpBoundEmptyStringPtr                                                      Long,dim(256)
BitValue                                                                    Byte
BitValuePtr                                                                 Long
BookMarkSize                                                                Long
BulkBufferHeapAlloc                                                         Long
BulkBufferHeapAllocOffset                                                   Long
BulkBufferSize                                                              Long
BulkGroupDataCount                                                          Long
BulkRecordsCount                                                            Long
BulkRowSize                                                                 Long
ByteValue                                                                   Byte
ByteValuePtr                                                                Long
CharacterAttribute                                                          String(65000)
CharacterAttributePtr                                                       Long
CharBuffer2MB                                                               String(2000000)
CharBuffer2MBPtr                                                            Long
ClaDecStoredLen                                                             Long
ClarionFieldsIndex                                                          Long
ClarionFieldsMaxIndex                                                       Long
ConnectionFailed                                                            Byte
ConnectionIsOpen                                                            Byte
ConnectionString                                                            String(1024)
ConnectionStringAnsi                                                        String(1024)
ConnHandle                                                                  Long
CRLF                                                                        Short
DateTime23String                                                            String(23)
DateTime23StringPtr                                                         Long
DateTime27String                                                            String(27)
DateTime27StringPtr                                                         Long
DebugLog                                                                    Byte
Dec20                                                                       Decimal(20,0)
Dec20Cla                                                                    Decimal(20,0)
DecClaCharacters                                                            Long,dim(256)
DecClaPlaces                                                                Long,dim(256)
DecimalInString                                                             String(64)
DecimalInStringPtr                                                          Long
DecimalString                                                               String(54)
DecimalStringReturn                                                         String(54)
DecPrecision                                                                Long,dim(256)
DecScale                                                                    Long,dim(256)
Describe_BufferLength                                                       Long
Describe_ColumnName                                                         cstring(1024)
Describe_ColumnNamePtr                                                      Long
Describe_ColumnNameSize                                                     Long
Describe_ColumnSize                                                         Long
Describe_ColumnSizePtr                                                      Long
Describe_DataType                                                           Long
Describe_DataTypePtr                                                        Long
Describe_DecimalDigits                                                      Long
Describe_DecimalDigitsPtr                                                   Long
Describe_NameLength                                                         Long
Describe_NameLengthPtr                                                      Long
Describe_Nullable                                                           Long
Describe_NullablePtr                                                        Long
DiagMessageTextW                                                            String(65000)
EF_Address                                                                  Long
EF_CurrentFieldAny                                                          ANY
EnumQueueFrom                                                               Long
EnumQueueIndex                                                              Long
EnumQueueUntil                                                              Long
EnumQueueUpdateStats                                                        BOOL
EnvHandle                                                                   Long
GetData_BufferLength                                                        Long,dim(256)
GetData_BufferLengthPtr                                                     Long,dim(256)
GetData_ColOrdinal                                                          Long
Ind4AndVal_CurrentMemLength_Array                                           Long,dim(256)
Ind4AndVal_OCTEDLENGTH_Array                                                Long,dim(256)
Ind4AndVal_Ptr_Array                                                        Long,dim(256)
Ind4AndVal_ValuePtr_Array                                                   Long,dim(256)
Indicator4                                                                  Long
Indicator4_Array                                                            Long,dim(256)
Indicator4_Ptr_Array                                                        Long,dim(256)
Indicator4Ptr                                                               Long
IndicatorShort                                                              Short
Int32MaxValue                                                               decimal(20)
Int32MinValue                                                               decimal(20)
Int64MaxValue                                                               decimal(20)
Int64MinValue                                                               decimal(20)
Int64Val                                                                    Like(INT64)
Int64Value                                                                  LIKE(INT64)
Int64ValuePtr                                                               Long
IntValue                                                                    Long
IntValuePtr                                                                 Long
IsNull                                                                      Byte
LongValue                                                                   Long
LongValuePtr                                                                Long
MemAllocFullLen                                                             Long,dim(256)
MemAllocFullLenPtr                                                          Long,dim(256)
MemAllocHandle                                                              Long,dim(256)
MemAllocHandlePtr                                                           Long,dim(256)
MemAllocValueLen                                                            Long,dim(256)
MemAllocValueLenPtr                                                         Long,dim(256)
MemAllocValuePtr                                                            Long,dim(256)
MemFixedLen                                                                 Long,dim(256)
MemFixedLenPtr                                                              Long,dim(256)
MemIndicatorLen                                                             Long,dim(256)
MemIndicatorLenPtr                                                          Long,dim(256)
MemIndicatorValue                                                           Long,dim(256)
MemIndicatorValuePtr                                                        Long,dim(256)
MemIsFixedLen                                                               bool,dim(256)
MemIsFixedLenPtr                                                            bool,dim(256)
MemNullable                                                                 bool,dim(256)
MemNullablePtr                                                              bool,dim(256)
MemValueLen                                                                 Long,dim(256)
MemValueLenPtr                                                              Long,dim(256)
MsSqlMetaArrayIndex                                                         Long
MsSqlMetaArrayMaxIndex                                                      Long
MsSqlMetaAutoIdColumnIndex                                                  Long
NumericAttribute                                                            Long
NumericAttributePtr                                                         Long
OctedLen                                                                    Long,dim(256)
OctedLenPtr                                                                 Long,dim(256)
ODBC_ConnAttrAutoCommit                                                     Long
ODBC_ConnAttrloginTimeout                                                   Long
ODBC_ConnAttrTimeout                                                        Long
ODBC_SqlAccessMode                                                          Long
ODBCConnPacketSize                                                          Long
ODBCEnvAttr_ApplicationKey                                                  Long
ODBCEnvAttr_ConnectionPooling                                               Long
ODBCEnvAttr_ConnectType                                                     Long
ODBCEnvAttr_CPMatch                                                         Long
ODBCEnvAttr_MaxConnections                                                  Long
ODBCEnvAttr_MinMemUsage                                                     Long
ODBCEnvAttr_OdbcVersion                                                     Long
ODBCEnvAttr_OutputNts                                                       Long
ODBCRETURN                                                                  Long
OffsetPtr                                                                   Long
OffsetValue                                                                 Long
P                                                                           Long
PaddingBytesCount                                                           Long
ProcessHeapHandle                                                           Long
QueueRowPtr                                                                 Long
RETCODE                                                                     Short
RowsFetched                                                                 Long
RowStatus                                                                   Long
RowStatusPtr                                                                Long
S                                                                           Long
SelfAddress                                                                 Long
SetTestValues                                                               bool
ShortValue                                                                  Short
ShortValuePtr                                                               Long
SmallIntValue                                                               Short
SmallIntValuePtr                                                            Short
SomeLong                                                                    Long
SQLColumnsCount                                                             Long
SQLGetDataReturnLength                                                      Long
SQLGetDataReturnLengthPtr                                                   Long
SQLGetDiagRec_SQLRETURN                                                     Long
SQLGetDiagRec_SQLState                                                      String(128)
SQLGetDiagRec_TextLength                                                    Long
SQLNumResultCols                                                            Long
SQLPrepareOK                                                                Long
SQLRETURN                                                                   Long
SQLRowCount                                                                 Long
SqlUtf16Length                                                              Long
StBufferRequiredLength                                                      Long
StillZero                                                                   Byte
StmtHandle                                                                  Long
StmtHandleTemp                                                              Long
Str11OverDec20Ptr                                                           Long
Str8                                                                        String(8)
StringLength                                                                Long
StringLengthPtr                                                             Long
StrLen_or_Ind                                                               Long
StrLen_or_IndPtr                                                            Long
T                                                                           Long
TargetLong                                                                  Long
TargetStr4OverLongPtr                                                       Long
TinyIntValue                                                                Byte
TinyIntValuePtr                                                             Long
UInt32MaxValue                                                              decimal(20)
UInt32MinValue                                                              decimal(20)
UInt64MaxValue                                                              decimal(20)
UInt64MinValue                                                              decimal(20)
UInt64Value                                                                 LIKE(UINT64)
UInt64ValuePtr                                                              Long
ULongValue                                                                  ULong
UShortValue                                                                 UShort
Utf16SpacesBlockPtr                                                         Long
Utf16SpacesBlockSize                                                        Long
Utf16SpacesBufferPtr                                                        Long
UTinyIntValue                                                               Byte
UTinyIntValuePtr                                                            Long
Val_OCTEDLENGTH_Array                                                       Long,dim(256)
Val_Ptr_Array                                                               Long,dim(256)
Val_ValueLength_Array                                                       Long,dim(256)
ZeroBlockPtr                                                                Long
ZeroBlockSize                                                               Long

BitConverter                                                                &c25_BitConverterClass
NanoSync                                                                    &c25_NanoSyncClass
ProgramHandler                                                              &c25_ProgramHandlerClass
WinApi                                                                      &c25_WinApiClass
DataReflection                                                              &c25_DataReflectionClass

BCPFormatFileCols                                                           &BCPFormatFileCols_TYPE
BulkErrorFileA                                                              &String
BulkErrorFileW                                                              &String
BulkFormatFileA                                                             &String
BulkFormatFileW                                                             &String
BulkHostFileA                                                               &String
BulkHostFileW                                                               &String
BulkSqlSelectA                                                              &String
BulkSqlSelectW                                                              &String
BulkTableNameA                                                              &String
BulkTableNameW                                                              &String
BytesHandler                                                                &BytesHandlerClass
ClarionFields                                                               &ClarionFields_TYPE
ClarionFieldsTEMP                                                           &ClarionFields_TYPE
ConnectionStringUtf16                                                       &String
DiagMessageTextA                                                            &String
EF_ptrString                                                                &String
ExecuteScriptQ                                                              &ExecuteScript_TYPE
InterStringRef                                                              &String
Js1                                                                         &JSONClass
LastSqlPrepareString                                                        &String
Logger                                                                      &LoggerClass
MaxQueue                                                                    &MaxQueueClass
MsSqlMeta                                                                   &MsSqlInformationSchema_TYPE
Reflect                                                                     &ReflectClass
SQLGetDiagRec_MessageText                                                   &String
SQLGetDiagRec_NativeError                                                   &String
SqlAnsi                                                                     &String
SqlUTf16                                                                    &String
St1                                                                         &StringTheory
St2                                                                         &StringTheory
StBuffer                                                                    &StringTheory
StSql                                                                       &StringTheory
StSqlBase                                                                   &StringTheory
TrueReflection                                                              &TrueReflectionClass
Utf16SpacesBuffer                                                           &String
AllocHandle                                                                 Procedure(<Long _connHandle>, <Byte _renewIfExist>),Long,proc
AnsiToUtf16                                                                 Procedure(Long _c,String _ansi, Long _lenAnsi, Long _utf16Ptr, Long _maxUtf16Len)
AnsiToUtf16_ByRef                                                           Procedure(Long _c,*String _ansi, Long _lenAnsi, Long _utf16Ptr, Long _maxUtf16Len)
BcpBulkImport_ImporBulkFile                                                 Procedure(String _formatFileA, String _hostFileA, <*queue _inputClaQ>),String,proc
BcpBulkImport_Init                                                          Procedure(String _tableNameA, Long _batchSize, <*queue _inputClaQ>),String,proc
BcpBulkSave_Init                                                            Procedure(String _tableNameA, Long _batchSize, <*queue _inputClaQ>),String,proc
BcpBulkSave_SendRows                                                        Procedure(*queue _inputClaQ, <*Long _from>, <*Long _until>, <*Long _currentPointer>, <*real _currentPerc>),String,proc
BinaryCopy                                                                  Procedure(Long _c, String _utf16Source, Long _lenUtf16Source, Long _utf16Ptr, Long _maxUtf16Len)
Bind_Binary                                                                 Procedure(Long _columnOrdinal, Byte _allowNulls, Long _octetLength)
Bind_Character                                                              Procedure(Long _columnOrdinal, Byte _allowNulls, Long _octetLength)
Bind_Create                                                                 Procedure(Long _columnOrdinal, bool _allowNulls, Long _indicatorLen, Long _indicatorValue, Long _MemAllocValueLen, Long _octedLen, Long _bindOptions)
Bind_DateTime23                                                             Procedure(Long _columnOrdinal, Byte _allowNulls, Long _octetLength)
Bind_DateTime27                                                             Procedure(Long _columnOrdinal, Byte _allowNulls, Long _octetLength)
Bind_Decimal                                                                Procedure(Long _columnOrdinal, Byte _allowNulls, Long _octetLength, <Long _precision>, <Long _scale>, <Long _claCharacters>, <Long _claPlaces>)
Bind_DisposeColumnArrays                                                    Procedure(Long _columnOrdinal)
Bind_Int                                                                    Procedure(Long _columnOrdinal, Byte _allowNulls, Byte _integerWidth)
Bind_LongNVarCharacter                                                      Procedure(Long _columnOrdinal, Byte _allowNulls, Long _octetLength, <Long _setLength>)
Bind_LongVarBinary                                                          Procedure(Long _columnOrdinal, Byte _allowNulls, Long _octetLength, <Long _setLength>)
Bind_LongVarCharacter                                                       Procedure(Long _columnOrdinal, Byte _allowNulls, Long _octetLength, <Long _setLength>)
Bind_NCharacter                                                             Procedure(Long _columnOrdinal, Byte _allowNulls, Long _octetLength)
Bind_NULL                                                                   Procedure(Long _columnOrdinal)
Bind_NVarCharacter                                                          Procedure(Long _columnOrdinal, Byte _allowNulls, Long _octetLength, <Long _setLength>)
Bind_VarBinary                                                              Procedure(Long _columnOrdinal, Byte _allowNulls, Long _octetLength, <Long _setLength>)
Bind_VarCharacter                                                           Procedure(Long _columnOrdinal, Byte _allowNulls, Long _octetLength, <Long _setLength>)
ClaDecToDecimal                                                             Procedure(String _claDecStored,Long _places),String
ClearAnsiBlock                                                              Procedure(Long _targetPtr, Long _size)
ClearUtf16Block                                                             Procedure(Long _targetPtr, Long _size)
Connect                                                                     Procedure(<String _connString>,<Byte _disconnectFirst>,<Long _driver>, <Byte _forBCP>),Long,proc
ConvertBCPToQ                                                               Procedure(*QUEUE _claQueue, <*String _bcpImport>, <String _fromTable>, <String _formatFileNameUtf8>, <String _bulkFileNameUtf8>),String,proc
ConvertQToBCP                                                               Procedure(*QUEUE _claQueue, <*String _bcpOut>, <String _targetTable>, <String _formatFileNameUtf8>, <String _bulkFileNameUtf8>),String,proc
Disconnect                                                                  Procedure(<Long _connHandle>),Long,proc
ExecDirect                                                                  Procedure(String _sql),String,proc
ExecuteScalarHandler                                                        Procedure(String _sql, long _claDataTypeEnum, long _maxSize, <*string _resultString>, <*long _resultInt>, <*bool _isNull>, <*bool _notFound>, <*bool _error>),string,proc
ExecuteScalarReturnInt                                                      Procedure(String _sql, <long _claDataTypeEnum>, <long _maxSize>, <*bool IsNull>, <*bool _notFound>, <*bool _isError>),long,proc
ExecuteScalarReturnRef                                                      Procedure(String _sql, <long _claDataTypeEnum>, <long _maxSize>, <*bool IsNull>, <*bool _notFound>, <*bool _isError>),*string,proc
ExecuteScalarReturnString                                                   Procedure(String _sql, <long _claDataTypeEnum>, <long _maxSize>, <*bool IsNull>, <*bool _notFound>, <*bool _isError>),string,proc
GetClaDataReflectionAnalyze                                                 Procedure(*queue _qRows),Long,proc
GetClearedAnsiBlockPtr                                                      Procedure(Long _size),Long
GetCreateBCPFormatFile                                                      Procedure(String _tableNameA, <String _fields>, <*QUEUE _claQueue>, <String _queueType>),String,proc
GetMappedClaQMetaField                                                      Procedure(MsSqlInformationSchema_TYPE _msSqlInformationSchema),Long
GetMetaColumns                                                              Procedure(String _sql, <*queue _clarionQ>),String,proc
GetMsSqlInformationSchema                                                   Procedure(String _sqlMeta),Long,proc
GetUtf16SpacesBlockPtr                                                      Procedure(Long _size),Long
GetZeroBlockPtr                                                             Procedure(Long _size),Long,proc
IsLastPreparedString                                                        Procedure(*String _sql),Byte
Prepare                                                                     Procedure(<String _sql>,<Long _encoding>,<Byte _skipIfLastIsEqual>),Long,proc
SQLColAttribute                                                             Procedure(Long _columnOrdinal, Long _descType),String
SQLColAttributeReturnType                                                   Procedure(Long _descType),Long
SQLExecute                                                                  Procedure(<String _sql>, <Byte _dontReplaceGoToSemicolon>),Long,proc
SQLExecuteScript                                                            Procedure(<String _sql>,<String _filePathAndName>),String,proc
SQLFetch_Init                                                               Procedure(<String _sql>, <Long _batchSize>,<Byte _countFirst>,<String _countSql>, <*queue _q>,<*queue _claQMetaFields>,<*queue _msSqlMetaFields>),String,proc
SQLFetch_InitGetMeta                                                        Procedure(String _metaSql,<*queue _qRows>, <Mssqlinformationschema_TYPE _msSqlMetaQ>, <ClarionFields_TYPE _clarionFields>),String,proc
SQLFetch_Page                                                               Procedure(<Long _fromRowId>, <Long _untilRowId>),String,proc
SQLFetch_Rows                                                               Procedure(String _sql, <*queue _qRows>),String,proc
SQLGetData_SQL_BIGINT                                                       Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>),String,proc
SQLGetData_SQL_BINARY                                                       Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>),String,proc
SQLGetData_SQL_BIT                                                          Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>, <Byte _bandSourceLen>, <Byte _bandBitPos>),String,proc
SQLGetData_SQL_CHAR                                                         Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>),String,proc
SQLGetData_SQL_DATETIME                                                     Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>),String,proc
SQLGetData_SQL_DECIMAL                                                      Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _precision>, <Long _places>, <String _formatPicture>, <Long _trailingZero>),String,proc
SQLGetData_SQL_DOUBLE                                                       Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _precision>, <Long _places>, <String _formatPicture>, <Long _trailingZero>),String,proc
SQLGetData_SQL_FLOAT                                                        Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _precision>, <Long _places>, <String _formatPicture>, <Long _trailingZero>),String,proc
SQLGetData_SQL_GUID                                                         Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>),String,proc
SQLGetData_SQL_INTEGER                                                      Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>),String,proc
SQLGetData_SQL_INTERVAL                                                     Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>),String,proc
SQLGetData_SQL_INTERVAL_DAY_TO_HOUR                                         Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>),String,proc
SQLGetData_SQL_INTERVAL_DAY_TO_MINUTE                                       Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>),String,proc
SQLGetData_SQL_INTERVAL_DAY_TO_SECOND                                       Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>),String,proc
SQLGetData_SQL_INTERVAL_HOUR                                                Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>),String,proc
SQLGetData_SQL_INTERVAL_HOUR_TO_MINUTE                                      Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>),String,proc
SQLGetData_SQL_INTERVAL_HOUR_TO_SECOND                                      Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>),String,proc
SQLGetData_SQL_INTERVAL_MINUTE                                              Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>),String,proc
SQLGetData_SQL_INTERVAL_MINUTE_TO_SECOND                                    Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>),String,proc
SQLGetData_SQL_INTERVAL_YEAR                                                Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>),String,proc
SQLGetData_SQL_INTERVAL_YEAR_TO_MONTH                                       Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>),String,proc
SQLGetData_SQL_LONGVARBINARY                                                Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>),String,proc
SQLGetData_SQL_LONGVARCHAR                                                  Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>),String,proc
SQLGetData_SQL_NUMERIC                                                      Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>),String,proc
SQLGetData_SQL_REAL                                                         Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>),String,proc
SQLGetData_SQL_SMALLINT                                                     Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>),String,proc
SQLGetData_SQL_TIMESTAMP                                                    Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>),String,proc
SQLGetData_SQL_TINYINT                                                      Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>),String,proc
SQLGetData_SQL_TYPE_DATE                                                    Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>),String,proc
SQLGetData_SQL_TYPE_TIME                                                    Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>),String,proc
SQLGetData_SQL_TYPE_TIMESTAMP                                               Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>),String,proc
SQLGetData_SQL_TYPE_UTCDATETIME                                             Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>),String,proc
SQLGetData_SQL_TYPE_UTCTIME                                                 Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>),String,proc
SQLGetData_SQL_VARBINARY                                                    Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>),String,proc
SQLGetData_SQL_VARCHAR                                                      Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>),String,proc
SQLGetData_SQL_WCHAR                                                        Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>),String,proc
SQLGetData_SQL_WLONGVARCHAR                                                 Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>),String,proc
SQLGetData_SQL_WVARCHAR                                                     Procedure(<Byte _returnData>, Long _columnOrdinal, <Long _targetPtr>, <*Byte _isNull>,<String _returnValueIfNull>, <Long _maxTargetBytesLen>, <Long _clarionTargetType>, <Long _convertFunction>, <Long _trailingZero>),String,proc
SQLGetDiagRec                                                               Procedure(Long _connHandle),String,proc
SQLGetDiagRec_STMT                                                          Procedure(),String,proc
SetValue_BigInt_ByClaDecimal                                                Procedure(Long _columnOrdinal, String _value)
SetValue_BigInt_ByInt64                                                     Procedure(Long _columnOrdinal, String _value)
SetValue_BigInt_ByNumeric                                                   Procedure(Long _columnOrdinal, String _formattedDecValue)
SetValue_Binary                                                             Procedure(Long _columnOrdinal, String _characterValue, Long _size)
SetValue_Binary_ByRef                                                       Procedure(Long _columnOrdinal, String _characterValueRef)
SetValue_Bit_ByString                                                       Procedure(Long _columnOrdinal, String _bit)
SetValue_Character                                                          Procedure(Long _columnOrdinal, String _characterValue, Long _size)
SetValue_Character_ByRef                                                    Procedure(Long _columnOrdinal, String _characterValueRef)
SetValue_DateTime23                                                         Procedure(Long _columnOrdinal, String _characterValue, Long _size)
SetValue_DateTime27                                                         Procedure(Long _columnOrdinal, String _characterValue, Long _size)
SetValue_Decimal                                                            Procedure(Long _columnOrdinal, String _clarionDecValue, Long _size)
SetValue_Indicator                                                          Procedure(Long _columnOrdinal, Long _indicator)
SetValue_Int1                                                               Procedure(Long _columnOrdinal, Long _value)
SetValue_Int1_ByString                                                      Procedure(Long _columnOrdinal, String _value)
SetValue_Int2                                                               Procedure(Long _columnOrdinal, Long _value)
SetValue_Int2_ByString                                                      Procedure(Long _columnOrdinal, String _value)
SetValue_Int4                                                               Procedure(Long _columnOrdinal, Long _value)
SetValue_Int4_ByString                                                      Procedure(Long _columnOrdinal, String _value)
SetValue_LongNVarCharacter                                                  Procedure(Long _columnOrdinal, String _characterValue, Long _size)
SetValue_LongNVarCharacter_ByRef                                            Procedure(Long _columnOrdinal, String _characterValueRef)
SetValue_LongVarBinary                                                      Procedure(Long _columnOrdinal, String _binaryValue, Long _size)
SetValue_LongVarBinary_ByRef                                                Procedure(Long _columnOrdinal, String _binaryValueRef)
SetValue_LongVarCharacter                                                   Procedure(Long _columnOrdinal, String _characterValue, Long _size)
SetValue_LongVarCharacter_ByRef                                             Procedure(Long _columnOrdinal, String _characterValueRef)
SetValue_NCharacter                                                         Procedure(Long _columnOrdinal, String _nCharacterValue, Long _size)
SetValue_NCharacter_ByRef                                                   Procedure(Long _columnOrdinal, String _nCharacterValueRef)
SetValue_NVarCharacter                                                      Procedure(Long _columnOrdinal, String _binaryValue, Long _size)
SetValue_NVarCharacter_ByRef                                                Procedure(Long _columnOrdinal, String _binaryValueRef)
SetValue_Null                                                               Procedure(Long _columnOrdinal)
SetValue_VarBinary                                                          Procedure(Long _columnOrdinal, String _characterValue, Long _size)
SetValue_VarBinary_ByRef                                                    Procedure(Long _columnOrdinal, String _characterValueRef)
SetValue_VarCharacter                                                       Procedure(Long _columnOrdinal, String _characterValue, Long _size)
SetValue_VarCharacter_ByRef                                                 Procedure(Long _columnOrdinal, String _characterValue)
Set_NULL                                                                    Procedure(Long _columnOrdinal)
SqlType1IsAnsi                                                              Procedure(Long _SqlType1),Byte
SqlType1IsBinary                                                            Procedure(Long _SqlType1),Byte
SqlType1IsByte                                                              Procedure(Long _SqlType1),Byte
SqlType1IsDecimal                                                           Procedure(Long _SqlType1),Byte
SqlType1IsInt64                                                             Procedure(Long _SqlType1),Byte
SqlType1IsLong                                                              Procedure(Long _SqlType1),Byte
SqlType1IsNumeric                                                           Procedure(Long _SqlType1),Byte
SqlType1IsReal                                                              Procedure(Long _SqlType1),Byte
SqlType1IsShort                                                             Procedure(Long _SqlType1),Byte
SqlType1IsUtf16                                                             Procedure(Long _SqlType1),Byte
SqlType1IsVariableLength                                                    Procedure(Long _SqlType1),Byte
SqlType1ToExecDataEnum                                                      Procedure(Long _sqlType1Enum),Long
SqlType1ToString                                                            Procedure(Long _SqlType1),String
ZeroOutBlock                                                                Procedure(Long _targetPtr, Long _size)





Str11OverDec20                                                              String(11),Over(Dec20)
TargetStr4OverLong                                                          String(4),Over(TargetLong)



MsSqlMetaArray                                                                  Group(MsSqlInformationSchema_TYPE),Pre(MsSqlMetaArray),Dim(256)
                                                                                End
ClarionFieldsArray                                                              Group(ClarionFields_TYPE),Pre(ClarionFieldsArray),Dim(256)
                                                                                End
BcpBoundInt1                                                                    Group,Pre(BcpBoundInt1),Dim(256)
Indicator                                                                           Short
Value                                                                               Byte
                                                                                End
BcpBoundInt2                                                                    Group,Pre(BcpBoundInt2),Dim(256)
Indicator                                                                           Short
Value                                                                               Short
                                                                                End
BcpBoundInt4                                                                    Group,Pre(BcpBoundInt4),Dim(256)
Indicator                                                                           Short
Value                                                                               Long
                                                                                End
BcpBoundInt8                                                                    Group,Pre(BcpBoundInt8),Dim(256)
Indicator                                                                           Short
Value                                                                               String(32)
                                                                                End
BcpBoundVARIndicatorAndValue                                                    Group,Pre(BcpBoundVARIndicatorAndValue),dim(256)
IndAndValue                                                                         &String
                                                                                End
BcpBoundCHAR                                                                    Group,Pre(BcpBoundCHAR),Dim(256)
Value                                                                               &String
                                                                                End
BcpBoundBINARY                                                                  Group,Pre(BcpBoundBINARY),Dim(256)
Value                                                                               &String
                                                                                End
BcpBoundVARBINARY                                                               Group,Pre(BcpBoundVARBINARY),Dim(256)
Value                                                                               &String
                                                                                End

EF_AdrGroup                                                                     Group,pre(EF_AdrGroup)
EF_PtrAddress                                                                       Long
EF_PtrSize                                                                          Long
                                                                                End
Dec20ClaStr11                                                                   String(11),Over(Dec20Cla)
EF_AddressAndSizeFromAny                                                        String(8),over(EF_AdrGroup)
EF_AddressFromAny                                                               String(4),over(EF_Address)
IndicatorShortStrOver                                                           String(2),Over(IndicatorShort)

Decimal31                                                                       Decimal(31,0)
Decimal31_Over                                                                  String(16),Over(Decimal31)

Decimal20                                                                       Decimal(20,0)
Decimal20_Over                                                                  String(11),Over(Decimal20)
                                                                            End


