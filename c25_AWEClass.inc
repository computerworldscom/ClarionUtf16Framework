    Include('c25_ProgramHandlerClass.inc'),Once
    !Include('c25_ExtendedDataTypes.inc'),Once

c25_AWEClass           	                Class(),type,Module('c25_AWEClass.clw'), Link('c25_AWEClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
Construct                                   Procedure()
Destruct                                    Procedure()

BufferSize                                  ulong
ProcessHeapHandle                           LONG
MemFileMappingSeedId                        Long
MapFileViewSeedId                           Long
BufferHeapPageSize                          LONG
AddressHighMarkSigByte                      long
BufferHeapFragmentPtr                       LONG
BufferHeapFragmentPtrForHexViewer           LONG
BufferHeapFragmentsPerPage                  LONG
BufferHeapMemAddress                        LONG
BufferHeapPageCurrent                       LONG
BufferHeapRandomFragmentSize                BYTE
ColumnIsEven                                BYTE
ColumnIsOdd                                 BYTE
BufferHeapQRecords                          LONG
LargePageMinimum                            Long
MemAllocProvider                            Long
Dec20                                       Decimal(20)
PageId                                      LONG
FragmentsFrom                               LONG
FragmentsTill                               LONG
FragmentsTotal                              LONG
ZERO8                                       STRING(8)
AddressZERO8                                Long
A                                           Long
AHighMarkSigBytePos                         LONG
MaxHeapMemAddress                           Long
ByteVal                                     Byte
ByteValOld                                  Byte
AddressByteVal                              LONG
R                                           Long
LOG                                         BYTE
ZeroPaddingLen                              LONG
CursorAddress                               LONG
Counter                                     LONG
FileNameA                                   cstring(1024)
FileNameW                                   cstring(1024)
LogReturn                                   REAL
TotalMem                                    REAL
TestBlock                                   string(70000)

Tuple2                                      Group
V1                                              LONG
V2                                              LONG
                                            End
PrivilegeName                               cstring(128)

TOKEN_PRIVILEGES                            group,Pre(TOKEN_PRIVILEGES)
PrivilegeCount                                  ULong
Privileges                                      Group,dim(100)
PrivLUIDS                                           Like(UINT64)
PrivATTRS                                           Long
                                                End
                                            End
UserRightsPtr                               Long
CountOfRightsPtr                            Long
SystemNameA                                 cstring(1024)
AccountNameA                                cstring(1024)
SidA                                        string(1024)
RefDomainNameA                              string(1024)
CchRefDomainNameA                           long
SidASize                                    Long
SidNameUse                                  long
SidAStringPtr                               long
SidAString                                  string(1024)
SidAccountNameA                             cstring(16000)
SidAccountNameASize                         Long
SidReferencedDomainNameA                    cstring(16000)
SidReferencedDomainNameASize                Long
peUse                                       Long
PolicyHandle                                Long
LUID                                        Like(UINT64)
LSA_OBJECT_ATTRIBUTES                       Group,Pre(LSA_OBJECT_ATTRIBUTES)
Length                                      ulong
RootDirectory                               long
ObjectName                                  long
Attributes                                  ulong
SecurityDescriptor                          long
SecurityQualityOfService                    long
                                            End
LSA_UNICODE_STRING                          Group,Pre(LSA_UNICODE_STRING)
Length                                          USHORT
MaximumLength                                   USHORT
BufferPtr                                       Long
                                            End
SystemInfo                                  &SystemInfo_TYPE
PFNArraySize                                Long
PFNArray                                    Long
AWEPages                                    Long
AWERequestMemoryDec                         Decimal(20,0)
AWERequestMemory                            Like(UINT64)
AllocationGranularityDec                    Decimal(20,0)
AllocationGranularity                       long
VirtualSwapSize                             Long
VirtualSwapMaxPages                         Long
MemReserved                                 Long
MemReservedSize                             Long
NumberOfPagesAlloc                          Long
SizeLargePages                              Long
hToken                                      Long
SizeLargePagesDec                           Decimal(20,0)
AWEPagesDec                                 decimal(20,0)
ReturnVal                                   Long
SECURITY_ATTRIBUTES                         group,Pre(SECURITY_ATTRIBUTES)
nLength                                         ULong
lpSecurityDescriptor                            unsigned
bInheritHandle                                  Long
                                            End
pOwner                                      Long
lpbOwnerDefaulted                           Long
ppsidOwner                                  long
ppsidGroup                                  Long
ppDacl                                      Long
ppSacl                                      long
ppSecurityDescriptor                        Long
ppsidOwnerADDRESS                           long
ppsidGroupADDRESS                           Long
ppDaclADDRESS                               Long
ppSaclADDRESS                               long
ppSecurityDescriptorADDRESS                 Long

BitConverterClass                           &c25_BitConverterClass
NanoClockClass                              &c25_NanoSyncClass
AWEPage                                     &String
Buffer                                      &String
BufferA                                     &STRING
BufferW                                     &STRING
MapFileView                                 &MapFileView_TYPE
MemFileMapping                              &MemFileMapping_TYPE
PrivNameUtf16                               &String
SubKeyPathDefault                           &String
WindowInfoQ                                 &WindowInfo_TYPE
WindowsInfoQ                                &WindowInfo_TYPE

CreatePages                                 Procedure(),long,PROC
CreateVirtualQueue                          Procedure(),long,proc
LockMemory                                  Procedure(),long,proc

                                        End




