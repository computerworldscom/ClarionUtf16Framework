    Include('c25_ProgramHandlerClass.inc'),Once
    Include('c25_ExtendedDataTypes.inc'),Once

c25_DataReflectionClass                                         Class(),type,Module('c25_DataReflectionClass.clw'), Link('c25_DataReflectionClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
Construct                                                           Procedure(),private
Destruct                                                            Procedure(),private

Bytes1LastAutoScroll                                                BYTE(1)
ClarionFieldsClaEnd_Array                                           Long,dim(256)
ClarionFieldsClaStart_Array                                         Long,dim(256)
ClarionFieldsIsRefStr_Array                                         bool,dim(256)
CRLF                                                                String(2)
currentOffset                                                       long
DD_ArchitectureTable_VirtualAddress                                 LONG
DD_ArchitectureTable_VirtualAddress_Hex                             STRING(8)
DD_ArchitectureTable_VirtualAddress_Size                            LONG
DD_BaseRelocationTable_VirtualAddress                               LONG
DD_BaseRelocationTable_VirtualAddress_Hex                           STRING(8)
DD_BaseRelocationTable_VirtualAddress_Size                          LONG
DD_BoundImportTable_VirtualAddress                                  LONG
DD_BoundImportTable_VirtualAddress_Hex                              STRING(8)
DD_BoundImportTable_VirtualAddress_Size                             LONG
DD_CertificateTable_VirtualAddress                                  LONG
DD_CertificateTable_VirtualAddress_Hex                              STRING(8)
DD_CertificateTable_VirtualAddress_Size                             LONG
DD_CLRRuntimeHeaderTable_VirtualAddress                             LONG
DD_CLRRuntimeHeaderTable_VirtualAddress_Hex                         STRING(8)
DD_CLRRuntimeHeaderTable_VirtualAddress_Size                        LONG
DD_DebugDirectory_VirtualAddress                                    LONG
DD_DebugDirectory_VirtualAddress_Hex                                STRING(8)
DD_DebugDirectory_VirtualAddress_Size                               LONG
DD_DelayLoadImportTable_VirtualAddress                              LONG
DD_DelayLoadImportTable_VirtualAddress_Hex                          STRING(8)
DD_DelayLoadImportTable_VirtualAddress_Size                         LONG
DD_ExceptionTable_VirtualAddress                                    LONG
DD_ExceptionTable_VirtualAddress_Hex                                STRING(8)
DD_ExceptionTable_VirtualAddress_Size                               LONG
DD_ExportTable_VirtualAddress                                       LONG
DD_ExportTable_VirtualAddress_Hex                                   STRING(8)
DD_ExportTable_VirtualAddress_Size                                  LONG
DD_GlobalPtr_VirtualAddress                                         LONG
DD_GlobalPtr_VirtualAddress_Hex                                     STRING(8)
DD_GlobalPtr_VirtualAddress_Size                                    LONG
DD_IATTable_VirtualAddress                                          LONG
DD_IATTable_VirtualAddress_Hex                                      STRING(8)
DD_IATTable_VirtualAddress_Size                                     LONG
DD_ImportTable_VirtualAddress                                       LONG
DD_ImportTable_VirtualAddress_Hex                                   STRING(8)
DD_ImportTable_VirtualAddress_Size                                  LONG
DD_LoadConfigTable_VirtualAddress                                   LONG
DD_LoadConfigTable_VirtualAddress_Hex                               STRING(8)
DD_LoadConfigTable_VirtualAddress_Size                              LONG
DD_ReservedTable_VirtualAddress                                     LONG
DD_ReservedTable_VirtualAddress_Hex                                 STRING(8)
DD_ReservedTable_VirtualAddress_Size                                LONG
DD_ResourceTable_VirtualAddress                                     LONG
DD_ResourceTable_VirtualAddress_Hex                                 STRING(8)
DD_ResourceTable_VirtualAddress_Size                                LONG
DD_TLSDirectory_VirtualAddress                                      LONG
DD_TLSDirectory_VirtualAddress_Hex                                  STRING(8)
DD_TLSDirectory_VirtualAddress_Size                                 LONG
Dec20Cla                                                            Decimal(20,0)
Decimal20                                                           Decimal(20,0)
Decimal31                                                           Decimal(31,0)
DllFileName                                                         STRING(2048)
EF_Address                                                          Long
EF_CurrentFieldAny                                                  ANY
EndOptionalHeader                                                   byte
F                                                                   Long
FieldsCount                                                         Long
FromPos                                                             Long
I                                                                   Long
I2                                                                  Long
ImageBase                                                           Long
IndicatorLong                                                       Long
IndicatorShort                                                      Short
InOptionalHeader                                                    BOOL
IsMemoryLayout                                                      BYTE
IsRefArray                                                          bool,Dim(256)
LastPos                                                             long
LibraryHandle                                                       LONG
Name                                                                cSTRING(128)
P                                                                   Long
P2                                                                  Long
ParamBuffer2                                                        STRING(16000)
ParamBuffer3                                                        STRING(16000)
PEFileOffset1                                                       LONG
PEFileOffset2                                                       LONG
Pos                                                                 long
QBlockLength                                                        Long
QBlockLengthIndicatorPos                                            Long
QDesc                                                               STRING(16000)
QDescLen                                                            LONG
QDLLSections_Fill                                                   byte
QHdrLength                                                          Long
QHdrLengthIndicatorPos                                              Long
QHdrStartPos                                                        Long
QRefStr4                                                            String(4)
QVarsLength                                                         Long
QVarsLengthIndicatorPos                                             Long
R                                                                   Long
R2                                                                  Long
SomeIntValue                                                        LONG
StartAddressDisk                                                    Long
StartOffsetFieldsDesc                                               LONG
StartPosTotalLength                                                 Long
Str8Zeroed                                                          String(8)
StrSize                                                             Long
T                                                                   Long
T2                                                                  Long
ThisLength                                                          Long
TotalLength                                                         Long
UntilPos                                                            Long
Value32Bytes                                                        LONG
Value32BytesHex                                                     STRING(8)
VirtualAddress                                                      LONG(4198400)
VirtualAddressHex                                                   STRING('00401000')
DataTypeEnginesSeedId                                               Long
DataTypesSeedId                                                     Long
ModuleHandle                                                        Long

BitConverter                                                        &c25_BitConverterClass
ClarionFields                                                       &ClarionFields_TYPE
ClarionFields1                                                      &ClarionFields_TYPE
ClarionFields2                                                      &ClarionFields_TYPE
DataReflection1                                                     &c25_DataReflectionClass
DataReflection2                                                     &c25_DataReflectionClass
EF_ptrString                                                        &String
MetaQueueObjectsQ                                                   &QueueObjectsQ_TYPE
ObjectClass                                                         &c25_ObjectClass
PtrString                                                           &String
QBytesDll                                                           &QBytesDll_TYPE
QDLLSections                                                        &QDLLSections_TYPE
QueueObjectsQ                                                       &QueueObjectsQ_TYPE
Reflection                                                          &ReflectClass
SomeQ                                                               &QUEUE
SomeQueueRef                                                        &QUEUE
StInMemDll                                                          &StringTheory()
StLoadedDll                                                         &StringTheory()
ThisNewQueue                                                        &Queue
c25_QueueObject                                                     &c25_QueueObjectClass
DataTypeEngines                                                     &DataTypeEngines_TYPE
DataTypes                                                           &DataTypes_TYPE
stLog                                                               &StringTheory()

SqliteCreateTableSql                                                Procedure(*SqliteTable_TYPE _sqliteTable),*STRING
EnumProcessModules                                                  Procedure(),string,proc
AddQBytesDll                                                        Procedure(long _PEFileOffset1, string _name, long _offset, long _bytesLen),string,proc
AddQBytesDllDataDir                                                 Procedure(long _PEFileOffset1, string _name, *long _offset, *long _virtualAddress, *string _virtualAddress_Hex, *long _VirtualAddress_Size),long,PROC
!Analyze                                                             Procedure(<*QUEUE _queue>,<*ClarionFields_TYPE _outputQ>, <Byte _autoStyleColumns>,<*GROUP _group>,<String _tableName>, <bool _debug>, <String _name>, <String _jsonFileOut>),String,proc
Analyze                                                             Procedure(<*QUEUE _queue>, <*ClarionFields_TYPE _outputQ>, <String _jsonFileOut>),String,proc
AnalyzeDll                                                          Procedure(<long _bufferPtr>, <long _bufferSize>, <string _fileNameUtf8>, <bool _isFileStructure>),long,PROC
CalcQBytesValues                                                    Procedure(*long _Pos, long _bytesLen, string _name, *long _value, *string _valueInHex),string,proc
DataTableProperty2DataTablePropertyEnum                             Procedure(string _property),long
DataTypeEnumToClarionQStorageSize                                   Procedure(long _dataTypeEnum, <long _characters>, <long _places>),LONG
DataTypeEnumToClarionQStorageType                                   Procedure(long _dataTypeEnum),long
DataTypeEnumToDllSetInfo                                            Procedure(long _segments, long _dataTypeEnum, <long _characters>, <long _places>),STRING
DataTypeEnumToDllSetInfoTrailing                                    Procedure(long _segments, long _dataTypeEnum, <long _characters>, <long _places>),STRING
!DataTypeEnumToName                                                  Procedure(long _dataTypeEnum),string
GetDataTypeEngineEnumFromDataTypeEnum                               Procedure(long _dataTypeEnum),Long
!DataTypeToEnum                                                      Procedure(string _dataTypeString),Long
!GetDataType                                                         Procedure(long _dataTypeEnum),String
GetDataTypeEngineEnum                                               Procedure(string _dataTypeEngine),long
GetDataTypeEnum                                                     Procedure(string _dataType),long
GetDataTypeFromEnum                                                 Procedure(long _dataTypeEnum),string
GetPresetString                                                     Procedure(long _segments, long _characters, long _dataTypeEnum),STRING
GetQBytesDll                                                        Procedure(<*long _jsonQBytesDll>, <*long _jsonQBytesDllSize>)
GetQDLLSections                                                     Procedure(<*long _jsonQDLLSections>, <*long _jsonQDLLSectionsSize>)
MapDataTypeTarget                                                   Procedure(ClarionFields_TYPE clarionFields, <IndexPtr32 _indexPtr>),string,PROC
PopulateDataTypeEngines                                             Procedure(),long,proc
PopulateDataTypes                                                   Procedure(),long,proc
ResetAnalyzeDll                                                     Procedure()
SetDataTypeTarget                                                   Procedure(ClarionFields_TYPE clarionFields, string fieldName, long targetDatatypeEnum),string,proc
UpdateSqliteDataTypeEnum                                            Procedure(ClarionFields_TYPE clarionFields, <bool _skipMakeFirstFieldPrimary>),string,PROC
GetDataTypeEngine                                                   Procedure(long _dataTypeEngineEnum),String



ModuleInfo                                          Group,Pre(ModuleInfo)
BaseOfDll                                               long
SizeOfImage                                             long
EntryPoint                                              long
                                                    End

PE01                                                                GROUP,PRE(PE01)
FileSize                                                                LONG
ImageOffset                                                             LONG
CharacteristicsInt16                                                    LONG
Characteristics16Bits                                                   STRING(16)
RelocsStripped                                                          BYTE
ExecutableImage                                                         BYTE
LineNumsStripped                                                        BYTE
LocalSymsStripped                                                       BYTE
AggressiveWsTrim                                                        BYTE
LargeAddressAware                                                       BYTE
BytesReversedLo                                                         BYTE
Bits32Machine                                                           BYTE
DebugStripped                                                           BYTE
RemovableRunFromSwap                                                    BYTE
NetRunFromSwap                                                          BYTE
IsSystemFile                                                            BYTE
IsDll                                                                   BYTE
SystemOnly                                                              BYTE
BytesReversedHi                                                         BYTE
PEFormat                                                                CSTRING(21)
MajorLinkerVersion                                                      BYTE
MinorLinkerVersion                                                      BYTE
SizeOfCode                                                              LONG
SizeOfCodeHex                                                           STRING(8)
SizeOfInitializedData                                                   LONG
SizeOfInitializedDataHex                                                STRING(8)
SizeOfUninitializedData                                                 LONG
SizeOfUninitializedDataHex                                              STRING(8)
AddressOfEntryPoint                                                     LONG
AddressOfEntryPointHex                                                  STRING(8)
AddressOfEntryPointSummed                                               LONG
AddressOfEntryPointSummedHex                                            STRING(8)
BaseOfCode                                                              LONG
BaseOfCodeHex                                                           STRING(8)
BaseOfData                                                              LONG
BaseOfDataHex                                                           STRING(8)
ImageBase                                                               LONG
ImageBaseHex                                                            STRING(8)
SectionAlignment                                                        LONG
SectionAlignmentHex                                                     STRING(8)
FileAlignment                                                           LONG
FileAlignmentHex                                                        STRING(8)
MajorOperatingSystemVersion                                             SHORT
MajorOperatingSystemVersionHex                                          STRING(4)
MinorOperatingSystemVersion                                             SHORT
MinorOperatingSystemVersionHex                                          STRING(4)
MajorImageVersion                                                       SHORT
MajorImageVersionHex                                                    STRING(4)
MinorImageVersion                                                       SHORT
MinorImageVersionHex                                                    STRING(4)
MajorSubsystemVersion                                                   SHORT
MajorSubsystemVersionHex                                                STRING(4)
MinorSubsystemVersion                                                   SHORT
MinorSubsystemVersionHex                                                STRING(4)
Win32VersionValue                                                       LONG
Win32VersionValueHex                                                    STRING(8)
SizeOfImage                                                             LONG
SizeOfImageHex                                                          STRING(8)
SizeOfHeaders                                                           LONG
SizeOfHeadersHex                                                        STRING(8)
CheckSum                                                                LONG
CheckSumHex                                                             STRING(8)
Subsystem                                                               SHORT
SubsystemHex                                                            STRING(4)
SubSystemName                                                           CSTRING(128)
DllCharacteristics                                                      LONG
DllCharacteristicsHex                                                   STRING(4)
DllChar_LIBRARY_PROCESS_INIT                                            BYTE
DllChar_LIBRARY_PROCESS_TERM                                            BYTE
DllChar_LIBRARY_THREAD_INIT                                             BYTE
DllChar_LIBRARY_THREAD_TERM                                             BYTE
DllChar_HIGH_ENTROPY_VA                                                 BYTE
DllChar_DYNAMIC_BASE                                                    BYTE
DllChar_FORCE_INTEGRITY                                                 BYTE
DllChar_NX_COMPAT                                                       BYTE
DllChar_NO_ISOLATION                                                    BYTE
DllChar_NO_SEH                                                          BYTE
DllChar_NO_BIND                                                         BYTE
DllChar_APPCONTAINER                                                    BYTE
DllChar_WDM_DRIVER                                                      BYTE
DllChar_GUARD_CF                                                        BYTE
DllChar_TERMINAL_SERVER_AWARE                                           BYTE
SizeOfStackReserve                                                      LONG
SizeOfStackReserveHex                                                   STRING(8)
SizeOfStackCommit                                                       LONG
SizeOfStackCommitHex                                                    STRING(8)
SizeOfHeapReserve                                                       LONG
SizeOfHeapReserveHex                                                    STRING(8)
SizeOfHeapCommit                                                        LONG
SizeOfHeapCommitHex                                                     STRING(8)
LoaderFlags                                                             LONG
LoaderFlagsHex                                                          STRING(8)
NumberOfRvaAndSizes                                                     LONG
NumberOfRvaAndSizesHex                                                  STRING(8)
                                                                    END
COFFFileHeader                                                      GROUP,PRE(COFFFileHeader)
Machine                                                                 USHORT
MachineHex                                                              STRING(8)
MachineName                                                             STRING(128)
NumberOfSections                                                        LONG
NumberOfSectionHex                                                      STRING(8)
TimeDateStamp                                                           LONG
TimeDateStampHex                                                        STRING(8)
TimeDateStampString                                                     STRING(128)
TimeDateStampNanoSeconds                                                DECIMAL(20,0)
PointerToSymbolTable                                                    LONG
PointerToSymbolTableHex                                                 STRING(8)
NumberOfSymbols                                                         LONG
NumberOfSymbolsHex                                                      STRING(8)
SizeOfOptionalHeader                                                    LONG
SizeOfOptionalHeaderHex                                                 STRING(8)
Characteristics                                                         LONG
CharacteristicsHex                                                      STRING(8)
CharacteristicsBits                                                     STRING(16)
                                                                    END
EF_AdrGroup                                                         Group,pre(EF_AdrGroup)
EF_PtrAddress                                                           Long
EF_PtrSize                                                              Long
                                                                    End
QueueGroup                                                          Group,Pre(QueueGroup)
Q                                                                       &QUEUE
                                                                    End
Dec20ClaStr11                                                       String(11),Over(Dec20Cla)
Decimal20_Over                                                      String(11),Over(Decimal20)
Decimal31_Over                                                      String(16),Over(Decimal31)
EF_AddressAndSizeFromAny                                            String(8),over(EF_AdrGroup)
EF_AddressFromAny                                                   String(4),over(EF_Address)
IndicatorLongStrOver                                                String(4),Over(IndicatorLong)
IndicatorShortStrOver                                               String(2),Over(IndicatorShort)
LengthStr                                                           String(4),Over(ThisLength)
QBlockLengthStr                                                     String(4),Over(QBlockLength)
QHdrLengthStr                                                       String(4),Over(QHdrLength)
QRefLongOverStr4                                                    Long,over(QRefStr4)
QVarsLengthStr                                                      String(4),Over(QVarsLength)
TotalLengthStr                                                      String(4),Over(TotalLength)
                                                                End


