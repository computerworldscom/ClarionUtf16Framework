    Include('c25_ProgramHandlerClass.inc'),Once
    Include('c25_ExtendedDataTypes.inc'),Once

c25_ObjectClass           	                                            Class(),type,Module('c25_ObjectClass.clw'), Link('c25_ObjectClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
Construct                                                                   Procedure()
Destruct                                                                    Procedure()
 

!ValueStorageType                                                            LONG

!ValueByte                                                                   Byte
!ValueInt16                                                                  short
!ValueUInt16                                                                 ushort
!ValueInt32                                                                  long
!ValueUInt32                                                                 ulong
!ValueDecimal                                                                &string
!ValueNumeric                                                                &string

!SetValueByte                                                                Procedure(byte _byte)
!SetValueInt16                                                               Procedure(short _int16)
!SetValueUInt16                                                              Procedure(ushort _uint16)
!SetValueInt32                                                               Procedure(long _int32),long,proc
!SetValueUInt32                                                              Procedure(ulong _uint32),ulong,proc
!SetValueDecimal                                                             Procedure(string _decimal),string,proc
!
!SetValueFromStringRef                                                       Procedure(string _stringRef),string,proc

!GetValueByte                                                                Procedure(byte _byte)
!GetValueInt16                                                               Procedure(short _int16)
!GetValueUInt16                                                              Procedure(ushort _uint16)
!GetValueInt32                                                               Procedure(long _int32),long,proc
!GetValueUInt32                                                              Procedure(ulong _uint32),ulong,proc
!GetValueDecimal                                                             Procedure(string _decimal),string,proc
!GetValueFromStringRef                                                       Procedure(string _stringRef),string,proc

BufferSize                                                                  UInt32
BytesAllocated                                                              LONG
BytesSize                                                                   LONG
Characters                                                                  LONG
DataTypeEnum                                                                LONG
Dec21                                                                       Decimal(21)
DummyString1                                                                string(1)
EncodingStringValue                                                         Long
EncodingStringValueOut                                                      Long
FieldOrdinal                                                                Long
HeapHandle                                                                  LONG
IsFirstField                                                                BOOL
IsLastField                                                                 BOOL
IsNULL                                                                      BOOL
IsPrivateHeap                                                               bool
IsStringValue                                                               BOOL
NumericTypeEnum                                                             Long
Ordinal                                                                     Long
SourceColumnBytes                                                           Long
SourceTypeEnum                                                              Long
SystemDataTypeEnum                                                          LONG
ValueLong                                                                   Long
ValuePtr                                                                    LONG
ValueSize                                                                   LONG

BitConverterClass                                                           &c25_BitConverterClass
Buffer                                                                      &String
DataLength                                                                  &String
DataType                                                                    &String
MsSqlColumnProperties                                                       &MsSqlColumnProperty_TYPE
Name                                                                        &String
StringValue                                                                 &String
Value                                                                       &String
ValueNumeric                                                                &ValueNumeric_TYPE

DeformatDataLength                                                          Procedure(string _dataLengthString)
Dispose_MsSqlColumnProperties                                               Procedure(),long,PROC
FindInByteArray                                                             Procedure(string _findBytes, long _valuePtr, long _valueSize, <bool _caseInsensitive>),long
GetNumericValue                                                             Procedure(),STRING
GetStringValue                                                              Procedure(<string _returnIfNull>, <*string _stringRef>),STRING
GetStringValueNewRef                                                        Procedure(<string _returnIfNull>),*STRING
GetStringValueRef                                                           Procedure(),*STRING
GetValueFromValuePtr                                                        Procedure(long _ptr, long _size, <bool _deleteAlloc>),string
ParseSqlite3Value                                                           Procedure(long _sqlStatementSelectHandle,long _sourceIndex),Long
Reset                                                                       Procedure()
SetDataType                                                                 Procedure(string _dataType),long,proc
SetDataTypeEnum                                                             Procedure(long _dataTypeEnum),string,proc
SetNumericValue                                                             Procedure(string _numericSource)
SetStringValue                                                              Procedure(string _source, <long _encodingSource>, <long _encodingReturn>, <bool _setNull>)
SetValue                                                                    Procedure(long _ptr, long _size),long,proc
SetValue                                                                    Procedure(string _value, <long _size>),long,proc
StringTheoryToMemAllocPtr                                                   Procedure(*StringTheory _st, <bool _freeValue>),string



                                                                        End


