    Include('c25_ProgramHandlerClass.inc'),Once

c25_WinApiClass                  Class(),type, Module('c25_WinApiClass.clw'), Link('c25_WinApiClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
Construct                               Procedure()
Destruct                                Procedure()

GetKnownPathById                        Procedure(string _knownFolderId, <long _KNOWN_FOLDER_FLAG>, <bool _returnAnsi>),*STRING
GetKnownPathGuidById                    Procedure(string _knownFolderId),STRING
GetKnownPathEnumNameById                Procedure(string _knownFolderId),STRING


ReturnVal                               Long

GetCurrentProcess                       Procedure(),Long,proc
GetProcessHandle                        Procedure(),Long,proc
!AddressPtr                              Long
!ArmCloseWindowPhaseId                   Long
!BitPos                                  Byte
!BITS32                                  String(32)
!Bits64                                  String(64)
!BITS8                                   String(8)
!Buffer16K                               String(17000)
!Buffer64K                               String(65000)
!BufferLength                            Long
!ByteOut                                 Byte
!BytePos                                 Byte
!ByteVal                                 Byte
!CEnd                                    Long
!CRLF                                    String(2)
!CStart                                  Long
!CurrentPathA                            String(32000)
DirectoryHandle                         Long
!ErrorCodeInt                            Long
FileHandleFirst                         Long
!FilesCount                              Long
!FoldersCount                            Long
!GlobalMemPtr                            Long
!Guid36                                  String(36)
!hKeyDefault                             Long
!HResult                                 Long
!INPUTINT                                Long
!Int64                                   String(8)
!Int64Grp                                Like(INT64)
!L                                       Long
!LogClientWinHandle                      Long
!NTSTatusCode                            Long
!NTSTatusCustomer                        Byte
!NTSTatusFacility                        Long
!NTSTatusIsNTSTATUS                      Byte
!NTSTatusSeverity                        Byte
!NTSTatusSeverityError                   Byte
!NTSTatusSeverityInformational           Byte
!NTSTatusSeveritySuccess                 Byte
!NTSTatusSeverityWarning                 Byte
!OneLong                                 Long
!P                                       Long
!PathPrependAnsi                         String(4)
!ProcessHeapHandle                       Long
!Return2MB                               String(2000000)
!ReturnBuffer64K                         String(65000)
!ShellWindowHandle                       Long
!ShortOut                                Short
!SomeCString                             cstring(1024)
!Str1K                                   String(1024)
!Str2                                    String(2)
!Str2K                                   String(2048)
!Str4                                    String(4)
!Str8                                    String(8)
!STRING1                                 String(1)
!WindowInfo_Changed                      Byte
!Zero                                    Byte
!Zero2                                   Short
!GetSpecialPathGuid36                          Procedure(string _pathName),string

BitConverterClass                       &c25_BitConverterClass
AnsiStringSearchUpper                   &String
AnsiStringUpper                         &String
ArmCloseWindowNanoSync                  &NanoSyncClass
BufferStr                               &String
ClaFileQ                                &ClaFile_TYPE
CurrentPathW                            &String
DictKey                                 &String
DummyStringRef                          &String
FolderToScanQ                           &FolderToScan_TYPE
FormatMessageAnsi                       &String
GlobalMem                               &c25GlobalMemClass
json1                                   &JSONClass
NanoClock                               &NanoSyncClass()
OddJob                                  &JobObject()
PathPrependUtf16                        &String
Reflection                              &TrueReflectionClass
ReflectionCapesoft                      &ReflectClass
ReturnString                            &String

PrivilegeName                           cstring(128)
TOKEN_PRIVILEGES                        group,Pre(TOKEN_PRIVILEGES)
PrivilegeCount                              ULong
Privileges                                  Group,dim(100)
PrivLUIDS                                       Like(UINT64)
PrivATTRS                                       Long
                                            End
                                        End
UserRightsPtr                           Long
CountOfRightsPtr                        Long

SystemNameA                             cstring(1024)
AccountNameA                            cstring(1024)
SidA                                    string(1024)
RefDomainNameA                          string(1024)
CchRefDomainNameA                       long
SidASize                                Long
SidNameUse                              long
SidAStringPtr                           long
SidAString                              string(1024)
SidAccountNameA                         cstring(16000)
SidAccountNameASize                     Long
SidReferencedDomainNameA                cstring(16000)
SidReferencedDomainNameASize            Long

PrivNameUtf16                           &String
peUse                                   Long

PolicyHandle                            Long

LUID                                    Like(UINT64)
LSA_OBJECT_ATTRIBUTES                   Group,Pre(LSA_OBJECT_ATTRIBUTES)
Length                                      ulong
RootDirectory                               long
ObjectName                                  long
Attributes                                  ulong
SecurityDescriptor                          long
SecurityQualityOfService                    long
                                        End
LSA_UNICODE_STRING                      Group,Pre(LSA_UNICODE_STRING)
Length                                      USHORT
MaximumLength                               USHORT 
BufferPtr                                   Long
                                        End
BufferA                                 &STRING
BufferW                                 &STRING

BufferHeapPageSize                      long

SystemInfo                              Like(SystemInfo_TYPE)
PFNArraySize                            Long
PFNArray                                Long !,dim(1000)
AWEPages                                Long
AWERequestMemoryDec                     Decimal(20,0)
AWERequestMemory                        Like(UINT64)
AllocationGranularityDec                Decimal(20,0)
AllocationGranularity                   long
AWEPage                                 &String
VirtualSwapSize                         Long
VirtualSwapMaxPages                     Long


MemReserved                             Long !,dim(1000)
MemReservedSize                         Long
NumberOfPagesAlloc                      Long
SizeLargePages                          Long
SizeLargePagesDec                       Decimal(20,0)
AWEPagesDec                             decimal(20,0)

!st1                                     &StringTheory()
!st2                                     &StringTheory()
!StAnsi                                  &StringTheory()
!StAnsiToAnsi                            &StringTheory()
!StAnsiToUtf16                           &StringTheory()
!StAnsiToUtf8                            &StringTheory()
!StLog                                   &StringTheory()
!StUtf16                                 &StringTheory()
!StUtf16ToAnsi                           &StringTheory()
!StUtf16ToUtf16                          &StringTheory()
!StUtf16ToUtf8                           &StringTheory()
!StUtf32                                 &StringTheory()
!StUtf8                                  &StringTheory()
!StUtf8ToAnsi                            &StringTheory()
!StUtf8ToUtf16                           &StringTheory()
!StUtf8ToUtf8                            &StringTheory()
SubKeyPathDefault                       &String
WindowInfoQ                             &WindowInfo_TYPE
WindowsInfoQ                            &WindowInfo_TYPE

!!!!SECURITY_ATTRIBUTES                     group,Pre(SECURITY_ATTRIBUTES)
!!!!nLength                                     ULong
!!!!lpSecurityDescriptor                        unsigned    ! Address of a security descriptor data structure
!!!!bInheritHandle                              Long
!!!!                                        End
!!!!pOwner                                  Long
!!!!lpbOwnerDefaulted                       Long
!!!!
!!!!
!!!!
!!!!ppsidOwner                              long
!!!!ppsidGroup                              Long
!!!!ppDacl                                  Long
!!!!ppSacl                                  long 
!!!!ppSecurityDescriptor                    Long
!!!!
!!!!ppsidOwnerADDRESS                       long
!!!!ppsidGroupADDRESS                       Long
!!!!ppDaclADDRESS                           Long
!!!!ppSaclADDRESS                           long 
!!!!ppSecurityDescriptorADDRESS             Long
!!!!
!!!!
!!!!GetSecurityInfo                         Procedure(),string,Proc


LockMemory                              Procedure(),long,PROC

!AnsiToAnsi                              Procedure(String _ansi),*String
!AnsiToUtf16                             Procedure(String _ansi,<Byte _debug>),*String
!AnsiToUtf16GetLength                    Procedure(String _ansi),Long
!AnsiToUtf8                              Procedure(String _ansi),*String
!AnsiToUtf8GetLength                     Procedure(String _ansi),Long
!ArmCloseWindow                          Procedure(<Long _startPhaseId>),Long,proc
!BinaryCopy                              Procedure(String _binary),*String
!BlobToBlob                              Procedure(*String _blob),*String
!BlobToBlob                              Procedure(String _blob),*String
!BufferToByteQ                           Procedure(<String _buffer>, <Long _startAddress>,<Long _expectedLength>,<String _fileName>),String,proc
!CheckArmCloseWindow                     Procedure(),Long,proc
!ConcatAnsi                              Procedure(<Byte _preRemoveTrailingZeros>, <String _divider>,String _s1, String _s2, <String _s3>, <String _s4>, <String _s5>, <String _s6>, <String _s7>, <String _s8>),*String
!ConcatAnsiStr                           Procedure(<Byte _preRemoveTrailingZeros>, <String _divider>,String _s1, String _s2, <String _s3>, <String _s4>, <String _s5>, <String _s6>, <String _s7>, <String _s8>),String
!ConcatUtf16                             Procedure(<Byte _preRemoveTrailingZeros>, <String _divider>,String _s1, String _s2, <String _s3>, <String _s4>, <String _s5>, <String _s6>, <String _s7>, <String _s8>),*String
!ConcatUtf16Str                          Procedure(<Byte _preRemoveTrailingZeros>, <String _divider>,String _s1, String _s2, <String _s3>, <String _s4>, <String _s5>, <String _s6>, <String _s7>, <String _s8>),String
!ConcatUtf8                              Procedure(<Byte _preRemoveTrailingZeros>, <String _divider>,String _s1, String _s2, <String _s3>, <String _s4>, <String _s5>, <String _s6>, <String _s7>, <String _s8>),*String
!ConcatUtf8Str                           Procedure(<Byte _preRemoveTrailingZeros>, <String _divider>,String _s1, String _s2, <String _s3>, <String _s4>, <String _s5>, <String _s6>, <String _s7>, <String _s8>),String
CopyFileUtf16                           Procedure(String _existingFileName, String _newFileName),String,PROC
!CreateString                            Procedure(<String _value>,<Long _len>),*String,proc
!CropZerosAnsi                           Procedure(String _ansi),*String
!CropZerosAnsiStr                        Procedure(String _ansi),String
!CropZerosUtf16                          Procedure(String _utf16),*String
!CropZerosUtf16Str                       Procedure(String _utf16),String
!CropZerosUtf8                           Procedure(String _utf8),*String
!CropZerosUtf8Str                        Procedure(String _utf8),String
!DictAddKeyValue                         Procedure(*Dictionary_TYPE _dict, String _key, String _value, <Byte _caseSensitive>),Byte,proc
!DictGetValue                            Procedure(*Dictionary_TYPE _dict, String _key, <Byte _caseSensitive>),String
!DictKeyExists                           Procedure(*Dictionary_TYPE _dict, String _key, <Byte _caseSensitive>),Byte
!FastByteFromHex2                        Procedure(String _Hex),Byte
!FastCharFromHex2                        Procedure(String _Hex),String
!FastHexFromByte                         Procedure(Byte _Byte),String
!FastHexFromLong                         Procedure(Long _long),String
FileOrFolderExistUtf16                  Procedure(<String _folderNameW>, <String _folderNameWPtr>),Long,proc
!FileToJsonStringRef                     Procedure(*File _t, <Byte _allRecords>),*String
!FormatErrorMessage                      Procedure(Long _errorCode),String
!FormatErrorMessageAnsi                  Procedure(<ULong _errorcode>, <Long _ntstatus>, <String _extraPrefixText>),*String
!FormatErrorMessageAnsiStr               Procedure(<ULong _errorcode>, <Long _ntstatus>,<Byte _showMessage>,<String _extraPrefixText>),String,proc
!GenerateRandomBuffer                    Procedure(<Long _size>, <Long _bufferPtr>, <Long _algorithmProvider>),Long,proc
!GetBits32FromStr4                       Procedure(*String _str),String,proc
!GetBits8FromString1                     Procedure(*String _str),String,proc
!GetCurrentExeFullPathAnsi               Procedure(),String,PROC
GetCurrentExeFullPathUtf16              Procedure(),String,PROC
GetCurrentExeFullPathUtf16ByRef         Procedure(),*String,PROC
!GetCurrentExeFullPathUtf8               Procedure(),String,PROC
!GetCurrentThread                        Procedure(),Long,proc
!GetExecutionThread                      Procedure(),Long,proc
!GetGlobalDictionaryValue                Procedure(String _key, <any _valueIfNull>),String
!GetGlobalMemPtrFromReg32                Procedure(),Long,proc
!GetLogServerWinHandleFromReg32          Procedure(),Long
!GetLongFromStr4                         Procedure(String _str4),Long
!GetProcessHeapHandle                    Procedure(),Long
!GetReg                                  Procedure(<Long _key>,<String _nodePath>,String _valueName, <String _returnValueWhenNull>),String
!GetShortFromStr2                        Procedure(String _str2),Short
!GetThreadHandle                         Procedure(),Long,proc
!GetThreadId                             Procedure(),Long,proc
!GetULongFromStr4                        Procedure(String _str4),ULong
!GetUShortFromStr2                       Procedure(String _str2),UShort
!Guid16FromGuid36                        Procedure(String _guid36),String
!Guid74To16                              Procedure(String _guid74),String
!Guid74To36                              Procedure(String _guid74),String
!HeapAlloc                               Procedure(Long _size),Long
!INT64ToBits                             Procedure(String _int64),String
!InitGlobalMem                           Procedure(),Long,proc
!IsInstalled                             Procedure(),Long
!JsonStringToQueue                       Procedure(*StringTheory _stJson, *queue _q),Byte,proc
!JsonStringToQueue                       Procedure(String _jsonString, *queue _q),Byte,proc
!MultiSzZeroToCRLFUtf16                  Procedure(String _utf16),*String
!MultiSzZeroToCRLFUtf16Str               Procedure(String _utf16),String
!ParseWin32FindDataW                     Procedure(),String,proc
!ParseZeroTerminatedStringA              Procedure(Long _ptr, <Byte _excludeTermZero>, <Byte _debug>),String
!ParseZeroTerminatedUtf16String          Procedure(Long _address, Long _getLengthOrBufferLen, <Byte _excludeTermZero>,<Byte _skipReturnString>),String
!PostLogLine                             Procedure(String _line),Long,proc
!PtrToPtrAndSizePtrToStr                 Procedure(Long _ptrToPtrAndSize),String
!PutReg                                  Procedure(<Long _key>,<String _subKeyPath>,String _entryName, String _entryValue, <Long _regDataType>, <Byte _skipReplace>, <Byte _removeTrailingZeros>),String,proc
!QueueRecordToStringRefPtr               Procedure(*Queue _q),Long
!QueueToJsonString                       Procedure(*queue _q, <Byte _disposeQ>, <Byte _skipFormatted>, <Byte _compress>),String
!QueueToJsonStringRef                    Procedure(*queue _q, <Byte _disposeQ>, <Byte _skipFormatted>, <Byte _compress>),*String
!QueueToJsonStringTheory                 Procedure(*StringTheory _st, *queue _q, <Byte _disposeQ>, <Byte _skipFormatted>, <Byte _compress>),String,proc
!ReadDirectory                           Procedure(String _searchPath, <String _mask>, <Byte Recursdir>),String,proc
!RefToPtrAndSizePtr                      Procedure(*String _strRef),Long
!RemoveGlobalDictionaryValue             Procedure(String _key, <Byte _caseSensitive>),String,proc
!RemoveTrailingZeros                     Procedure(String _str,<Long _encoding>),*String,proc
!ReplaceCharsAnsi                        Procedure(String _string, String _old, String _new, <Long _codePage>),String,proc
!ReplaceCharsUtf16                       Procedure(String _string, String _old, String _new),String,proc
!ReplaceCharsUtf8                        Procedure(String _string, String _old, String _new),String,proc
!SetGlobalDictionaryValue                Procedure(String _key,String _value),String,proc
!StringRefJsonToQueue                    Procedure(*String _strRef, *queue _q, <Byte _initFree>, <Byte _skipDisposeStringRef>),String,proc
!StringRefPtrToQueue                     Procedure(Long _ptrAndSizePtr, *Queue _q, <Byte _add>),Long,proc
!StringRefPtrToString                    Procedure(Long _ptrAndSizePtr),String
!StringRefToQueue                        Procedure(*String _strRef, *queue _q, <Byte _initFree>, <Byte _skipDisposeStringRef>),String,proc
!StringToStringRefPtr                    Procedure(String _s, <Byte _globalAlloc>),Long
!Utf16ToAnsi                             Procedure(String _utf16),*String
!Utf16ToAnsiGetLength                    Procedure(String _utf16),Long
!Utf16ToAnsiStr                          Procedure(String _utf16),String
!Utf16ToUtf16                            Procedure(String _utf16),*String
!Utf16ToUtf8                             Procedure(String _utf16),*String
!Utf16ToUtf8GetLength                    Procedure(String _utf16),Long
!Utf8ToAnsi                              Procedure(String _utf8),*String
!Utf8ToUtf16                             Procedure(String _utf8),*String
!Utf8ToUtf8                              Procedure(String _utf8),*String
!UuidCreateA                             Procedure(<Byte _lowerCase>),String
!UuidCreateSequential                    Procedure(<Byte _lowerCase>),String
!UuidToString                            Procedure(String _bytes16),String,proc
!


Guid36                                  string(36)
Guid16                                  string(16)
PeekByte                                byte
Ptr                                     Long
FoundFolderPathLen                      LONG
FoundFolderPath                         &String
KnownFolderNamePointer                  Long
KNOWN_FOLDER_FLAG                       Long



DirectoryNameUtf16                      String(16000)
FindOrCreateFolderUtf16                 Procedure(<String _folderNameW>, <String _folderNameWPtr>),Long,proc
!GetKnownFolders                         Procedure(),String,proc
!GetKnownPath                            Procedure(<String _pathNameStr>,<*String _pathName>, <*String _strOut>,<Long _returnEncoding>,<Long _inputEncoding>),*String,proc
GetWindowRect                           Procedure(<Long _handle>),String
RemoveFileUtf16                         Procedure(String _fileName, <Byte _messageBoxIfError>),String,PROC
InterPacket                             Group(InterPacket_TYPE)
                                        End
Win32FindDataW                          Group(Win32FindDataW_TYPE),Pre(Win32FindDataW)
                                        End
WndClassExA                             Group(WndClassExA_TYPE),Pre(WndClassExA)
                                        End
WindowInfo                              Group(WindowInfo_TYPE),Pre(WindowInfo)
                                        End
WinInfo                                 Group(WinAPI_WindowInfo_TYPE),Pre(WinInfo)
                                        End
WindowInfoQ_Last                        Group(WindowInfo_TYPE),Pre(WindowInfoQ_Last)
                                        End
ClientInfoQ_Last                        Group(WindowInfo_TYPE),Pre(WindowInfoQ_Last)
                                        End
CompareWindowInfoQ                      Group(WindowInfo_TYPE),Pre(WindowInfoQ_Last)
                                        End
KnownFolders                            Group(KnownFolders_TYPE),Pre(KnownFolders)
                                        End

!GetMessageNameById                      Procedure(Long _id),String
!Rect                                    Group,Pre(Rect)
!Left                                        Long
!Top                                         Long
!Right                                       Long
!Bottom                                      Long
!Width                                       Long
!Height                                      Long
!                                        End
!INPUT                                   String(4),OVER(INPUTINT)
!ShortOverStr2                           Short,over(Str2)
!LongOverStr4                            Long,over(Str4)

!RectObject                              String(24),Over(Rect)
!ULongOverStr4                           ULong,over(Str4)
!UShortOverStr2                          UShort,over(Str2)

                                    End












