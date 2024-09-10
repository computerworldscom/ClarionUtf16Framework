    Include('c25_ProgramHandlerClass.inc'),Once
    Include('c25_ExtendedDataTypes.inc'),Once

c25_ValueObjectClass           	                                            Class(),type,Module('c25_ValueObjectClass.clw'), Link('c25_ValueObjectClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
Construct                                                                       Procedure()
Destruct                                                                        Procedure()
 
BitConverterClass                                                               &c25_BitConverterClass
Init                                                                            Procedure(<*c25_BitConverterClass _bitConverterClass>)

ValueTypeEnum                                                                   LONG
ValueTypeName                                                                   &String
Flags                                                                           LONG
ValueSize                                                                       LONG
ValueSize64                                                                     Like(UINT64)

ValueFixedByte                                                                  Byte


ValueFixedInt16                                                                 SHORT
ValueFixedInt16Over                                                             string(2),over(ValueFixedInt16)

ValueFixedUInt16                                                                USHORT
ValueFixedUInt16Over                                                            string(2),over(ValueFixedUInt16)

ValueFixedInt32                                                                 LONG
ValueFixedInt32Over                                                             string(4),over(ValueFixedInt32)

ValueFixedUInt32                                                                ULONG
ValueFixedUInt32Over                                                            string(4),over(ValueFixedUInt32)

UnicodeString                                                                   &UnicodeString_TYPE

!ValueUnicodeString                                                              Group,Pre(ValueUnicodeString)
!_Length                                                                             UShort
!_MaximumLength                                                                      UShort
!_Buffer                                                                             LONG
!                                                                                End
ApiResult                                                                       LONG


ValueFixedStr64                                                                 string(8)
ValueInt64                                                                      Like(INT64)
ValueUInt64                                                                     Like(UINT64)
ValueDynamic                                                                    &String

Reset                                                                           Procedure()
SetValueNull                                                                    Procedure()
SetValueTypeByEnum                                                              Procedure(long _valueTypeEnum)
SetValueTypeByName                                                              Procedure(string _valueType),long


SetValueByteFromChar                                                            Procedure(string _char)
SetValueInt16FromChars                                                          Procedure(string _chars)
SetValueUInt16FromChars                                                         Procedure(string _chars)
SetValueInt32FromChars                                                          Procedure(string _chars)
SetValueUInt32FromChars                                                         Procedure(string _chars)
SetValueUnicodeStringFromStringRef                                              Procedure(string _chars, <long _sourceEncoding>, <long _targetEncoding>)
SetValueUnicodeStringFromString                                                 Procedure(string _chars, <long _sourceEncoding>, <long _targetEncoding>)

SetValueByte                                                                    Procedure(byte _byte)
SetValueInt16                                                                   Procedure(short _int16)
SetValueUInt16                                                                  Procedure(ushort _uint16)
SetValueInt32                                                                   Procedure(long _int32)
SetValueUInt32                                                                  Procedure(ulong _uint32)
SetValueDecimal                                                                 Procedure(string _decimal)

SetValueFromClaStringRef                                                        Procedure(*string _stringRef)
SetValueFromClaString8Ref                                                       Procedure(string _stringRef)

GetValueFormatted                                                               Procedure(),String


GetValueByte                                                                    Procedure(*byte _byte)
GetValueInt16                                                                   Procedure(*short _int16)
GetValueUInt16                                                                  Procedure(*ushort _uint16)
GetValueInt32                                                                   Procedure(*long _int32)
GetValueUInt32                                                                  Procedure(*ulong _uint32)
GetValueDecimal                                                                 Procedure(*string _decimal)
GetValueClaString                                                               Procedure(*string _string)
GetValueClaStringRef                                                            Procedure(*string _stringRef)

GetValueByte                                                                    Procedure(),Byte
GetValueInt16                                                                   Procedure(),Int32
GetValueUInt16                                                                  Procedure(),UInt16
GetValueInt32                                                                   Procedure(),Int32
GetValueUInt32                                                                  Procedure(),UInt32
GetValueDecimal                                                                 Procedure(),string
!GetValueClaString                                                               Procedure(),string
!GetValueClaStringRef                                                            Procedure(),*string
!
IsValueNull                                                                     Procedure(),BOOL
GetValueType                                                                    Procedure(),long





!BufferSize                                                                  UInt32
!BytesAllocated                                                              LONG
!BytesSize                                                                   LONG
!Characters                                                                  LONG
!DataTypeEnum                                                                LONG
!Dec21                                                                       Decimal(21)
!DummyString1                                                                string(1)
!EncodingStringValue                                                         Long
!EncodingStringValueOut                                                      Long
!FieldOrdinal                                                                Long
!HeapHandle                                                                  LONG
!IsFirstField                                                                BOOL
!IsLastField                                                                 BOOL
!IsNULL                                                                      BOOL
!IsPrivateHeap                                                               bool
!IsStringValue                                                               BOOL
!NumericTypeEnum                                                             Long
!Ordinal                                                                     Long
!SourceColumnBytes                                                           Long
!SourceTypeEnum                                                              Long
!SystemDataTypeEnum                                                          LONG
!ValueLong                                                                   Long
!ValuePtr                                                                    LONG
!ValueSize                                                                   LONG
!
!BitConverterClass                                                           &c25_BitConverterClass
!Buffer                                                                      &String
!DataLength                                                                  &String
!DataType                                                                    &String
!MsSqlColumnProperties                                                       &MsSqlColumnProperty_TYPE
!Name                                                                        &String
!StringValue                                                                 &String
!Value                                                                       &String
!ValueNumeric                                                                &ValueNumeric_TYPE
!
!DeformatDataLength                                                          Procedure(string _dataLengthString)
!Dispose_MsSqlColumnProperties                                               Procedure(),long,PROC
!FindInByteArray                                                             Procedure(string _findBytes, long _valuePtr, long _valueSize, <bool _caseInsensitive>),long
!GetNumericValue                                                             Procedure(),STRING
!GetStringValue                                                              Procedure(<string _returnIfNull>, <*string _stringRef>),STRING
!GetStringValueNewRef                                                        Procedure(<string _returnIfNull>),*STRING
!GetStringValueRef                                                           Procedure(),*STRING
!GetValueFromValuePtr                                                        Procedure(long _ptr, long _size, <bool _deleteAlloc>),string
!ParseSqlite3Value                                                           Procedure(long _sqlStatementSelectHandle,long _sourceIndex),Long
!Reset                                                                       Procedure()
!SetDataType                                                                 Procedure(string _dataType),long,proc
!SetDataTypeEnum                                                             Procedure(long _dataTypeEnum),string,proc
!SetNumericValue                                                             Procedure(string _numericSource)
!SetStringValue                                                              Procedure(string _source, <long _encodingSource>, <long _encodingReturn>, <bool _setNull>)
!SetValue                                                                    Procedure(long _ptr, long _size),long,proc
!SetValue                                                                    Procedure(string _value, <long _size>),long,proc
!StringTheoryToMemAllocPtr                                                   Procedure(*StringTheory _st, <bool _freeValue>),string



                                                                        End


