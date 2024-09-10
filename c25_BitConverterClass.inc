Include('c25_ProgramHandlerClass.inc'),Once

Int8                                    EQUATE(byte)
Int16                                   EQUATE(short)
Int32                                   EQUATE(long)
PtrInt32                                EQUATE(long)
ByteArray                               EQUATE(STRING)

c25_BitConverterClass                                                   Class(),type, Module('c25_BitConverterClass.clw'), Link('c25_BitConverterClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)

Construct                                                                   Procedure()
Destruct                                                                    Procedure()

ClassTypeName                                                               cstring(128)

ColorBGRA                                                                   Group,Pre(ColorBGRA)
B                                                                               Byte
G                                                                               Byte
R                                                                               Byte
A                                                                               Byte
                                                                            End


Dec20                                                                     decimal(20,0)
Int64                                                                   like(INT64)
DecStr                                                                  string(21)

ConvertToI64                                                                Procedure(string _value),String
ConvertFromI64                                                              Procedure(string _I64),String



!    Self.st1 &= NEW StringTheory()
!    Self.st1.Start()
!    Self.st2 &= NEW StringTheory()
!    Self.st2.Start()
!    Self.st3 &= NEW StringTheory()
!    Self.st3.Start()
!    Self.StAnsi &= New StringTheory()
!    Self.StAnsi.Start()
!    Self.StAnsiToAnsi &= NEW StringTheory()
!    Self.StAnsiToAnsi.Start()
!    Self.StAnsiToUtf16 &= New StringTheory()
!    Self.StAnsiToUtf16.Start()
!    Self.StAnsiToUtf8 &= New StringTheory()
!    Self.StAnsiToUtf8.Start()
!    Self.StUtf16 &= New StringTheory()
!    Self.StUtf16.Start()
!    Self.StUtf16ToAnsi &= New StringTheory()
!    Self.StUtf16ToAnsi.Start()
!    Self.StUtf16ToUtf8 &= NEW StringTheory()
!    Self.StUtf16ToUtf8.Start()
!    Self.StUtf32 &= New StringTheory()
!    Self.StUtf32.Start()
!    Self.StUtf8 &= New StringTheory()
!    Self.StUtf8.Start()
!    Self.StUtf8ToAnsi &= New StringTheory()
!    Self.StUtf8ToAnsi.Start()
!    Self.StUtf8ToUtf8 &= NEW StringTheory()
!    Self.StUtf8ToUtf8.Start()
!!    Self.Js1 &= NEW JSONClass()
!!    Self.Js1.Start()
!    
!
!
!

Int16MaxValue                                                               decimal(20)
Int16MinValue                                                               decimal(20)
Int32                                                                       Long
Int32MaxValue                                                               decimal(20)
Int32MinValue                                                               decimal(20)
Int64MaxValue                                                               decimal(20)
Int64MinValue                                                               decimal(20)
ResultCode                                                                  Long
SelfAddress                                                                 Long
UInt16MaxValue                                                              decimal(20)
UInt16MinValue                                                              decimal(20)
UInt32MaxValue                                                              decimal(20)
UInt32MinValue                                                              decimal(20)
UInt64MaxValue                                                              decimal(20)
UInt64MinValue                                                              decimal(20)


AddressPtr                                                                  Long
AnsiPtr                                                                     Long
BitPos                                                                      Byte
BITS16                                                                      String(16)
BITS32                                                                      String(32)
Bits64                                                                      String(64)
BITS8                                                                       String(8)
Buffer16K                                                                   String(17000)
Buffer64K                                                                   String(65000)
BufferLength                                                                Long
ByteOut                                                                     Byte
BytePos                                                                     Byte
BytesArray16K                                                               ByteArray(17000)
BytesArray16KAddress                                                        LONG
ByteVal                                                                     Byte
CEnd                                                                        Long
CRLF                                                                        String(2)
CStart                                                                      Long
CurrentPathA                                                                String(32000)
DirectoryHandle                                                             Long
DirectoryNameUtf16                                                          String(16000)
ErrorCodeInt                                                                Long
FoldersCount                                                                Long
Guid16                                                                      String(16)
Guid36                                                                      String(36)
Hex8                                                                        string(8)
HResult                                                                     Long
INPUTINT                                                                    Long
Int64Str8                                                                       String(8)
Int64Grp                                                                    Like(INT64)
L                                                                           Long
NTSTatusCode                                                                Long
NTSTatusCustomer                                                            Byte
NTSTatusFacility                                                            Long
NTSTatusIsNTSTATUS                                                          Byte
NTSTatusSeverity                                                            Byte
NTSTatusSeverityError                                                       Byte
NTSTatusSeverityInformational                                               Byte
NTSTatusSeveritySuccess                                                     Byte
NTSTatusSeverityWarning                                                     Byte
OneLong                                                                     Long
P                                                                           Long
Return2MB                                                                   String(2000000)
ReturnBuffer64K                                                             String(65000)
ShortOut                                                                    Short
SomeCString                                                                 cstring(1024)
Str1K                                                                       String(1024)
Str2                                                                        String(2)
Str2K                                                                       String(2048)
Str4                                                                        String(4)
Str8                                                                        String(8)
STRING1                                                                     String(1)
T                                                                           Long
Zero                                                                        Byte
Zero2                                                                       Short

AnsiStringSearchUpper                                                       &String
AnsiStringUpper                                                             &String
BufferStr                                                                   &String
CurrentPathW                                                                &String
DataReflection                                                              &c25_DataReflectionClass
DataReflectionTemp                                                          &c25_DataReflectionClass
DummyStringRef                                                              &String
FormatMessageAnsi                                                           &String
Js1                                                                         &JSONClass
ReturnString                                                                &String
St1                                                                         &StringTheory()
St2                                                                         &StringTheory()
St3                                                                         &StringTheory()
StAnsi                                                                      &StringTheory()
StAnsiToAnsi                                                                &StringTheory()
StAnsiToUtf16                                                               &StringTheory()
StAnsiToUtf8                                                                &StringTheory()
StLog                                                                       &StringTheory()
StUtf16                                                                     &StringTheory()
StUtf16ToAnsi                                                               &StringTheory()
StUtf16ToUtf16                                                              &StringTheory()
StUtf16ToUtf8                                                               &StringTheory()
StUtf32                                                                     &StringTheory()
StUtf8                                                                      &StringTheory()
StUtf8ToAnsi                                                                &StringTheory()
StUtf8ToUtf16                                                               &StringTheory()
StUtf8ToUtf8                                                                &StringTheory()
Utf16Buffer                                                                 &String


Get_UNICODE_STRING                                                          Procedure(*UnicodeString_TYPE _unicodeString, <bool _isNull>, <*string _stringOut>),String

GetBits                                                                     Procedure(string _input, long _lengthBytes),String

StringIsInt                                                                 Procedure(string _input),bool
Int32ToHex                                                                  Procedure(Int32 _int32, <bool _trim>, <bool _prefixOddWithZero>),string
AnsiToAnsi                                                                  Procedure(String _ansi),*String
AnsiToUtf16                                                                 Procedure(String _ansi,<Byte _debug>,<Byte _addUtf16Zero>),*String
AnsiToUtf16Fast                                                             Procedure(*String _ansi, Long _lenAnsi, <*String _utf16>),String,proc
AnsiToUtf16GetLength                                                        Procedure(String _ansi),Long
AnsiToUtf16Str                                                              Procedure(String _ansi,<Byte _debug>,<Byte _addUtf16Zero>),String
AnsiToUtf8                                                                  Procedure(String _ansi, <long _extraZeroCount>),*String
AnsiToUtf8GetLength                                                         Procedure(String _ansi),Long
BinaryCopy                                                                  Procedure(ByteArray _binary, <bool _forceNullTerminated>),*ByteArray
BinaryCopyByLen                                                             Procedure(long _len, <string _clearChar>),*String
BlobToBlob                                                                  Procedure(*String _blob),*String
BlobToBlob                                                                  Procedure(String _blob),*String
BufferToByteQ                                                               Procedure(<String _buffer>, <Long _startAddress>,<Long _expectedLength>,<String _fileName>),String,proc
ColorFromARGB                                                               Procedure(long _a, long _r, long _g, long _b),long
ConcatAnsi                                                                  Procedure(<Byte _preRemoveTrailingZeros>, <String _divider>,String _s1, String _s2, <String _s3>, <String _s4>, <String _s5>, <String _s6>, <String _s7>, <String _s8>),*String
ConcatAnsiStr                                                               Procedure(<Byte _preRemoveTrailingZeros>, <String _divider>,String _s1, String _s2, <String _s3>, <String _s4>, <String _s5>, <String _s6>, <String _s7>, <String _s8>),String
ConcatUtf16                                                                 Procedure(<Byte _preRemoveTrailingZeros>, <String _divider>,String _s1, String _s2, <String _s3>, <String _s4>, <String _s5>, <String _s6>, <String _s7>, <String _s8>),*String
ConcatUtf16Str                                                              Procedure(<Byte _preRemoveTrailingZeros>, <String _divider>,String _s1, String _s2, <String _s3>, <String _s4>, <String _s5>, <String _s6>, <String _s7>, <String _s8>),String
ConcatUtf8                                                                  Procedure(<Byte _preRemoveTrailingZeros>, <String _divider>,String _s1, String _s2, <String _s3>, <String _s4>, <String _s5>, <String _s6>, <String _s7>, <String _s8>),*String
ConcatUtf8Str                                                               Procedure(<Byte _preRemoveTrailingZeros>, <String _divider>,String _s1, String _s2, <String _s3>, <String _s4>, <String _s5>, <String _s6>, <String _s7>, <String _s8>),String
CreateGuid36                                                                Procedure(),String
CreateString                                                                Procedure(<String _value>,<Long _len>),*String,proc
!ClipZeroUtf16                                                               Procedure(*string _utf16String),long
CropZerosAnsi                                                               Procedure(String _ansi),*String
CropZerosAnsiStr                                                            Procedure(String _ansi),ByteArray
CropZerosUtf16                                                              Procedure(String _utf16),*String
CropZerosUtf16Str                                                           Procedure(String _utf16),String
CropZerosUtf8                                                               Procedure(String _utf8),*String
CropZerosUtf8Str                                                            Procedure(String _utf8),String
FastByteFromHex2                                                            Procedure(String _Hex),Byte
FastCharFromHex2                                                            Procedure(String _Hex),String
FastHexFromByte                                                             Procedure(Byte _Byte),String
FastHexFromLong                                                             Procedure(Long _long),String
FileToJsonStringRef                                                         Procedure(*File _t, <Byte _allRecords>),*String
FormatErrorMessage                                                          Procedure(Long _errorCode),String
FormatErrorMessageAnsi                                                      Procedure(<ULong _errorcode>, <Long _ntstatus>, <String _extraPrefixText>),*String
FormatErrorMessageAnsiStr                                                   Procedure(<ULong _errorcode>, <Long _ntstatus>,<Byte _showMessage>,<String _extraPrefixText>),String,proc
GetBits16FromShort                                                          Procedure(long _int16),String,proc
GetBits16FromStr2                                                           Procedure(String _str2),String,proc
GetBits32FromLong                                                           Procedure(Long _int32),String,proc
GetBits32FromStr4                                                           Procedure(String _str4),String,proc
GetBits8FromString1                                                         Procedure(String _str),String,proc
GetBytesFromInt16                                                           Procedure(short _short, <bool _trim>),ByteArray
GetBytesFromInt32                                                           Procedure(long _int32, <bool _trim>),ByteArray
GetLongFromStr4                                                             Procedure(String _str4),Long
GetShortFromStr2                                                            Procedure(String _str2),Short
GetULongFromStr4                                                            Procedure(String _str4),ULong
GetUShortFromStr2                                                           Procedure(String _str2),UShort
GetValueByPtr                                                               Procedure(PtrInt32 _valuePtr, Int32 _valueLen, *StringTheory stOut, <bool _freeValuePtr>)
GetValueByPtr                                                               Procedure(PtrInt32 _valuePtr, Int32 _valueLen, <bool _freeValuePtr>),STRING
GetValueRefByPtr                                                            Procedure(PtrInt32 _valuePtr, Int32 _valueLen, <bool _freeValuePtr>),*STRING
Guid16FromGuid36                                                            Procedure(String _guid36),String
Guid16To36                                                                  Procedure(String _guid16),String
Guid36FromGuid16                                                            Procedure(String _guid16),String
Guid74To16                                                                  Procedure(String _guid74),String
Guid74To36                                                                  Procedure(String _guid74),String
INT64ToBits                                                                 Procedure(String _int64),String
IntegerStringToUInt64                                                       Procedure(string _integer),string
JsonStringTheoryToQueue                                                     Procedure(*StringTheory _jsonStringTheory, *queue _q, <Byte _debug>),Byte,proc
JsonStringToQueue                                                           Procedure(String _jsonString, *queue _q, <Byte _debug>),Byte,proc
MultiSzZeroToCRLFUtf16                                                      Procedure(String _utf16),*String
MultiSzZeroToCRLFUtf16Str                                                   Procedure(String _utf16),String
ParseZeroTerminatedStringA                                                  Procedure(Long _ptr, <Byte _excludeTermZero>, <Byte _debug>),String
ParseZeroTerminatedStringAToRef                                             Procedure(Long _ptr, <Byte _excludeTermZero>),*String
ParseZeroTerminatedUtf16String                                              Procedure(Long _address, Long _getLengthOrBufferLen, <Byte _excludeTermZero>,<Byte _skipReturnString>),String
PtrToPtrAndSizePtrToStr                                                     Procedure(Long _ptrToPtrAndSize),String
QToJson                                                                     Procedure(*queue _q, <String _filenameSave>, <bool _format>, <bool _compress>),String,proc
QToJsonToStringTheoryValuePtr                                               Procedure(*Queue _q,*long _valuePtr, *long _valueSize),Long,PROC
QueueRecordToStringRefPtr                                                   Procedure(*Queue _q),Long
QueueToJsonString                                                           Procedure(*queue _q, <Byte _disposeQ>, <Byte _skipFormatted>, <Byte _compress>,<String _filenameSave>),String,proc
QueueToJsonStringRef                                                        Procedure(*queue _q, <Byte _disposeQ>, <Byte _skipFormatted>, <Byte _compress>),*String
QueueToJsonStringTheory                                                     Procedure(*StringTheory _st, *queue _q, <Byte _disposeQ>, <Byte _skipFormatted>, <Byte _compress>,<String _filenameSave>),String,proc
RefToPtrAndSizePtr                                                          Procedure(*String _strRef),Long
RemoveTrailingZeros                                                         Procedure(String _str,<Long _encoding>),*String,proc
ReplaceCharsAnsi                                                            Procedure(String _string, String _old, String _new, <Long _codePage>),String,proc
ReplaceCharsUtf16                                                           Procedure(String _string, String _old, String _new),String,proc
ReplaceCharsUtf8                                                            Procedure(String _string, String _old, String _new),String,proc
ShortToHex                                                                  Procedure(short _short, <byte _lowercase>),string
StAppendLine                                                                Procedure(*StringTheory _st, string _line)
StringRefJsonToQueue                                                        Procedure(*String _strRef, *queue _q, <Byte _initFree>, <Byte _skipDisposeStringRef>),String,proc
StringRefPtrToQueue                                                         Procedure(Long _ptrAndSizePtr, *Queue _q, <Byte _add>),Long,proc
StringRefPtrToString                                                        Procedure(Long _ptrAndSizePtr, <bool _reuse>),String
StringRefPtrToStringWmSpecialStr                                            Procedure(Long _ptrAndSizePtr),String
StringRefPtrToWmSpecial                                                     Procedure(Long _ptrAndSizePtr),Long
StringRefToQueue                                                            Procedure(*String _strRef, *queue _q, <Byte _initFree>, <Byte _skipDisposeStringRef>),String,proc
StringToJsonObject                                                          Procedure(string _s),*JSONClass
StringToStringRefPtr                                                        Procedure(String _s),Long
StringToStringRefPtr                                                        Procedure(long _wmSpecial, String _s),Long
Utf16ToAnsi                                                                 Procedure(String _utf16),*String
Utf16ToAnsiGetLength                                                        Procedure(String _utf16),Long
Utf16ToAnsiStr                                                              Procedure(String _utf16),String
Utf16ToUtf8                                                                 Procedure(String _utf16),*String
Utf16ToUtf8GetLength                                                        Procedure(String _utf16),Long
Utf16ToUtf8Str                                                              Procedure(String _utf16, <bool _addTrailingZero>),String
Utf8ToAnsi                                                                  Procedure(String _utf8),*String
Utf8ToUtf16                                                                 Procedure(String _utf8, <bool _debug>, <BOOL _addUtf16Zero>),*String
Utf8ToUtf8                                                                  Procedure(String _utf8),*String
UuidCreateA                                                                 Procedure(<Byte _lowerCase>),String
UuidCreateSequential                                                        Procedure(<Byte _lowerCase>),String
UuidFromStringA                                                             Procedure(String _guid36),String,proc
UuidToString                                                                Procedure(String _bytes16),String,proc



ColorOverBGRA                                                               long,Over(ColorBGRA)
INPUT                                                                       String(4),OVER(INPUTINT)
LongOverStr4                                                                Long,over(Str4)
ShortOverStr2                                                               Short,over(Str2)
ULongOverStr4                                                               ULong,over(Str4)
UShortOverStr2                                                              UShort,over(Str2)

                                                                        End


