        Member

        Include('c25_AWEClass.inc'),Once

                    MAP
                        Include('CWUTIL.inc'),once
                        Include('i64.inc')
						Include('c25_WinApiPrototypes.inc')
                    End

c25_AWEClass.Destruct                                                    Procedure()

Code

    If not Self.BitConverterClass     &= NULL THEN Dispose(Self.BitConverterClass).

c25_AWEClass.Construct                                                   Procedure()

Code

    Self.ProcessHeapHandle                      = c25_GetProcessHeap()

    Self.MemFileMapping                         &= NEW MemFileMapping_TYPE
    Self.MapFileView                            &= NEW MapFileView_TYPE
    Self.BitConverterClass                      &= NEW c25_BitConverterClass()
    
    Self.ppsidOwnerADDRESS                       = Address(Self.ppsidOwner)
    Self.ppsidGroupADDRESS                       = Address(Self.ppsidGroup)
    Self.ppDaclADDRESS                           = Address(Self.ppDacl)
    Self.ppSaclADDRESS                           = Address(Self.ppSacl)
    Self.ppSecurityDescriptorADDRESS             = Address(Self.ppSecurityDescriptor)
        
c25_AWEClass.LockMemory     Procedure()


CODE
        

    !st &= NEW StringTheory()

    Clear(Self.LSA_OBJECT_ATTRIBUTES)
    Self.LSA_OBJECT_ATTRIBUTES.Length = Size(Self.LSA_OBJECT_ATTRIBUTES)

    Self.ReturnVal = C25_LsaOpenPolicy(0, Address(Self.LSA_OBJECT_ATTRIBUTES), POLICY_ALL_ACCESS, Address(Self.PolicyHandle))
    Message(Self.PolicyHandle)
    
    Self.AccountNameA = 'Administrator' & Chr(0)
    Self.SidASize = Size(Self.SidA)
    Self.CchRefDomainNameA = Size(Self.RefDomainNameA)
    Clear(Self.SidA)

    Self.SidASize = 0
    Self.ReturnVal = C25_LookupAccountNameA (0, Address(Self.AccountNameA), Address(Self.SidA), Address(Self.SidASize), Address(Self.RefDomainNameA), Address(Self.CchRefDomainNameA), Address(Self.SidNameUse))
    Self.ReturnVal = C25_LookupAccountNameA (0, Address(Self.AccountNameA), Address(Self.SidA), Address(Self.SidASize), Address(Self.RefDomainNameA), Address(Self.CchRefDomainNameA), Address(Self.SidNameUse))

    Self.SidAStringPtr = 0

    Self.ReturnVal = C25_ConvertSidToStringSidA(Address(Self.SidA),Address(Self.SidAStringPtr))

    If Self.SidAStringPtr <> 0
        Self.SidAString = Self.BitConverterClass.ParseZeroTerminatedStringA(Self.SidAStringPtr, true)
    End
    
!    st.Start()
!    st.Append(Self.SidAString)
!    st.SaveFile('m:\sid.txt')
    
    Self.PrivNameUtf16 &= NEW STRING(Size(Self.SidAString))
    
    !Message(Size(Self.PrivNameUtf16))
    

    Self.LSA_UNICODE_STRING.Length = Size(Self.PrivNameUtf16)-2

    Self.LSA_UNICODE_STRING.MaximumLength   = Self.LSA_UNICODE_STRING.Length + 2
    Self.LSA_UNICODE_STRING.BufferPtr       = Address(Self.PrivNameUtf16)

    Self.ReturnVal = C25_LsaAddAccountRights(Self.PolicyHandle, Address(Self.SidA), Address(Self.LSA_UNICODE_STRING), 1)

!    Self.PrivilegeName = SE_LOCK_MEMORY_NAME
!    Self.PrivilegeName = SE_SHUTDOWN_NAME
    Self.PrivilegeName = 'SeLockMemoryPrivilege' & Chr(0)
    Clear(Self.LUID,-1)

    B# = C25_LookupPrivilegeValueA(0, Address(Self.PrivilegeName), Address(Self.LUID))

    Clear(Self.TOKEN_PRIVILEGES,-1)

    Self.ReturnVal = c25_OpenProcessToken(-1, TOKEN_QUERY + TOKEN_DUPLICATE + TOKEN_IMPERSONATE + TOKEN_ASSIGN_PRIMARY + TOKEN_ADJUST_PRIVILEGES, Address(Self.hToken))

    !Message(Self.hToken)
    
    Self.TOKEN_PRIVILEGES.PrivilegeCount = 1
    Self.TOKEN_PRIVILEGES.Privileges[1].PrivLUIDS = Self.LUID
    Self.TOKEN_PRIVILEGES.Privileges[1].PrivATTRS = 2
    Self.ReturnVal = c25_AdjustTokenPrivileges(Self.hToken, False, Address(Self.TOKEN_PRIVILEGES), Size(Self.TOKEN_PRIVILEGES), 0, 0)

    !Message('Self.ReturnVal adjust ' & Self.ReturnVal)
    
    Self.ReturnVal = C25_LsaEnumerateAccountRights(Self.PolicyHandle, Address(Self.SidA), Address(Self.UserRightsPtr), Address(Self.CountOfRightsPtr))

    Clear(Self.LSA_UNICODE_STRING)

    C25_Memcpy(Address(Self.LSA_UNICODE_STRING),Self.UserRightsPtr, 8)

    If Self.LSA_UNICODE_STRING.Length > 0 And Self.LSA_UNICODE_STRING.BufferPtr <> 0
        Self.BufferW &= NEW STRING(Self.LSA_UNICODE_STRING.Length)
        C25_Memcpy(Address(Self.BufferW), Self.LSA_UNICODE_STRING.BufferPtr, Self.LSA_UNICODE_STRING.Length)
        Self.BufferA &= Self.BitConverterClass.Utf16ToAnsi(Self.BufferW)
    End

    Self.SidAccountNameASize = Size(Self.SidAccountNameA)
    Self.SidReferencedDomainNameASize = Size(Self.SidReferencedDomainNameA)
    Self.peUse = 1

    Self.ReturnVal = C25_LookupAccountSidA(0,  Address(Self.SidA), Address(Self.SidAccountNameA), Address(Self.SidAccountNameASize),Address(Self.SidReferencedDomainNameA), Address(Self.SidReferencedDomainNameASize), Address(Self.peUse))

    Return 0
    
    
c25_AWEClass.CreatePages     Procedure()

CODE
        
    Clear(Self.SystemInfo)

    C25_GetSystemInfo(Address(Self.SystemInfo))

    Self.AllocationGranularityDec = Self.SystemInfo.AllocationGranularity
    Self.AllocationGranularity = Self.SystemInfo.AllocationGranularity

    Self.SizeLargePages = c25_GetLargePageMinimum()
    Self.SizeLargePagesDec = Self.SizeLargePages
    Self.AWERequestMemoryDec = 12884901888
    Self.AWEPagesDec = Self.AWERequestMemoryDec /Self.AllocationGranularityDec

    Self.AWEPages = Self.AWEPagesDec

    Self.AWERequestMemoryDec = Self.AWEPagesDec * Self.AllocationGranularityDec

    Self.VirtualSwapSize = 536870912

    Self.VirtualSwapMaxPages = Self.VirtualSwapSize / Self.AllocationGranularity
    
    Self.AWEPage &= NEW STRING(Self.AllocationGranularity)
    P# = 0
    Loop Size(Self.AWEPage) TIMES
        P# = P# + 1
        Self.AWEPage[P#] = Chr(Random(0,255))
    End    
    !Message('bolock ' & Self.AllocationGranularity / 512)
    
    
    Self.PFNArraySize   =  (Self.AWEPages * 8)
    Self.PFNArray = c25_VirtualAlloc( 0, Self.PFNArraySize, c25_MEM_RESERVE + c25_MEM_COMMIT , c25_PAGE_READWRITE)    
    

    
!    B# = c25_AllocateUserPhysicalPages(c25_GetCurrentProcess(), Address(Self.AWEPages), Self.PFNArray)
!    If B# <> True
!        Message('error c25_AllocateUserPhysicalPages')
!    Else
!        !Message('c25_AllocateUserPhysicalPages ok')
!    End
!    
    Self.MemReserved = c25_VirtualAlloc( 0, Self.VirtualSwapSize, c25_MEM_RESERVE + c25_MEM_PHYSICAL , c25_PAGE_READWRITE)
    If Self.MemReserved = 0
        Message('error virtual alloc ')
    ELSE
       ! Message('Self.MemReserved ok')
    End
    
    Offset# = Random(0, Self.AWEPages) !Self.AllocationGranularity)
    !Message(Size(Self.AWEPage) & ', ' & Self.AllocationGranularity)
    
    Offset# = -1
    Loop 24 TIMES
        Offset# = Offset# + 1
!        I# = Self.AllocationGranularity * -1
!        L# = Val('A') - 1

        
        B# = c25_AllocateUserPhysicalPages(c25_GetCurrentProcess(), Address(Self.AWEPages), Self.PFNArray)
        If B# <> True
            Message('error c25_AllocateUserPhysicalPages')
        Else
            !Message('c25_AllocateUserPhysicalPages ok')
        End
            
        
        
        Self.NumberOfPagesAlloc = Self.VirtualSwapMaxPages !100 !Self.VirtualSwapSize / Self.AllocationGranularity

        bResult# = c25_MapUserPhysicalPages( Self.MemReserved + Offset#, Self.NumberOfPagesAlloc, Self.PFNArray)
        If bResult# = 0
            Message(Offset# & ', error c25_MapUserPhysicalPages, ' & C25_GetLastError() )
            BREAK
        Else
            !Message('c25_MapUserPhysicalPages ok')
        END

        !33554432
        !Message('Self.VirtualSwapMaxPages ' & Self.VirtualSwapMaxPages)
        T# = 0 !513
        Offset2# = Self.AllocationGranularity * -1
        LOOP 512 Times !100 Times !Self.VirtualSwapMaxPages - 1 Times
            Offset2# = Offset2# + Self.AllocationGranularity
            !SETCLIPBOARD(Offset2#)
            !T# = T# + 1
            !SETCLIPBOARD(T#)
            C25_Memcpy(Self.MemReserved + Offset2#, Address(Self.AWEPage), Size(Self.AWEPage))
        End

        
        bResult# = c25_MapUserPhysicalPages( Self.MemReserved + Offset#, Self.NumberOfPagesAlloc, 0)

        !break
    End
    
    Message('ok')
    
    
    
    

!    Message('Self.AWEPages ' & Self.AWEPages)
!    
!    Self.PFNArraySize   =  (Self.AWEPages * 8)
!
!    Self.PFNArray = c25_VirtualAlloc( 0, Self.PFNArraySize, c25_MEM_RESERVE + c25_MEM_COMMIT , c25_PAGE_READWRITE)
!
!    Message('Self.PFNArray ' & Self.PFNArray)
!
!    B# = c25_AllocateUserPhysicalPages(c25_GetCurrentProcess(), Address(Self.AWEPages), Self.PFNArray)
!    If B# <> True
!        Message('error c25_AllocateUserPhysicalPages')
!    Else
!        Message('c25_AllocateUserPhysicalPages ok')
!    End
!
!    Self.MemReserved = c25_VirtualAlloc( 0, Self.VirtualSwapSize, c25_MEM_RESERVE + c25_MEM_PHYSICAL , c25_PAGE_READWRITE)
!    If Self.MemReserved = 0
!        Message('error virtual alloc ')
!    ELSE
!        Message('Self.MemReserved ok')
!    End
!
!    
!    Self.AWEPage &= NEW STRING(Self.AllocationGranularity)
!
!    P# = 0
!    Loop Size(Self.AWEPage) TIMES
!        P# = P# + 1
!        Self.AWEPage[P#] = Chr(Random(0,255))
!    End
!
!    Message('start')
!
!    I# = Self.AllocationGranularity * -1
!    L# = Val('A') - 1
!
!    Loop 1 Times
!        I# = I# + Self.AllocationGranularity
!
!        Self.NumberOfPagesAlloc = Self.VirtualSwapSize / Self.AllocationGranularity
!
!        bResult# = c25_MapUserPhysicalPages( Self.MemReserved, Self.NumberOfPagesAlloc, Self.PFNArray)
!        If bResult# = 0
!            Message(I# & ', error c25_MapUserPhysicalPages at ' & C25_GetLastError() )
!            BREAK
!        Else
!            Message('c25_MapUserPhysicalPages ok')
!        END
!
!        Offset# = Self.AllocationGranularity * -1
!        LOOP 510 Times
!            Offset# = Offset# + Self.AllocationGranularity
!            C25_Memcpy(Self.MemReserved + Offset#, Address(Self.AWEPage), Size(Self.AWEPage))
!        End
!
!    End
    !Message('ok')

    !Dispose(st)

    Return ''

    
c25_AWEClass.CreateVirtualQueue     Procedure()

ThreadHandle                Long
processId                   long
process                     Long
ByteVal                     byte
ByteValAddress              long
BufferHeapMemAddress        long
BufferHeapPageSize                      long

Pages                       decimal(20)
PagesSize                   decimal(20)
FileSizeDec                 decimal(20)
FileSizeUINT64              like(UINT64)
PageSizeDec                 decimal(20)
OffsetDec                   decimal(20)
OffsetUINT64                like(UINT64)
RandomPageAddress           long
ViewMapHandle               Long

    CODE
        
        Return 0
    
    ByteValAddress = Address(ByteVal)

    FileSizeUINT64.hi = 8
    FileSizeUINT64.lo = 0
    
    i64ToDecimal(FileSizeDec, FileSizeUINT64)
    !Message('FileSizeDec ' & FileSizeDec)
    
    PagesSize = 2^24
    PagesSize = 2^16
    Pages = FileSizeDec / PagesSize
    
    Message('Pages ' & Pages)
    
    RandomPageAddress = c25_VirtualAlloc2(0, 0, PagesSize, c25_MEM_COMMIT + c25_MEM_RESERVE, c25_PAGE_READWRITE, 0, 0)
    
    P# = -1
    Loop PagesSize Times
        P# = P# + 1
        ByteVal = Random(0,255)
        c25_memcpy(RandomPageAddress+P#,ByteValAddress,1)
    End
    
    c25_VirtualLock(RandomPageAddress, PagesSize)
    
    Self.MemFileMappingSeedId               = Self.MemFileMappingSeedId + 1
    Self.MemFileMapping.Id                  = Self.MemFileMappingSeedId
    Self.MemFileMapping.FileNameA           = 'FileMapped' & Format(Self.MemFileMapping.Id,@N09)
    Self.MemFileMapping.FileMapSizeHi       = FileSizeUINT64.hi
    Self.MemFileMapping.FileMapSizeLo       = FileSizeUINT64.lo 
    Self.MemFileMapping.FileMapHandle = c25_CreateFileMappingA(c25_INVALID_HANDLE_VALUE, 0, c25_PAGE_READWRITE, Self.MemFileMapping.FileMapSizeHi, Self.MemFileMapping.FileMapSizeLo,Address(Self.MemFileMapping.FileNameA))
    If Self.MemFileMapping.FileMapHandle = 0 Or Self.MemFileMapping.FileMapHandle = -1
        Message(Self.MemFileMapping.Id & 'Error c25_CreateFileMappingA ' & C25_GetLastError())
    End
    Add(Self.MemFileMapping)
    
    Message('passing random')
    
    OffsetDec = PagesSize *-1
    Loop Pages TIMES
        OffsetDec = OffsetDec + PagesSize
        i64FromDecimal(OffsetUINT64, OffsetDec)
        
        ViewMapHandle = c25_MapViewOfFile(Self.MemFileMapping.FileMapHandle, c25_FileMapAllAccess, OffsetUINT64.hi, OffsetUINT64.lo, PagesSize) 
        c25_memcpy(ViewMapHandle , RandomPageAddress, PagesSize)

        c25_UnMapViewOfFile(ViewMapHandle)
        
        !c25_VirtualUnLock(ViewMapHandle#, Self.MemFileMapping.FileMapSizeLo)
        !c25_VirtualFree(ViewMapHandle#, 0, c25_MEM_RELEASE)        
    END
    c25_VirtualUnLock(RandomPageAddress, PagesSize)
    
    
    OffsetDec = 0
    OffsetDec = OffsetDec + PagesSize
    i64FromDecimal(OffsetUINT64, OffsetDec)
    
    ViewMapHandle = c25_MapViewOfFile(Self.MemFileMapping.FileMapHandle, c25_FileMapAllAccess, OffsetUINT64.hi, OffsetUINT64.lo, PagesSize) 
    c25_memcpy(ViewMapHandle , RandomPageAddress, PagesSize)

    
    Self.BitConverterClass.st1.SetValueByAddress(ViewMapHandle, PagesSize)
    Self.BitConverterClass.st1.SaveFile('m:\randomview.txt')
    
    c25_UnMapViewOfFile(ViewMapHandle)
    
    Message('done')
    
!    ByteValAddress = Address(ByteVal)
!    !Message('CreateVirtualQueue')
!    
!    BufferHeapPageSize = 2^22
!    Message('BufferHeapPageSize ' & BufferHeapPageSize)
!    
!    BufferHeapMemAddress              = c25_VirtualAlloc2(0, 0, BufferHeapPageSize, c25_MEM_COMMIT + c25_MEM_RESERVE, c25_PAGE_READWRITE, 0, 0)
!    Message('BufferHeapMemAddress ' & BufferHeapMemAddress)
!    c25_VirtualLock(BufferHeapMemAddress, BufferHeapPageSize)
!
!    P# = -1
!    Loop BufferHeapPageSize Times
!        P# = P# + 1
!        ByteVal = Random(0,255)
!        c25_memcpy(BufferHeapMemAddress+P#,ByteValAddress,1)
!    End
!!        If BufferHeapMemAddress = 0
!     !BufferHeapMemAddress              = c12_HeapAlloc(c12_GetProcessHeap(),HEAP_ZERO_MEMORY,BufferHeapPageSize)    
!    
!    
!    Self.MemFileMappingSeedId = Self.MemFileMappingSeedId + 1
!    Self.MemFileMapping.Id = Self.MemFileMappingSeedId
!    Self.MemFileMapping.FileNameA = 'FileMapped' & Format(Self.MemFileMapping.Id,@N09)
!    Self.MemFileMapping.FileMapSizeHi = 10
!    Self.MemFileMapping.FileMapSizeLo = 0 !2^22
!    Self.MemFileMapping.FileMapHandle = c25_CreateFileMappingA(c25_INVALID_HANDLE_VALUE, 0, c25_PAGE_READWRITE, Self.MemFileMapping.FileMapSizeHi, Self.MemFileMapping.FileMapSizeLo,Address(Self.MemFileMapping.FileNameA))
!    If Self.MemFileMapping.FileMapHandle = 0
!        Message(Self.MemFileMapping.Id & 'error fileemapping ' & C25_GetLastError())
!
!    Else
!        Message('Self.MemFileMapping.FileMapHandle ' & Self.MemFileMapping.FileMapHandle)
!    End
!    
!    batches = FileSize64 / BufferHeapPageSize
!    Message('batches ' & batches)
!!    FileSize64                              decimal(20)
!!    PageSizeDec                             decimal(20)
!!    OffsetDec                               decimal(20)
!!    OffsetINT64 like(UINT64)
!    
!    
!    !Offset# = BufferHeapPageSize * -1
!    Loop batches TIMES
!        !Offset# = Offset# + BufferHeapPageSize
!        ViewMapHandle# = c25_MapViewOfFile(Self.MemFileMapping.FileMapHandle, c25_FileMapAllAccess, 0, 0, Self.MemFileMapping.FileMapSizeLo) 
!!        P# = -1
!!        Loop Self.MemFileMapping.FileMapSizeLo Times
!!            P# = P# + 1
!!            ByteVal = Random(0,255)
!!            c25_memcpy(ViewMapHandle#+P#,ByteValAddress,1)
!!        End
!        c25_memcpy(ViewMapHandle#+P#,ByteValAddress,BufferHeapPageSize)
!        Add(Self.MemFileMapping)
!        c25_UnMapViewOfFile(ViewMapHandle#)
!        
!        !c25_VirtualUnLock(ViewMapHandle#, Self.MemFileMapping.FileMapSizeLo)
!        !c25_VirtualFree(ViewMapHandle#, 0, c25_MEM_RELEASE)        
!    END
!    c25_VirtualUnLock(BufferHeapMemAddress, BufferHeapPageSize)
!    
    
    
    
    
    
    
    
    
    
    
    
    
    
!    I = 0
!    Loop
!        I = I + 1
!        Get(SortBucketsQG,I) 
!        If Errorcode() <> 0
!            BREAK
!        End
!!        SortBucketsIndexVQRows = SortBucketsIndexVQRows + SortBucketsQG.Count
!        SortBucketsQG.FileNameA     = 'SortBucketsQGMemAddress' & I & Chr(0)
!        
!        LogReturn                   = c25_log2(SortBucketsQG.MemSize)
!        LogReturnInt                = LogReturn + 1
!        SortBucketsQG.FileMapSize   = 2^(LogReturnInt)
!
!        SortBucketsQG.FileMapHandle = c12_CreateFileMappingA(INVALID_HANDLE_VALUE,0,PAGE_READWRITE,0,SortBucketsQG.FileMapSize,Address(SortBucketsQG.FileNameA))
!        If SortBucketsQG.FileMapHandle = 0
!            CYCLE
!        End
!        If SortBucketsQG.FileMapHandle <> 0
!            SortBucketsQG.ViewMapHandle = c12_MapViewOfFile(SortBucketsQG.FileMapHandle, FileMapAllAccess,0, 0,SortBucketsQG.FileMapSize)    
!            c12_memcpy(SortBucketsQG.ViewMapHandle,SortBucketsQG.MemAddress,SortBucketsQG.MemSize)
!        END
!        Put(SortBucketsQG)
!        c12_VirtualUnLock(SortBucketsQG.MemAddress, SortBucketsQG.MemSize)
!        c12_VirtualFree(SortBucketsQG.MemAddress, 0, MEM_RELEASE)
!        
!        SortBucketsQG.MemAddress = 0
!        Put(SortBucketsQG)
!        SortBucketsIndexVQRows = SortBucketsIndexVQRows + SortBucketsQG.Count
!        c12_EmptyWorkingSet(c12_getcurrentprocess())
!    End
!        
    
    
    
!    processId = c25_GetCurrentProcessId()
!    process = C25_Openprocess(PROCESS_ALL_ACCESS , false, processId)
!    
    !Message(processId & ', ' & process)
    
    !c25_GetCurrentThread()
    
    !Message(c25_GetCurrentThread())
    
!    Message(c25_GetCurrentThreadId())
!    
!    HT# = c25_OpenThread(THREAD_QUERY_LIMITED_INFORMATION , False, c25_GetCurrentThreadId())
!    
!    Message(C25_GetLastError() & ',real thread handle : ' & HT#)
!    
    
 
        return 0
        
!    I = 0
!    Loop
!        I = I + 1
!        Get(SortBucketsQG,I) 
!        If Errorcode() <> 0
!            BREAK
!        End
!!        SortBucketsIndexVQRows = SortBucketsIndexVQRows + SortBucketsQG.Count
!        SortBucketsQG.FileNameA     = 'SortBucketsQGMemAddress' & I & Chr(0)
!        
!        LogReturn                   = c25_log2(SortBucketsQG.MemSize)
!        LogReturnInt                = LogReturn + 1
!        SortBucketsQG.FileMapSize   = 2^(LogReturnInt)
!
!        SortBucketsQG.FileMapHandle = c12_CreateFileMappingA(INVALID_HANDLE_VALUE,0,PAGE_READWRITE,0,SortBucketsQG.FileMapSize,Address(SortBucketsQG.FileNameA))
!        If SortBucketsQG.FileMapHandle = 0
!            CYCLE
!        End
!        If SortBucketsQG.FileMapHandle <> 0
!            SortBucketsQG.ViewMapHandle = c12_MapViewOfFile(SortBucketsQG.FileMapHandle, FileMapAllAccess,0, 0,SortBucketsQG.FileMapSize)    
!            c12_memcpy(SortBucketsQG.ViewMapHandle,SortBucketsQG.MemAddress,SortBucketsQG.MemSize)
!        END
!        Put(SortBucketsQG)
!        c12_VirtualUnLock(SortBucketsQG.MemAddress, SortBucketsQG.MemSize)
!        c12_VirtualFree(SortBucketsQG.MemAddress, 0, MEM_RELEASE)
!        
!        SortBucketsQG.MemAddress = 0
!        Put(SortBucketsQG)
!        SortBucketsIndexVQRows = SortBucketsIndexVQRows + SortBucketsQG.Count
!        c12_EmptyWorkingSet(c12_getcurrentprocess())
!    End
!        
!        
        

!!    Self.BufferHeapPageSize     = 2^23
!!    !Self.MemAllocProvider       = 2
!!    Self.BufferHeapMemAddress   = c25_VirtualAlloc2(0, 0, Self.BufferHeapPageSize, C25_MEM_COMMIT + C25_MEM_RESERVE, C25_PAGE_READWRITE, 0, 0)
!!    Message('Self.BufferHeapMemAddress ' & Self.BufferHeapMemAddress)
!!    
!!!    If BufferHeapMemAddress = 0
!!!        BufferHeapMemAddress              = c12_HeapAlloc(c12_GetProcessHeap(),HEAP_ZERO_MEMORY,BufferHeapPageSize)
!!!        BufferHeapQ.MemAllocProvider     = 1
!!!    End              
!!    c25_VirtualLock(Self.BufferHeapMemAddress, Self.BufferHeapPageSize)
!!            
!!
!!





!!!!!!
!!!!!!NumberOfPages long
!!!!!!PageArray      Long
!!!!!!Token         Long
!!!!
!!!!hProcess      Long
!!!!ThisToken                                       Long
!!!!RetVal                              Long
!!!!!SECURITY_INFORMATION                Long
!!!!pSecurityDescriptor                string(10000)
!!!!lpnLengthNeeded                                 Long
!!!!
!!!!DesiredAccess                                  long
!!!!
!!!!SECURITY_DESCRIPTOR             Group
!!!!Revision                            byte
!!!!Sbz1                                byte
!!!!Control                             short
!!!!OffsetOwner                         Long
!!!!OffsetGroup                         Long
!!!!OffsetSacl                          Long
!!!!OffsetDacl                          Long
!!!!Buffer                              string(2048)
!!!!                                End
!!!!FileHandle                                      Long
!!!!FileNameA                                       cstring(1024)
!!!!
!!!!MemSize                                         Long
!!!!MemAddress                                      Long
!!!!
!!!!!SomeBuffer string(10000)
!!!!!SomeBuffer2 string(10000)
!!!!dacl                                            Long
!!!!secDescr                                        Long
!!!!
!!!!CODE
!!!!
!!!!!OWNER_SECURITY_INFORMATION
!!!!!
!!!!!0x00000001
!!!!!
!!!!!Return the Owner portion of the security descriptor.
!!!!!
!!!!!GROUP_SECURITY_INFORMATION
!!!!!
!!!!!0x00000002
!!!!!
!!!!!Return the Group portion of the security descriptor.
!!!!!
!!!!!DACL_SECURITY_INFORMATION
!!!!!
!!!!!0x00000004
!!!!!
!!!!!Return the DACL portion of the security descriptor.
!!!!!
!!!!!SACL_SECURITY_INFORMATION
!!!!!
!!!!!0x00000008
!!!!!
!!!!!Return the SACL portion    
!!!!    !https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-lsad/62175da4-e30f-4c12-b1c4-dae0434e38af
!!!!    !Clear(SomeBuffer,-1)
!!!!    !Clear(SomeBuffer2,-1)
!!!!    !https://www.codeproject.com/Articles/10200/The-Windows-Access-Control-Model-Part-2
!!!!    
!!!!    
!!!!    C25_SetLastError(0)
!!!!    FileNameA = 'MyQ.json'
!!!!    !C25_Read_Control + 
!!!!    !FileHandle = c25_CreateFileA(Address(FileNameA), c25_FILE_SHARE_READ, c25_FILE_SHARE_READ + c25_FILE_SHARE_WRITE,0, C25_File_Open_Existing, 080h,0)
!!!!    FileHandle = c25_CreateFileA(Address(FileNameA), C25_File_All_Access, C25_FILE_SHARE_READ, 0, C25_File_Open_Existing, c25_FILE_ATTRIBUTE_NORMAL,0)
!!!!    If FileHandle = 0 Or FileHandle = -1
!!!!        Message('error FileHandle')
!!!!    End 
!!!!    Clear(SECURITY_DESCRIPTOR,-1)
!!!!    !Message('FileHandle  ' & FileHandle)
!!!!    
!!!!    SECURITY_DESCRIPTOR.Revision = 1
!!!!    SECURITY_DESCRIPTOR.Control = 0
!!!!    
!!!!    !MemSize = Size(SECURITY_DESCRIPTOR)
!!!!    !dacl = c25_HeapAlloc(C25_Getprocessheap(), c25_HEAP_ZERO_MEMORY, 1000)
!!!!    !secDescr = c25_HeapAlloc(C25_Getprocessheap(), c25_HEAP_ZERO_MEMORY, 1000)
!!!!    
!!!!    
!!!!    dacl = c25_GlobalAlloc(0, 1024)
!!!!    
!!!!    Message(dacl)
!!!!    
!!!!!    MemSize = Size(SECURITY_DESCRIPTOR)
!!!!!    MemAddress = c25_HeapAlloc(C25_Getprocessheap(), c25_HEAP_ZERO_MEMORY, MemSize)    
!!!!!
!!!!!    C25_Memcpy(MemAddress,Address(SECURITY_DESCRIPTOR),Size(SECURITY_DESCRIPTOR))
!!!!    
!!!!    !c25_GetSecurityInfo(long handle, long objectType, long securityInfo, long ppsidOwner, long ppsidGroup, long, ppDacl, long ppSacl, long ppSecurityDescriptor), long,proc,name('GetSecurityInfo')
!!!!    !Clear(pSecurityDescriptor,-1)
!!!!    
!!!!    
!!!!    !DACL_SECURITY_INFORMATION
!!!!    !RetVal = c25_GetSecurityInfo(FileHandle, SE_OBJECT_TYPE:SE_FILE_OBJECT, Address(SECURITY_DESCRIPTOR), 0, 0, 0, 0, Address(pSecurityDescriptor))
!!!!    
!!!!    !RetVal = c25_GetSecurityInfo(FileHandle, SE_OBJECT_TYPE:SE_FILE_OBJECT, SECURITY_INFORMATION:DACL_SECURITY_INFORMATION, 0, 0, dacl, 0, secDescr)  !Address(pSecurityDescriptor))
!!!!    !Message('c25_GetSecurityInfo RetVal ' & RetVal & ', C25_GetLastError(): ' & C25_GetLastError())    
!!!!    
!!!!    C25_Closehandle(FileHandle)
!!!!    
!!!!    
!!!!    !Message('c25_GetSecurityInfo RetVal ' & RetVal & ', C25_GetLastError(): ' & C25_GetLastError() & ', lpnLengthNeeded: ' & lpnLengthNeeded)    
!!!!    
!!!!    
!!!!!!	
!!!!!SE_OBJECT_TYPE                          ITEMIZE
!!!!!SE_UNKNOWN_OBJECT_TYPE                      EQUATE
!!!!!SE_FILE_OBJECT                              EQUATE
!!!!!SE_SERVICE                                  EQUATE
!!!!!SE_PRINTER                                  EQUATE
!!!!!SE_REGISTRY_KEY                             EQUATE
!!!!!SE_LMSHARE                                  EQUATE
!!!!!SE_KERNEL_OBJECT                            EQUATE
!!!!!SE_WINDOW_OBJECT                            EQUATE
!!!!!SE_DS_OBJECT                                EQUATE
!!!!!SE_DS_OBJECT_ALL                            EQUATE
!!!!!SE_PROVIDER_DEFINED_OBJECT                  EQUATE
!!!!!SE_WMIGUID_OBJECT                           EQUATE
!!!!!SE_REGISTRY_WOW64_32KEY                     EQUATE
!!!!!SE_REGISTRY_WOW64_64KEY                     EQUATE
!!!!!                                        END
!!!!    
!!!!![Flags]
!!!!!public enum SECURITY_INFORMATION  {
!!!!!    OWNER_SECURITY_INFORMATION = 0x00000001,
!!!!!    GROUP_SECURITY_INFORMATION = 0x00000002,
!!!!!    DACL_SECURITY_INFORMATION = 0x00000004,
!!!!!    SACL_SECURITY_INFORMATION = 0x00000008,
!!!!!    UNPROTECTED_SACL_SECURITY_INFORMATION = 0x10000000,
!!!!!    UNPROTECTED_DACL_SECURITY_INFORMATION = 0x20000000,
!!!!!    PROTECTED_SACL_SECURITY_INFORMATION = 0x40000000
!!!!!    }
!!!!    
!!!!
!!!!!SECURITY_INFORMATION                        ITEMIZE
!!!!!OWNER_SECURITY_INFORMATION                      EQUATE(00000001h)
!!!!!GROUP_SECURITY_INFORMATION                      EQUATE(00000002h)
!!!!!DACL_SECURITY_INFORMATION                       EQUATE(00000004h)
!!!!!SACL_SECURITY_INFORMATION                       EQUATE(00000008h)
!!!!!UNPROTECTED_SACL_SECURITY_INFORMATION           EQUATE(010000000h)
!!!!!UNPROTECTED_DACL_SECURITY_INFORMATION           EQUATE(020000000h)
!!!!!PROTECTED_SACL_SECURITY_INFORMATION             EQUATE(040000000h)
!!!!!PROTECTED_DACL_SECURITY_INFORMATION             EQUATE(080000000h)
!!!!!                                            END
!!!!    
!!!!    
!!!!    !C25_SetLastError(0)
!!!!    !RetVal = c25_GetCurrentThreadToken()
!!!!    !Message('c25_GetCurrentThreadToken RetVal ' & RetVal & ', C25_GetLastError(): ' & C25_GetLastError() )    
!!!!    
!!!!!    C25_SetLastError(0)
!!!!!    RetVal = c25_GetKernelObjectSecurity(C25_GetCurrentThread(), Address(SECURITY_INFORMATION), 0, 0, Address(lpnLengthNeeded))
!!!!!    Message('c25_GetKernelObjectSecurity RetVal ' & RetVal & ', C25_GetLastError(): ' & C25_GetLastError() & ', lpnLengthNeeded: ' & lpnLengthNeeded)    
!!!!    
!!!!!    DesiredAccess = 0
!!!!!    SecInfo = SECURITY_INFORMATION:OWNER_SECURITY_INFORMATION
!!!!!    Clear(SecInfo,-1)
!!!!!    Message('try c25_SetSecurityAccessMask')
!!!!!    RetVal = c25_SetSecurityAccessMask(Address(SECURITY_DESCRIPTOR),Address(DesiredAccess))
!!!!!    Message('DesiredAccess ' & DesiredAccess)
!!!!    
!!!!    !c25_GetSecurityInfo
!!!!    !https://learn.microsoft.com/en-us/windows/win32/secauthz/finding-the-owner-of-a-file-object-in-c--
!!!!    
!!!!    
!!!!    
!!!!!!!    
!!!!!!!    
!!!!!!!    
!!!!!!!    
!!!!!!!    
!!!!!!!    
!!!!!!!   !hProcess = c25_OpenProcess(01F0FFFh , False, C25_GetCurrentProcessId() )
!!!!!!!   hProcess = c25_OpenProcess(PROCESS_ALL_ACCESS , True, C25_GetCurrentProcessId() )
!!!!!!!   !Message('hProcess ' & hProcess)
!!!!!!!    
!!!!!!!!    X# = c25_OpenThreadToken (c25_GetCurrentThread(), TOKEN_QUERY , False , Address(ThisToken))
!!!!!!!!    !X# = c25_OpenThreadToken(long ThreadHandle, long DesiredAccess, long OpenAsSelf, long TokenHandle)
!!!!!!!!    If X# = 0
!!!!!!!!        Message('error c25_OpenThreadToken, C25_GetLastError() : ' & C25_GetLastError())
!!!!!!!!    Else
!!!!!!!!        Message('OK c25_OpenThreadToken')
!!!!!!!!    End
!!!!!!!!    
!!!!!!!!    !H# = c25_GetCurrentThreadToken()
!!!!!!!!    M!essage('H# ' & H#)
!!!!!!!!    
!!!!!!!! access_token token;
!!!!!!!!            check_bool(WINRT_IMPL_OpenProcessToken(WINRT_IMPL_GetCurrentProcess(), 0x0002 /*TOKEN_DUPLICATE*/, token.put()));
!!!!!!!!            access_token duplicate;
!!!!!!!!            check_bool(WINRT_IMPL_DuplicateToken(token.get(), 2 /*SecurityImpersonation*/, duplicate.put()));
!!!!!!!!            return duplicate;
!!!!!!!
!!!!!!!!    C25_GetLastError
!!!!!!!    C25_SetLastError(0)
!!!!!!!    !Message('c25_GetCurrentProcess() ' & c25_GetCurrentProcess())
!!!!!!!!    
!!!!!!!    !X# = c25_OpenProcessToken(c25_GetCurrentProcess(),  TOKEN_ADJUST_PRIVILEGES + TOKEN_QUERY, Address(ThisToken)) !TOKEN_ALL_ACCESS, Address(ThisToken))
!!!!!!!    X# = c25_OpenProcessToken(hProcess,  TOKEN_ADJUST_PRIVILEGES, Address(ThisToken)) !TOKEN_ALL_ACCESS, Address(ThisToken))
!!!!!!!    If X# = 0
!!!!!!!        Message('error c25_OpenProcessToken, C25_GetLastError() : ' & C25_GetLastError())
!!!!!!!    Else
!!!!!!!        Message('OK c25_OpenProcessToken')
!!!!!!!    End
!!!!!!!    
!!!!!!!    Message('ThisToken ' & ThisToken)
!!!!!!!    
!!!!!!!    
!!!!!!!    
!!!!!!!    
!!!!!!!    
!!!!!!!    
!!!!!!!    
!!!!!!!    
!!!!!!!    
!!!!!!!    
!!!!!!!    
!!!!!!!    
!!!!!!!    
!!!!!!!    
!!!!!!!    
!!!!!!!    
!!!!!!!    
!!!!!!!!ven if your user account has a privilege, your process' token may have it
!!!!!!!!disabled.
!!!!!!!!you need to enable it from within the process.
!!!!!!!!the following apis in that order will help
!!!!!!!!LookupPrivilegeValue() -> GetCurrentProcessId() ->
!!!!!!!!OpenProcess() ->OpenProcessToken() ->AdjustTokenPrivileges() ->
!!!!!!!!PrivilegeCheck()
!!!!!!!    
!!!!!!!    
!!!!!!!!!    !Message('start c25_AWEClass.CreateVirtualQueue')
!!!!!!!!!
!!!!!!!!!!!    Self.BufferHeapPageSize     = 2^23
!!!!!!!!!!!    Self.BufferHeapMemAddress   = c25_VirtualAlloc2(0, 0, Self.BufferHeapPageSize, C25_MEM_COMMIT + C25_MEM_RESERVE, C25_PAGE_READWRITE, 0, 0)
!!!!!!!!!!!    
!!!!!!!!!!!    !Message('Self.BufferHeapMemAddress ' & Self.BufferHeapMemAddress)
!!!!!!!!!!!    
!!!!!!!!!!!    c25_VirtualLock(Self.BufferHeapMemAddress, Self.BufferHeapPageSize)
!!!!!!!!!!!    
!!!!!!!!!!!    
!!!!!!!!!!!    Self.LargePageMinimum = c25_GetLargePageMinimum()
!!!!!!!!!!!    
!!!!!!!!!!!    !Message('Self.LargePageMinimum ' & Self.LargePageMinimum)
!!!!!!!!!    !c25_LoggedSetLockPagesPrivilege (c25_GetCurrentProcess(),true)
!!!!!!!!!    !C25_Openprocess(Long Dwdesiredaccess,Byte Binherithandle,Long Dwprocessid)
!!!!!!!!!    
!!!!!!!!!    Message('dll c25_GetProcessId(-1) ' & c25_GetProcessId(-1))
!!!!!!!!!    
!!!!!!!!!    
!!!!!!!!!    hProcess = c25_OpenProcess(SYNCHRONIZE + PROCESS_QUERY_INFORMATION + PROCESS_VM_READ, FALSE, c25_GetProcessId(-1))
!!!!!!!!!    Message('dll hProcess ' & hProcess)
!!!!!!!!!    
!!!!!!!!!    X# = c25_OpenProcessToken (hProcess, TOKEN_ADJUST_PRIVILEGES + TOKEN_QUERY , Address(Token))
!!!!!!!!!    !Message(X#)
!!!!!!!!!    Message(C25_GetLastError())
!!!!!!!!!    Message('Token ' & Token)
!!!!!!!!!    
!!!!!!!!!    ! SYNCHRONIZE | PROCESS_QUERY_INFORMATION | PROCESS_VM_READ
!!!!!!!!!    
!!!!!!!!!    NumberOfPages = (1024*1024)/10
!!!!!!!!!    X# = c25_AllocateUserPhysicalPages(c25_GetCurrentProcess(), Address(NumberOfPages), Address(PageArray))
!!!!!!!!!    Message(X#)
!!!!!!!!!    Message('PageArray ' & PageArray)
!!!!!!!!!    Message('NumberOfPages ' & NumberOfPages)
!!!!!!!!!    
!!!!!!!!!    Message(C25_GetLastError())
!!!!!!!    
!!!!!!!    
!!!!!!!    Return 0
!!!!!!!    
!!!!!!!    
!!!!!!!    
!!!!!!!!    Self.LOG = True
!!!!!!!!
!!!!!!!!    !ResetBufferHeapQ() ! to be sure
!!!!!!!!    
!!!!!!!!    
!!!!!!!!    !c12_EmptyWorkingSet(c12_getcurrentprocess())
!!!!!!!!    Self.AddressByteVal = Address(Self.ByteVal)
!!!!!!!!	If Self.BufferHeapPageSize = 0
!!!!!!!!	    Self.BufferHeapPageSize = 2^23 ! can be significant larger, using demo purpose size
!!!!!!!!	End
!!!!!!!!	Self.BufferHeapFragmentsPerPage  = Self.BufferHeapPageSize / Self.BufferHeapRandomFragmentSize ! a fragment is always 64 bits, thus 8 bytes.
!!!!!!!!	Self.BufferHeapQRecords          = (Self.RequiredQueueEntries / Self.BufferHeapFragmentsPerPage) + 1       
!!!!!!!!    
!!!!!!!!	Self.TotalFragmentsAllocated 	= 0
!!!!!!!!	Self.FragmentsFrom   			= 1
!!!!!!!!	Self.FragmentsTill   			= 0
!!!!!!!!	Self.FragmentsTotal  			= 0
!!!!!!!!	Self.FragmentsTill 				= Self.FragmentsFrom + Self.BufferHeapFragmentsPerPage - 1
!!!!!!!!	Self.PageId 						= 0	
!!!!!!!!    
!!!!!!!!    Self.OverflowCount                   = 0
!!!!!!!!    Self.OverflowSignificantByteCount    = 0
!!!!!!!!    Self.OverflowEntireUINT64Count       = 0
!!!!!!!!    
!!!!!!!!    !LargePageMinimum = c12_GetLargePageMinimum()
!!!!!!!!    
!!!!!!!!L0	Loop !1 Times
!!!!!!!!		If Self.TotalFragmentsAllocated >= Self.RequiredQueueEntries
!!!!!!!!			BREAK
!!!!!!!!		End
!!!!!!!!		Self.PageId = Self.PageId + 1
!!!!!!!!        Self.BufferHeapMemAddress = 0
!!!!!!!!        Self.BufferHeapQ.MemAllocProvider     = 2
!!!!!!!!        Self.BufferHeapMemAddress              = c12_VirtualAlloc2(0, 0, Self.BufferHeapPageSize, C25_MEM_COMMIT + C25_MEM_RESERVE, C25_PAGE_READWRITE, 0, 0)
!!!!!!!!!        If BufferHeapMemAddress = 0
!!!!!!!!!            BufferHeapMemAddress              = c12_HeapAlloc(c12_GetProcessHeap(),HEAP_ZERO_MEMORY,BufferHeapPageSize)
!!!!!!!!!            BufferHeapQ.MemAllocProvider     = 1
!!!!!!!!!        End              
!!!!!!!!        c12_VirtualLock(Self.BufferHeapMemAddress, Self.BufferHeapPageSize)
!!!!!!!!        
!!!!!!!!		Self.BufferHeapQ.PageId 				= Self.PageId
!!!!!!!!		Self.BufferHeapQ.HeapMemAddress 		= Self.BufferHeapMemAddress
!!!!!!!!		Self.BufferHeapQ.BufferSize 			= Self.BufferHeapPageSize
!!!!!!!!		Self.BufferHeapQ.FragmentsFrom   	= Self.FragmentsFrom
!!!!!!!!		Self.BufferHeapQ.FragmentsTill   	= Self.FragmentsTill
!!!!!!!!        Self.BufferHeapQ.FragmentsTotal 		= Self.BufferHeapFragmentsPerPage
!!!!!!!!        !BufferHeapQ.RealBufferSize      = RealBufferSize#
!!!!!!!!
!!!!!!!!        Add(Self.BufferHeapQ)
!!!!!!!!        
!!!!!!!!		Self.TotalFragmentsAllocated 		= Self.TotalFragmentsAllocated + Self.BufferHeapFragmentsPerPage
!!!!!!!!		
!!!!!!!!		Self.FragmentsFrom					= Self.FragmentsFrom + Self.BufferHeapFragmentsPerPage
!!!!!!!!		Self.FragmentsTill 					= Self.FragmentsFrom + Self.BufferHeapFragmentsPerPage - 1
!!!!!!!!		
!!!!!!!!
!!!!!!!!		If GenerateRandomBuffer(Self.BufferHeapQ.HeapMemAddress, Self.BufferHeapQ.BufferSize) = -1
!!!!!!!!			Message('severe error GeneratingRandombuffer')
!!!!!!!!			BREAK
!!!!!!!!        End
!!!!!!!!        
!!!!!!!!        !--------------------------------------------------------------------------
!!!!!!!!        ! overwrite leading zero space
!!!!!!!!        !--------------------------------------------------------------------------
!!!!!!!!        Self.ZERO8               = All(Chr(0),8)
!!!!!!!!        Self.AddressZERO8        = Address(Self.ZERO8)
!!!!!!!!        Self.MaxHeapMemAddress   = Self.BufferHeapQ.HeapMemAddress + Self.BufferHeapQ.BufferSize-1
!!!!!!!!        
!!!!!!!!        Self.ZeroPaddingLen      = 8 - Self.HighMarkSigBytePos
!!!!!!!!        
!!!!!!!!        ! Position after the HighMarkSigBytePos, and pad zeroes.
!!!!!!!!        Self.AHighMarkSigBytePos = Self.BufferHeapQ.HeapMemAddress + Self.HighMarkSigBytePos
!!!!!!!!        Self.AHighMarkSigBytePos = Self.AHighMarkSigBytePos - 8
!!!!!!!!        Loop
!!!!!!!!            Self.AHighMarkSigBytePos = Self.AHighMarkSigBytePos + 8
!!!!!!!!            If Self.AHighMarkSigBytePos >= Self.MaxHeapMemAddress
!!!!!!!!                BREAK
!!!!!!!!            End
!!!!!!!!            c12_memcpy(Self.AHighMarkSigBytePos,Self.AddressZERO8,Self.ZeroPaddingLen)
!!!!!!!!        End
!!!!!!!!        !--------------------------------------------------------------------------
!!!!!!!!        
!!!!!!!!        
!!!!!!!!        !--------------------------------------------------------------------------
!!!!!!!!        ! ADJUST OVERFLOW
!!!!!!!!        ! check if randomize bytes are > HighMarkDec, if not,
!!!!!!!!        ! then adjust while remaining full random algorithms.   
!!!!!!!!        !
!!!!!!!!        ! use 1 byte comparision on the most signficant byte, to accelerate.
!!!!!!!!        ! if still the same, then reseed the entire 8 bytes minus zero padding
!!!!!!!!        ! and randomize the most significant byte =< as HighMarkSigByte
!!!!!!!!        !--------------------------------------------------------------------------
!!!!!!!!        
!!!!!!!!        Self.A                       = Self.BufferHeapQ.HeapMemAddress - 8        ! position start address of uint64 fragment
!!!!!!!!        Self.AHighMarkSigBytePos     = Self.A + Self.HighMarkSigBytePos - 1            ! position start address of uint64 fragments most significant byte
!!!!!!!!L1      Loop
!!!!!!!!            Self.A = Self.A + 8
!!!!!!!!            If Self.A >= Self.MaxHeapMemAddress
!!!!!!!!                BREAK
!!!!!!!!            End
!!!!!!!!            Self.AHighMarkSigBytePos = Self.AHighMarkSigBytePos + 8
!!!!!!!!            
!!!!!!!!            If LOG
!!!!!!!!!                c12_memcpy(AddressByteVal, AHighMarkSigBytePos, 1)
!!!!!!!!!                Message(ByteVal)
!!!!!!!!!                BREAK l0
!!!!!!!!            End
!!!!!!!!            
!!!!!!!!            If c12_memcmp(Self.AHighMarkSigBytePos,Self.AddressHighMarkSigByte,1) >= 0
!!!!!!!!                Self.OverflowSignificantByteCount = Self.OverflowSignificantByteCount + 1
!!!!!!!!                If LOG
!!!!!!!!                    !c12_memcpy(AddressByteVal, A, 1)
!!!!!!!!                    !Message('too large ' & ByteVal & ', PageId: ' & PageId & ', index: ' & (A - BufferHeapQ.HeapMemAddress) /8)
!!!!!!!!!                    BREAK L0
!!!!!!!!                End                
!!!!!!!!                Loop
!!!!!!!!                    Self.ByteVal = Random(0,Self.HighMarkSigByte) ! Try a new random value.
!!!!!!!!                    c12_memcpy(Self.AHighMarkSigBytePos, Self.AddressByteVal, 1)
!!!!!!!!                    If Self.ByteVal < Self.HighMarkSigByte
!!!!!!!!                        Break
!!!!!!!!                    End
!!!!!!!!                    i64ToDecimalByPtr(Self.Dec20, Self.A)
!!!!!!!!                    If Self.Dec20 < Self.HighMarkDec
!!!!!!!!                        BREAK
!!!!!!!!                    End
!!!!!!!!                    Self.CursorAddress = A -1 ! reseed
!!!!!!!!                    Self.Counter = 0
!!!!!!!!                    Loop Self.HighMarkSigBytePos Times
!!!!!!!!                        Self.CursorAddress = Self.CursorAddress + 1
!!!!!!!!                        Self.Counter = Self.Counter + 1
!!!!!!!!                        If Self.Counter = Self.HighMarkSigBytePos
!!!!!!!!                            Self.ByteVal = Random(0,Self.HighMarkSigByte)
!!!!!!!!                        Else
!!!!!!!!                            Self.ByteVal = Random(0,255)
!!!!!!!!                        End
!!!!!!!!                    End
!!!!!!!!                    Self.OverflowEntireUINT64Count = Self.OverflowEntireUINT64Count + 1
!!!!!!!!                    
!!!!!!!!                    i64ToDecimalByPtr(Self.Dec20, A)
!!!!!!!!                    
!!!!!!!!                    If Self.Dec20 > Self.HighMarkDec
!!!!!!!!                        CYCLE
!!!!!!!!                    End
!!!!!!!!                    Break
!!!!!!!!                End
!!!!!!!!            End
!!!!!!!!        End
!!!!!!!!
!!!!!!!!	End
!!!!!!!!    
!!!!!!!!    Self.BufferHeapQ.FragmentsTill   	= Self.RequiredQueueEntries
!!!!!!!!    Self.BufferHeapQ.FragmentsTotal 		= Self.BufferHeapQ.FragmentsTill - Self.BufferHeapQ.FragmentsFrom	 + 1
!!!!!!!!    Put(Self.BufferHeapQ)
!!!!!!!!	
!!!!!!!!    
!!!!!!!!    Self.TotalMem = 0
!!!!!!!!    I# = 0
!!!!!!!!    LOOP
!!!!!!!!        I# = I# + 1
!!!!!!!!        Get(Self.BufferHeapQ,I#)
!!!!!!!!        If Errorcode() <> 0
!!!!!!!!            BREAK
!!!!!!!!        End
!!!!!!!!        Self.TotalMem = Self.TotalMem + Self.BufferHeapQ.BufferSize
!!!!!!!!    END    
!!!!!!!    
