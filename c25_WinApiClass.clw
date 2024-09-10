                    Member

                    Include('c25_WinApiClass.inc'),Once

                    Map
                        Include('i64.inc')
                        Include('cwutil.inc'),Once
                        Include('c25_WinApiPrototypes.inc')
                    End

c25_WinApiClass.Construct                             Procedure()

    Code

        
        Self.BitConverterClass &= NEW c25_BitConverterClass()
        !Self.GetKnownFolders()
        
        
!        Self.ppsidOwnerADDRESS                       = Address(Self.ppsidOwner)
!        Self.ppsidGroupADDRESS                       = Address(Self.ppsidGroup)
!        Self.ppDaclADDRESS                           = Address(Self.ppDacl)
!        Self.ppSaclADDRESS                           = Address(Self.ppSacl)
!        Self.ppSecurityDescriptorADDRESS             = Address(Self.ppSecurityDescriptor)
!        

c25_WinApiClass.Destruct                              Procedure()

    Code
        
        
c25_WinApiClass.LockMemory     Procedure()


hToken                          Long
!SECURITY_ATTRIBUTES             Group
!nLength                             Long
!lpSecurityDescriptor                Long
!bInheritHandle                      BOOL
!                                End
!SECURITY_DESCRIPTOR             Group
!Revision                            byte
!Sbz1                                byte
!Control                             long
!Owner                               long
!Group                               long
!Sacl                                long
!Dacl                                Long
!                                End
!NewestToken                     long
!UserName                        cstring(255)
!DomainName                      cstring(255)
!Pw                              cstring(255)
!dupToken                        Long
!processId                       Long
!process                         Long
!TokenInfoOut                    long
!TokenInfoOutString              string(10000)
!TokenInfoOutRequired            long
!SID                             Group,Pre(SID)
!Revision                            Byte
!SubAuthorityCount                   Byte
!Buffer                              String(65000)
!                                End
!SID_IDENTIFIER_AUTHORITY        String(6)
!
!!LUID                                    STRING(16000)
!!priv                                    cstring(1024)
!
!st                                      &StringTheory()
!TestString                              string(1024)
!AWEPage                                 &String

CODE
        
    !return 0
    
    !st &= NEW StringTheory()

    Clear(Self.LSA_OBJECT_ATTRIBUTES)
    Self.LSA_OBJECT_ATTRIBUTES.Length = Size(Self.LSA_OBJECT_ATTRIBUTES)

    Self.ReturnVal = C25_LsaOpenPolicy(0, Address(Self.LSA_OBJECT_ATTRIBUTES), POLICY_ALL_ACCESS, Address(Self.PolicyHandle))

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

    !Self.ReturnVal = C25_LookupAccountSidA(0, Address(Self.SidA), Address(Self.SidAccountNameA), 


!    st.Start()
!    st.Append(Self.SidAString)
!    st.SaveFile('m:\sid.txt')
    !Message(Size(Self.PrivNameUtf16))
    
    Self.LSA_UNICODE_STRING.Length = Size(Self.PrivNameUtf16)-2

    Self.LSA_UNICODE_STRING.MaximumLength = Self.LSA_UNICODE_STRING.Length + 2
    Self.LSA_UNICODE_STRING.BufferPtr = Address(Self.PrivNameUtf16)

    Self.ReturnVal = C25_LsaAddAccountRights(Self.PolicyHandle, Address(Self.SidA), Address(Self.LSA_UNICODE_STRING), 1)

    Self.PrivilegeName = SE_LOCK_MEMORY_NAME
    Self.PrivilegeName = SE_SHUTDOWN_NAME
    Self.PrivilegeName = 'SeLockMemoryPrivilege' & Chr(0) !SE_LOCK_MEMORY_NAME
    Clear(Self.LUID,-1)

    B# = C25_LookupPrivilegeValueA(0, Address(Self.PrivilegeName), Address(Self.LUID))

    Clear(Self.TOKEN_PRIVILEGES,-1)

    Self.ReturnVal = c25_OpenProcessToken(-1, TOKEN_QUERY + TOKEN_DUPLICATE + TOKEN_IMPERSONATE + TOKEN_ASSIGN_PRIMARY + TOKEN_ADJUST_PRIVILEGES, Address(hToken))

    Self.TOKEN_PRIVILEGES.PrivilegeCount = 1
    Self.TOKEN_PRIVILEGES.Privileges[1].PrivLUIDS = Self.LUID
    Self.TOKEN_PRIVILEGES.Privileges[1].PrivATTRS = 2
    Self.ReturnVal = c25_AdjustTokenPrivileges(hToken, false, Address(Self.TOKEN_PRIVILEGES), Size(Self.TOKEN_PRIVILEGES), 0, 0)
    
    !Message('in winapi Self.ReturnVal ' & Self.ReturnVal)
    
    Self.ReturnVal = C25_LsaEnumerateAccountRights(Self.PolicyHandle, Address(Self.SidA), Address(Self.UserRightsPtr), Address(Self.CountOfRightsPtr))
    

    Clear(Self.LSA_UNICODE_STRING)

    C25_Memcpy(Address(Self.LSA_UNICODE_STRING),Self.UserRightsPtr, 8)
    !Self.UserRightsPtr
    !Message(Self.ReturnVal & ' Self.UserRightsPtr: ' & Self.UserRightsPtr & ' , ' & Self.CountOfRightsPtr)

!    Message('Self.LSA_UNICODE_STRING.Length : ' & Self.LSA_UNICODE_STRING.Length)
!    Message('Self.LSA_UNICODE_STRING.MaximumLength : ' & Self.LSA_UNICODE_STRING.MaximumLength)
!    Message('Self.LSA_UNICODE_STRING.BufferPtr : ' & Self.LSA_UNICODE_STRING.BufferPtr)

    If Self.LSA_UNICODE_STRING.Length > 0 And Self.LSA_UNICODE_STRING.BufferPtr <> 0
        Self.BufferW &= NEW STRING(Self.LSA_UNICODE_STRING.Length)
        C25_Memcpy(Address(Self.BufferW), Self.LSA_UNICODE_STRING.BufferPtr, Self.LSA_UNICODE_STRING.Length)
        Self.BufferA &= Self.BitConverterClass.Utf16ToAnsi(Self.BufferW)
        !Message(Self.BufferA)
    End
    !C25_LookupAccountSidA(long lpSystemName, long Sid, long _Name, long cchName, long ReferencedDomainName, long cchReferencedDomainName, long peUse),long,proc,pascal,Name('LookupAccountSidA')

    Self.SidAccountNameASize = Size(Self.SidAccountNameA)
    Self.SidReferencedDomainNameASize = Size(Self.SidReferencedDomainNameA)
    Self.peUse = 1

    Self.ReturnVal = C25_LookupAccountSidA(0,  Address(Self.SidA), Address(Self.SidAccountNameA), Address(Self.SidAccountNameASize),Address(Self.SidReferencedDomainNameA), Address(Self.SidReferencedDomainNameASize), Address(Self.peUse))

        
    return 0

        
        
        
        
        
        
        
        
        
        
        
!
!    Clear(Self.SystemInfo)
!    
!    C25_GetSystemInfo(Address(Self.SystemInfo))
!    !Message('SystemInfo.AllocationGranularity ' & Self.SystemInfo.AllocationGranularity)
!    
!!    Self.MappedFileHdr.Size                             = Size(Self.MappedFileHdr)
!!    Self.MappedFileHdr.AllocGranularity                 = SystemInfo.AllocationGranularity
!!    Self.MappedFileHdr.PageSize                         = Self.MappedFileHdr.AllocGranularity
!    
!    
!    Self.AllocationGranularityDec = Self.SystemInfo.AllocationGranularity
!    Self.AllocationGranularity = Self.SystemInfo.AllocationGranularity
!    !Message('Self.AllocationGranularityDec ' & Self.AllocationGranularityDec)
!    
!    !SETCLIPBOARD(Self.SystemInfo.AllocationGranularity)
!    !65536
!    
!    !Self.AWERequestMemoryDec = 2^24 !12884901888
!    !SETCLIPBOARD(format(Self.AWERequestMemoryDec,@N021))
!    
!    Self.SizeLargePages = c25_GetLargePageMinimum()
!    Self.SizeLargePagesDec = Self.SizeLargePages
!    !SETCLIPBOARD(Self.SizeLargePages)
!    !
!    !i64FromDecimal(Self.AWERequestMemory, Self.AWERequestMemoryDec)
!    !Self.MemReservedSize = 536870912 / 4
!    !Message(Self.AWERequestMemoryDec)
!    !Self.AWERequestMemory = 536870912
!    Self.AWERequestMemoryDec = 12884901888 !536870912 * 8
!    !Self.AWEPages = Self.AWERequestMemoryDec / Self.SizeLargePagesDec !Self.AllocationGranularityDec
!    Self.AWEPagesDec = Self.AWERequestMemoryDec /Self.AllocationGranularityDec
!    !Message('Self.AWEPages ' & Self.AWEPagesDec)
!    
!    Self.AWEPages = Self.AWEPagesDec
!    !Message('Self.AWEPagesDec ' & Self.AWEPagesDec)
!    
!   ! Self.AWERequestMemoryDec = Self.AWEPagesDec * Self.SizeLargePagesDec
!    !Self.AWERequestMemoryDec = Self.AWEPagesDec * Self.AllocationGranularityDec
!    Self.AWERequestMemoryDec = Self.AWEPagesDec * Self.AllocationGranularityDec
!    
!    !Self.MemReservedSize = Self.AWERequestMemoryDec
!    !Message('Self.AWEPagesDec ' & Self.AWEPagesDec)
!    !Message('Self.AWERequestMemoryDec ' & Self.AWERequestMemoryDec)
!    !Message('AWERequestMemoryDec: ' & format(Self.AWERequestMemoryDec,@N21))
!    
!    !SETCLIPBOARD(format(Self.AWERequestMemoryDec,@N021))
!    !Message('Self.AWEPages ' & Self.AWEPages)
!    
!    !largepage = 2^21
!    !Self.AWEPages = Self.AllocationGranularityDec / Self.SystemInfo.AllocationGranularity
!    
!!    
!!    
!
!    
!    !Message('Self.PFNArray ' & Self.PFNArray)
!    
!    !Self.SizeLargePages = c25_GetLargePageMinimum()
!    !Message('Self.SizeLargePages ' & Self.SizeLargePages)
!    
!
!    
!    !Message('Self.AWEPages ' & Self.AWEPages)
!    
!    !Self.MemReservedSize = 2^31-1
!    !Self.MemReservedSize = 268435456 !Self.SizeLargePages  * 10 !2^28
!    !Self.MemReservedSize = 268435456
!    !Self.MemReservedSize = 536870912 / 2 !268435456
!    !Message('Self.MemReservedSize ' & Self.MemReservedSize)
!    ! size / 2097152 = 128 pages
!    !Self.MemReserved = c25_VirtualAlloc( 0, Self.MemReservedSize, c25_MEM_RESERVE + c25_MEM_PHYSICAL + C25_MEM_LARGE_PAGES, c25_PAGE_READWRITE) ! + C25_MEM_LARGE_PAGES )
!    
!        
!    Self.VirtualSwapSize = 536870912
!    
!    Self.VirtualSwapMaxPages = Self.VirtualSwapSize / Self.AllocationGranularity
!    !Message('Self.VirtualSwapMaxPages ' & Self.VirtualSwapMaxPages)
!    
!        
!        
!    Self.PFNArraySize   =  (Self.AWEPages * 8) !* 2
!
!    !Self.PFNArray = c25_HeapAlloc(c25_GetProcessHeap(), C25_HEAP_ZERO_MEMORY, Self.PFNArraySize)
!    
!    Self.PFNArray = c25_VirtualAlloc( 0, Self.PFNArraySize, c25_MEM_RESERVE + c25_MEM_COMMIT , c25_PAGE_READWRITE)
!    
!    Message('Self.PFNArray[I#] ' & Self.PFNArray)
!    
!    !B# = c25_AllocateUserPhysicalPages(c25_GetCurrentProcess(), Address(Self.AWEPages), Self.PFNArray[I#])
!    !Message('Self.AWEPages in ' & Self.PFNArray[I#])
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
!    Self.AWEPage &= NEW STRING(Self.AllocationGranularity)
!    AWEPage &= NEW STRING(Self.AllocationGranularity)
!        
!    P# = 0
!    Loop Size(Self.AWEPage) TIMES
!        P# = P# + 1
!        Self.AWEPage[P#] = Chr(Random(0,255))
!    End
!    AWEPage = Self.AWEPage
!        
!    Message('start')
!    
!        
!    I# = Self.AllocationGranularity * -1
!    L# = Val('A') - 1
!    
!    Loop 1 Times !Self.AWEPages-1 Times
!        I# = I# + Self.AllocationGranularity
!        
!        !Self.NumberOfPagesAlloc = Self.AWEPages
!        
!        !VirtualFree 
!!        Pge# = 0
!!        Loop Self.AWEPages Times
!!            Pge# = Pge# + 1
!        
!        
!!        Self.NumberOfPagesAlloc = Self.AWEPages
!!        bResult# = c25_MapUserPhysicalPagesScatter( Self.MemReserved[I#], Self.NumberOfPagesAlloc, Self.PFNArray[I#])   
!!        If bResult# = 0
!!            Message(I# & ', error c25_MapUserPhysicalPages at ' & C25_GetLastError() )
!!            BREAK
!!        End
!!        bResult# = c25_MapUserPhysicalPagesScatter( Self.MemReserved[I#], Self.NumberOfPagesAlloc, 0)   
!!        
!!        !TestString = All(Chr(L#),Size(TestString))
!!        TestString = All(Chr(L#),4)
!!        
!!        P# = -4
!!        T# = (Self.MemReservedSize / 4)
!!        !Message(T#)
!!        T# = T# - 2
!!        Loop T# Times
!!            P# = P# + 4
!!            !C25_Memcpy(Self.MemReserved[I#] + P#, Address(TestString), 4)
!!            !break
!!        End        
!        !Self.VirtualSwapMaxPages
!        
!        Self.NumberOfPagesAlloc = Self.VirtualSwapSize / Self.AllocationGranularity
!        !Message('Self.NumberOfPagesAlloc ' & Self.NumberOfPagesAlloc)
!        
!        bResult# = c25_MapUserPhysicalPages( Self.MemReserved, Self.NumberOfPagesAlloc, Self.PFNArray)   
!        If bResult# = 0
!            Message(I# & ', error c25_MapUserPhysicalPages at ' & C25_GetLastError() )
!            BREAK
!        Else
!            Message('c25_MapUserPhysicalPages ok')
!        END
!        
!        !Message(Self.VirtualSwapSize & ', ' & Size(Self.AWEPage) & ', ' & Self.AllocationGranularity)
!        !40960
!        !S# = 40960
!        !54827
!        Offset# = Self.AllocationGranularity * -1
!        LOOP 510 Times !Self.NumberOfPagesAlloc Times
!            Offset# = Offset# + Self.AllocationGranularity
!            !SETCLIPBOARD(Offset#)
!            C25_Memcpy(Self.MemReserved + Offset#, Address(Self.AWEPage), Size(Self.AWEPage)) !Self.AllocationGranularity)
!            !33488896
!        End
!       ! 17515
!        !Message('dat wel')
!        
!        !bResult# = c25_MapUserPhysicalPages( Self.MemReserved + Offset#, Self.NumberOfPagesAlloc, 0)   
!        
!        
!!        END
!!        
!!        L# = L# + 1
!!        !TestString = All(Chr(L#),Size(TestString))
!!        TestString = All(Chr(L#),4)
!!        
!!        P# = -4
!!        T# = (Self.MemReservedSize / 4)
!!        !Message(T#)
!!        T# = T# - 2
!!        Loop T# Times
!!            P# = P# + 4
!!            !C25_Memcpy(Self.MemReserved[I#] + P#, Address(TestString), 4)
!!            !break
!!        End
!        !BREAK
!        
!    End
!    Message('ok')
!    
!    !Message('Self.MemReserved ' & Self.MemReserved)
!    !X# = Self.MemReservedSize / Self.AllocationGranularityDec
!    
!    !C25_Memcpy(Address(TestString), Self.MemReserved[3], Size(TestString))
!    
!    !Message(TestString[1 : 10])
!    
!    !Message('bResult# :' & bResult#)
!    
!    !Loop
!    !Message(X#)
!        !Self.NumberOfPagesAlloc = Self.NumberOfPagesAlloc + 1
!!        bResult# = c25_MapUserPhysicalPages( Self.MemReserved + (Self.SizeLargePages * 1), Self.NumberOfPagesAlloc, Self.PFNArray)
!!        If bResult# = 0
!!            !BREAK
!!        End
!!        c25_MapUserPhysicalPages( Self.MemReserved, Self.NumberOfPagesAlloc, 0)
!     
!    !End
!    
!    
!    !bResult# = c25_MapUserPhysicalPages( Self.MemReserved, Address(Self.NumberOfPagesAlloc), Self.PFNArray)
!    
!    !Message(Self.NumberOfPagesAlloc & ', bResult# ' & bResult#)
!    
!    
!    !Message('Self.MemReserved ' & Self.MemReserved)
!    
!    !Message('Self.PFNArray ' & Self.PFNArray)
!    
!    
!    
!!            BufferHeapQ.MemAllocProvider     = 1
!
!
!    !Message('Self.ReturnVal adjust ' & Self.ReturnVal & ', ' & Self.SidAccountNameA & ', ' & Self.SidAccountNameASize & ', ' & Self.peUse)
!
!
!    
!
!    Dispose(st)
!
!    Return ''

    
    
!Add-Type @'
!using System;
!using System.Collections.Generic;
!using System.Text;
!
!namespace MyLsaWrapper
!{
!    using System.Runtime.InteropServices;
!    using System.Security;
!    using System.Management;
!    using System.Runtime.CompilerServices;
!    using System.ComponentModel;
!
!    using LSA_HANDLE = IntPtr;
!
!    [StructLayout(LayoutKind.Sequential)]
!    struct LSA_OBJECT_ATTRIBUTES
!    {
!        internal int Length;
!        internal IntPtr RootDirectory;
!        internal IntPtr ObjectName;
!        internal int Attributes;
!        internal IntPtr SecurityDescriptor;
!        internal IntPtr SecurityQualityOfService;
!    }
!    [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
!    struct LSA_UNICODE_STRING
!    {
!        internal ushort Length;
!        internal ushort MaximumLength;
!        [MarshalAs(UnmanagedType.LPWStr)]
!        internal string Buffer;
!    }
!    sealed class Win32Sec
!    {
!        [DllImport("advapi32", CharSet = CharSet.Unicode, SetLastError = true),
!        SuppressUnmanagedCodeSecurityAttribute]
!        internal static extern uint LsaOpenPolicy(
!        LSA_UNICODE_STRING[] SystemName,
!        ref LSA_OBJECT_ATTRIBUTES ObjectAttributes,
!        int AccessMask,
!        out IntPtr PolicyHandle
!        );
!
!        [DllImport("advapi32", CharSet = CharSet.Unicode, SetLastError = true),
!        SuppressUnmanagedCodeSecurityAttribute]
!        internal static extern uint LsaAddAccountRights(
!        LSA_HANDLE PolicyHandle,
!        IntPtr pSID,
!        LSA_UNICODE_STRING[] UserRights,
!        int CountOfRights
!        );
!
!        [DllImport("advapi32", CharSet = CharSet.Unicode, SetLastError = true),
!        SuppressUnmanagedCodeSecurityAttribute]
!        internal static extern int LsaLookupNames2(
!        LSA_HANDLE PolicyHandle,
!        uint Flags,
!        uint Count,
!        LSA_UNICODE_STRING[] Names,
!        ref IntPtr ReferencedDomains,
!        ref IntPtr Sids
!        );
!
!        [DllImport("advapi32")]
!        internal static extern int LsaNtStatusToWinError(int NTSTATUS);
!
!        [DllImport("advapi32")]
!        internal static extern int LsaClose(IntPtr PolicyHandle);
!
!        [DllImport("advapi32")]
!        internal static extern int LsaFreeMemory(IntPtr Buffer);
!
!    }
!    /// <summary>
!    /// This class is used to grant "Log on as a service", "Log on as a batchjob", "Log on localy" etc.
!    /// to a user.
!    /// </summary>
!    public sealed class LsaWrapper : IDisposable
!    {
!        [StructLayout(LayoutKind.Sequential)]
!        struct LSA_TRUST_INFORMATION
!        {
!            internal LSA_UNICODE_STRING Name;
!            internal IntPtr Sid;
!        }
!        [StructLayout(LayoutKind.Sequential)]
!        struct LSA_TRANSLATED_SID2
!        {
!            internal SidNameUse Use;
!            internal IntPtr Sid;
!            internal int DomainIndex;
!            uint Flags;
!        }
!
!        [StructLayout(LayoutKind.Sequential)]
!        struct LSA_REFERENCED_DOMAIN_LIST
!        {
!            internal uint Entries;
!            internal LSA_TRUST_INFORMATION Domains;
!        }
!
!        enum SidNameUse : int
!        {
!            User = 1,
!            Group = 2,
!            Domain = 3,
!            Alias = 4,
!            KnownGroup = 5,
!            DeletedAccount = 6,
!            Invalid = 7,
!            Unknown = 8,
!            Computer = 9
!        }
!        
!        enum Access : int
!        {
!            POLICY_READ = 0x20006,
!            POLICY_ALL_ACCESS = 0x00F0FFF,
!            POLICY_EXECUTE = 0X20801,
!            POLICY_WRITE = 0X207F8
!        }
!        const uint STATUS_ACCESS_DENIED = 0xc0000022;
!        const uint STATUS_INSUFFICIENT_RESOURCES = 0xc000009a;
!        const uint STATUS_NO_MEMORY = 0xc0000017;
!
!        IntPtr lsaHandle;
!
!        public LsaWrapper()
!            : this(null)
!        { }
!        // // local system if systemName is null
!        public LsaWrapper(string systemName)
!        {
!            LSA_OBJECT_ATTRIBUTES lsaAttr;
!            lsaAttr.RootDirectory = IntPtr.Zero;
!            lsaAttr.ObjectName = IntPtr.Zero;
!            lsaAttr.Attributes = 0;
!            lsaAttr.SecurityDescriptor = IntPtr.Zero;
!            lsaAttr.SecurityQualityOfService = IntPtr.Zero;
!            lsaAttr.Length = Marshal.SizeOf(typeof(LSA_OBJECT_ATTRIBUTES));
!            lsaHandle = IntPtr.Zero;
!            LSA_UNICODE_STRING[] system = null;
!            if (systemName != null)
!            {
!                system = new LSA_UNICODE_STRING[1];
!                system[0] = InitLsaString(systemName);
!            }
!
!            uint ret = Win32Sec.LsaOpenPolicy(system, ref lsaAttr,
!            (int)Access.POLICY_ALL_ACCESS, out lsaHandle);
!            if (ret == 0)
!                return;
!            if (ret == STATUS_ACCESS_DENIED)
!            {
!                throw new UnauthorizedAccessException();
!            }
!            if ((ret == STATUS_INSUFFICIENT_RESOURCES) || (ret == STATUS_NO_MEMORY))
!            {
!                throw new OutOfMemoryException();
!            }
!            throw new Win32Exception(Win32Sec.LsaNtStatusToWinError((int)ret));
!        }
!
!        public void AddPrivileges(string account, string privilege)
!        {
!            IntPtr pSid = GetSIDInformation(account);
!            LSA_UNICODE_STRING[] privileges = new LSA_UNICODE_STRING[1];
!            privileges[0] = InitLsaString(privilege);
!            uint ret = Win32Sec.LsaAddAccountRights(lsaHandle, pSid, privileges, 1);
!            if (ret == 0)
!                return;
!            if (ret == STATUS_ACCESS_DENIED)
!            {
!                throw new UnauthorizedAccessException();
!            }
!            if ((ret == STATUS_INSUFFICIENT_RESOURCES) || (ret == STATUS_NO_MEMORY))
!            {
!                throw new OutOfMemoryException();
!            }
!            throw new Win32Exception(Win32Sec.LsaNtStatusToWinError((int)ret));
!        }
!
!        public void Dispose()
!        {
!            if (lsaHandle != IntPtr.Zero)
!            {
!                Win32Sec.LsaClose(lsaHandle);
!                lsaHandle = IntPtr.Zero;
!            }
!            GC.SuppressFinalize(this);
!        }
!        ~LsaWrapper()
!        {
!            Dispose();
!        }
!        // helper functions
!
!        IntPtr GetSIDInformation(string account)
!        {
!            LSA_UNICODE_STRING[] names = new LSA_UNICODE_STRING[1];
!            LSA_TRANSLATED_SID2 lts;
!            IntPtr tsids = IntPtr.Zero;
!            IntPtr tdom = IntPtr.Zero;
!            names[0] = InitLsaString(account);
!            lts.Sid = IntPtr.Zero;
!            Console.WriteLine("String account: {0}", names[0].Length);
!            int ret = Win32Sec.LsaLookupNames2(lsaHandle, 0, 1, names, ref tdom, ref tsids);
!            if (ret != 0)
!                throw new Win32Exception(Win32Sec.LsaNtStatusToWinError(ret));
!            lts = (LSA_TRANSLATED_SID2)Marshal.PtrToStructure(tsids,
!            typeof(LSA_TRANSLATED_SID2));
!            Win32Sec.LsaFreeMemory(tsids);
!            Win32Sec.LsaFreeMemory(tdom);
!            return lts.Sid;
!        }
!
!        static LSA_UNICODE_STRING InitLsaString(string s)
!        {
!            // Unicode strings max. 32KB
!            if (s.Length > 0x7ffe)
!                throw new ArgumentException("String too long");
!            LSA_UNICODE_STRING lus = new LSA_UNICODE_STRING();
!            lus.Buffer = s;
!            lus.Length = (ushort)(s.Length * sizeof(char));
!            lus.MaximumLength = (ushort)(lus.Length + sizeof(char));
!            return lus;
!        }
!    }
!    public class LsaWrapperCaller
!    {
!        public static void AddPrivileges(string account, string privilege)
!        {
!            using (LsaWrapper lsaWrapper = new LsaWrapper())
!            {
!                lsaWrapper.AddPrivileges(account, privilege);
!            }
!        }
!    }
!}
!'@    
        
c25_WinApiClass.GetCurrentProcess                     Procedure()

    Code

        Return c25_GetCurrentProcess()
        
        
        
c25_WinApiClass.RemoveFileUtf16                       Procedure(String _fileName, <Byte _messageBoxIfError>)

FileNameUtf16  String(4096)

    Code

        FileNameUtf16 = Clip(_fileName) & Chr(0) & Chr(0)

        R# = c25_DeleteFileW(Address(FileNameUtf16))
        If R# = 0
            If _messageBoxIfError = True
                Message('failed to delete: ' & Self.BitConverterClass.Utf16ToAnsi(FileNameUtf16))
            End
        End
        
        Return R#
        
c25_WinApiClass.GetProcessHandle                      Procedure()

SourceProcessHandle                      Long
GlobalProcessHandle                      Long

    Code

        !SourceProcessHandle = C25_OpenProcess(PROCESS_DUP_HANDLE + , FALSE, c25_GetCurrentProcessId())
        SourceProcessHandle = C25_OpenProcess(PROCESS_ALL_ACCESS, FALSE, c25_GetCurrentProcessId())
         
        !Message('proc: ' & SourceProcessHandle)
        
        !c25_DuplicateHandle(SourceProcessHandle, Self.GetCurrentProcess(), Self.GetCurrentProcess(), Address(GlobalProcessHandle), 0, False, 2)
        
        
        c25_DuplicateHandle(SourceProcessHandle, Self.GetCurrentProcess(), Self.GetCurrentProcess(), Address(GlobalProcessHandle), 0, FALSE, 0) !DUPLICATE_SAME_ACCESS);
        !Message('GlobalProcessHandle ' & GlobalProcessHandle)
        
        !c25_CloseHandle(SourceProcessHandle)
        Return GlobalProcessHandle



!!!        Self.NanoClock               &= NEW NanoSyncClass()
!!!        Self.GlobalMem          &= null
!!!        Self.ReturnString       &= NULL
!!!        Self.ReflectionCapesoft &= NEW ReflectClass()
!!!        Self.CRLF = Chr(13) & Chr(10)
!!!        Self.st1 &= NEW StringTheory()
!!!        Self.st2 &= NEW StringTheory()
!!!        Self.StAnsi &= New StringTheory()
!!!        Self.StAnsiToAnsi &= NEW StringTheory()
!!!        Self.StAnsiToUtf16 &= New StringTheory()
!!!        Self.StAnsiToUtf8 &= New StringTheory()
!!!        Self.StUtf16 &= New StringTheory()
!!!        Self.StUtf16ToAnsi &= New StringTheory()
!!!        Self.StUtf16ToUtf16 &= NEW StringTheory()
!!!        Self.StUtf16ToUtf8 &= NEW StringTheory()
!!!        Self.StUtf32 &= New StringTheory()
!!!        Self.StUtf8 &= New StringTheory()
!!!        Self.StUtf8ToAnsi &= New StringTheory()
!!!        Self.StUtf8ToUtf8 &= NEW StringTheory()
!!!        
!!!        Self.st1.Start()
!!!        Self.st2.Start()
!!!        Self.StAnsi.Start()
!!!        Self.StAnsiToAnsi.Start()
!!!        Self.StAnsiToUtf16.Start()
!!!        Self.StAnsiToUtf8.Start()
!!!        Self.StUtf16.Start()
!!!        Self.StUtf16ToAnsi.Start()
!!!        Self.StUtf16ToUtf16.Start()
!!!        Self.StUtf16ToUtf8.Start()
!!!        Self.StUtf32.Start()
!!!        Self.StUtf8.Start()
!!!        Self.StUtf8ToAnsi.Start()
!!!        Self.StUtf8ToUtf8.Start()
!!!
!!!        Self.hKeyDefault        = 080000002h !WE::WM_HKEY_CURRENT_USER
!!!        Self.SubKeyPathDefault &= Self.BitConverterClass.BinaryCopy('Software\AllMyDrives.com\')
!!!
!!!        Self.ClaFileQ &= NEW ClaFile_TYPE()
!!!        Self.FolderToScanQ &= NEW FolderToScan_TYPE()
!!!        Self.OddJob &= NEW JobObject()
!!!        Self.WindowInfoQ &= NEW WindowInfo_TYPE()
!!!        Clear(Self.WindowInfoQ)
!!!        Add(Self.WindowInfoQ)
!!!        Self.WindowsInfoQ &= NULL
!!!        Self.DummyStringRef &= NULL
!!!        Self.GetKnownFolders()
!!!        Self.FormatMessageAnsi &= NULL
!!!        Self.PathPrependAnsi   = '\\?\'
!!!        Self.PathPrependUtf16  &= Self.BitConverterClass.AnsiToUtf16(Self.PathPrependAnsi)
!!!        Self.json1 &= NEW JSONClass()
!!!        Self.InitGlobalMem()
!!
!!        
!!c25_WinApiClass.PostLogLine   Procedure(String _logLine)
!!
!!    Code
!!        
!!        !Message('START c25_WinApiClass.PostLogLine')
!!        If Self.LogClientWinHandle = 0
!!            Self.LogClientWinHandle = Self.GetGlobalDictionaryValue('LogClientWinHandle')
!!            !Message('START c25_WinApiClass.PostLogLine LogClientWinHandle = : ' & Self.LogClientWinHandle)
!!        End
!!        If Self.LogClientWinHandle = 0
!!            Return 0
!!        End
!!        
!!        !Message('START c25_WinApiClass.PostLogLine, c25_PostMessageA')
!!        R# = c25_PostMessageA(Self.LogClientWinHandle, c25:LogLine, 0, Self.StringToStringRefPtr('Hello PostLogLine'))
!!        
!!        !Message('End c25_WinApiClass.PostLogLine')
!!        Return 0
!!
!!        
!!c25_WinApiClass.ArmCloseWindow        Procedure(<Long _startPhaseId>)
!!
!!
!!    Code
!!        
!!        If _startPhaseId = -1
!!            Self.ArmCloseWindowPhaseId = 0
!!            If not Self.ArmCloseWindowNanoSync &= NULL
!!                Dispose(Self.ArmCloseWindowNanoSync)
!!            End
!!        Else
!!            If _startPhaseId = 0 or omitted(_startPhaseId) = True
!!                Self.ArmCloseWindowPhaseId = 1
!!            Else
!!                Self.ArmCloseWindowPhaseId = _startPhaseId
!!            End
!!            If not Self.ArmCloseWindowNanoSync &= NULL
!!                Dispose(Self.ArmCloseWindowNanoSync)
!!            End
!!            Self.ArmCloseWindowNanoSync &= NEW NanoSyncClass()
!!            Case Self.ArmCloseWindowPhaseId
!!            Of 1
!!                Self.ArmCloseWindowNanoSync.SetTimeOut(0,0,0,0,'PostCloseWindow')
!!            Of 2
!!                Self.ArmCloseWindowNanoSync.SetTimeOut(0,0,0,0,'ExitThread')
!!            Of 3
!!                Self.ArmCloseWindowNanoSync.SetTimeOut(0,0,0,0,'TerminateThread')
!!            Of 4
!!                Self.ArmCloseWindowNanoSync.SetTimeOut(0,0,0,0,'ExitProcess')
!!            Of 5
!!                Self.ArmCloseWindowNanoSync.SetTimeOut(0,0,0,0,'ExitProcess')                
!!            End
!!            
!!        End
!!        
!!        Return 0
!!        
!!c25_WinApiClass.CheckArmCloseWindow                     Procedure()
!!
!!
!!    Code
!!        
!!        If Self.ArmCloseWindowPhaseId = 0
!!            Return 0
!!        End
!!        If Self.ArmCloseWindowNanoSync &= NULL
!!            Return 0
!!        End
!!        
!!        If Self.ArmCloseWindowNanoSync.IsTimeOut('PostCloseWindow',True)
!!            Self.ArmCloseWindowNanoSync.SetTimeOut(0,0,3,0,'ExitThread')
!!            Post(EVENT:CloseWindow)
!!        End
!!        If Self.ArmCloseWindowNanoSync.IsTimeOut('ExitThread',True)
!!            Self.ArmCloseWindowNanoSync.SetTimeOut(0,0,3,0,'TerminateThread')
!!            c25_ExitThread(0)
!!        End
!!        If Self.ArmCloseWindowNanoSync.IsTimeOut('TerminateThread',True)
!!            Self.ArmCloseWindowNanoSync.SetTimeOut(0,0,3,0,'ExitProcess')
!!            c25_TerminateThread(c25_GetCurrentThread(),0 )
!!        End
!!        If Self.ArmCloseWindowNanoSync.IsTimeOut('ExitProcess',True)
!!            Self.ArmCloseWindowNanoSync.SetTimeOut(0,0,3,0,'TerminateProcess')
!!            c25_ExitProcess(0)
!!        End     
!!        If Self.ArmCloseWindowNanoSync.IsTimeOut('TerminateProcess',True)
!!            !Self.ArmCloseWindowNanoSync.SetTimeOut(0,0,30,0,'TerminateProcess')
!!            c25_TerminateProcess(c25_getcurrentprocess(),0)
!!        End           
!!        Return 0
!!        
!!        
!!        
!!c25_WinApiClass.RefToPtrAndSizePtr    Procedure(*String _strRef)
!!
!!PtrAndSizeRef   &String
!!PtrAndSize      Group(PtrAndSize_TYPE),Pre(PtrAndSize)
!!                End
!!    Code
!!
!!    PtrAndSizeRef   &= NEW String(8)
!!    PtrAndSize.Ptr  = Address(_strRef)
!!    PtrAndSize.Size = Size(_strRef)
!!
!!    PtrAndSizeRef = PtrAndSize
!!    Return Address(PtrAndSizeRef)
!!
!!c25_WinApiClass.PtrToPtrAndSizePtrToStr    Procedure(Long _ptrToPtrAndSize)
!!
!!PtrAndSizeRef   &String
!!PtrAndSize      Group(PtrAndSize_TYPE),Pre(PtrAndSize)
!!                End
!!String100       String(100)
!!
!!    Code
!!
!!        Message('error obselate PtrToPtrAndSizePtrToStr')
!!        If c25_IsBadreadPtr(_ptrToPtrAndSize,8) <> 0
!!            Return ''
!!        End
!!        Peek(_ptrToPtrAndSize,PtrAndSize)
!!        PtrAndSizeRef &= (PtrAndSize)
!!
!!        Message('PtrAndSizeRef: ' & PtrAndSizeRef)
!!        Message('PtrAndSize.Ptr ' & PtrAndSize.Ptr)
!!        Peek(PtrAndSize.Ptr,String100)
!!        Message('String100 ' & String100)
!!        Message('PtrAndSize.Size ' & PtrAndSize.Size)
!!
!!        PtrAndSizeRef &= (PtrAndSize.Ptr)
!!        Message('PtrAndSizeRef: ' & PtrAndSizeRef)
!!
!!        Return ''
!!
!!c25_WinApiClass.QueueRecordToStringRefPtr     Procedure(*Queue _q)
!!
!!StringRef                       &String
!!
!!GrpDummyString                  Group,Pre(GrpDummyString)
!!DummyString                         &String
!!                                End
!!AnyField                        ANY
!!AdrGroup                        Group,pre()
!!PtrAddress                          Long
!!PtrSize                             Long
!!                                End
!!AddressAndSizeFromAny           String(8),over(AdrGroup)
!!PtrAndSizeRef                   &String
!!PtrAndSize                      Group(PtrAndSize_TYPE),Pre(PtrAndSize)
!!                                End
!!
!!    Code
!!
!!        PtrAndSizeRef &= NEW String(8)
!!        Clear(PtrAndSizeRef,-1)
!!        If _q &= NULL
!!            Return 0
!!        End
!!
!!        StringRef &= NEW String(Size(_q))
!!        StringRef = _q
!!
!!        GrpDummyString.DummyString &= StringRef
!!        AnyField &= What(GrpDummyString,1)
!!        AddressAndSizeFromAny = AnyField
!!        PtrAndSize = AddressAndSizeFromAny
!!        PtrAndSizeRef = AddressAndSizeFromAny
!!
!!        Return Address(PtrAndSizeRef)
!!!        
!!!c25_WinApiClass.FileRecordToStringRefPtr     Procedure(*File _t)
!!!
!!!StringRef                       &String
!!!
!!!GrpDummyString                  Group,Pre(GrpDummyString)
!!!DummyString                         &String
!!!                                End
!!!AnyField                        ANY
!!!AdrGroup                        Group,pre()
!!!PtrAddress                          Long
!!!PtrSize                             Long
!!!                                End
!!!AddressAndSizeFromAny           String(8),over(AdrGroup)
!!!PtrAndSizeRef                   &String
!!!PtrAndSize                      Group(PtrAndSize_TYPE),Pre(PtrAndSize)
!!!                                End
!!!!gr                              &Group
!!!
!!!    Code
!!!
!!!        Message('in FileRecordToStringRefPtr')
!!!        
!!!        PtrAndSizeRef &= NEW String(8)
!!!        Clear(PtrAndSizeRef,-1)
!!!        If _t &= NULL
!!!            Message('warning _t &= NULL')
!!!            Return 0
!!!        End
!!!        Self.st1.Start()
!!!        Self.json1.Start()
!!!        Message('1')
!!!!        Self.json1.Add(_t)
!!!!        Message('2')
!!!        
!!!        Self.json1.Save(_t, Self.st1)
!!!        
!!!        !Self.json1.SaveString(Self.st1)
!!!        
!!!        Message('json String : ' & Self.st1.GetValue() )
!!!        
!!!        !Self.json1 &= _t{prop:record}
!!!        
!!!        !Message('ok')
!!!        !Message('gr size ' & Size(gr))
!!!        !Self.json1.SaveString(StringRef)
!!!        
!!!        If Self.st1.Length() = 0
!!!            Return 0
!!!        End
!!!        
!!!        StringRef &= NEW String(Self.st1.Length())
!!!        StringRef = Self.st1.GetValue()
!!!        
!!!!        gr &= null
!!!        
!!!        GrpDummyString.DummyString &= StringRef
!!!        AnyField &= What(GrpDummyString,1)
!!!        AddressAndSizeFromAny = AnyField
!!!        PtrAndSize = AddressAndSizeFromAny
!!!        PtrAndSizeRef = AddressAndSizeFromAny
!!!        
!!!!        Message('AdrGroup.PtrAddress ' & AdrGroup.PtrAddress)
!!!!        Message('AdrGroup.PtrSize ' & AdrGroup.PtrSize)
!!!        Return Address(PtrAndSizeRef)     
!!!        
!!        
!!        
!!        
!!c25_WinApiClass.JsonStringToQueue     Procedure(String _jsonString, *queue _q)  
!!
!!    Code
!!        
!!        Self.st1.Start()
!!        Self.st1.SetValue(Clip(_jsonString))
!!        
!!        Self.json1.Start()
!!        Self.json1.SetFreeQueueBeforeLoad(True)
!!        !Self.json1.SetRemovePrefix(True)
!!        !Self.json1.SetReplaceColons(True)
!!        Self.json1.SetTagCase(jf:CaseAsIs)
!!        Self.json1.Load(_q, Self.st1)
!!        Self.json1.Start()
!!        Self.st1.Start()
!!        Return 0
!!
!!c25_WinApiClass.JsonStringToQueue     Procedure(*StringTheory _stJson, *queue _q)  
!!
!!    Code
!!        
!!        !Self.st1.Start()
!!        !Self.st1.SetValue(Clip(_jsonString))
!!        
!!        Self.json1.Start()
!!        Self.json1.SetFreeQueueBeforeLoad(True)
!!        !Self.json1.SetRemovePrefix(True)
!!        !Self.json1.SetReplaceColons(True)
!!        Self.json1.SetTagCase(jf:CaseAsIs)
!!        Self.json1.Load(_q, _stJson)
!!        Self.json1.Start()
!!        
!!        !Self.st1.Start()
!!        Return 0
!!        
!!        
!!c25_WinApiClass.FileToJsonStringRef       Procedure(*File _t, <Byte _allRecords>)
!!
!!StringRef                               &String
!!
!!    Code
!!
!!
!!        If _t &= NULL
!!            Return null
!!        End
!!        If omitted(_allRecords) = True Or _allRecords = 0
!!            Get(_t,Pointer(_t))
!!        End
!!        
!!        Self.st1.Start()
!!        Self.json1.Start()
!!        
!!        !json.SetFreeQueueBeforeLoad(False) ! will be needed to add to the DiscountsQ multiple times.
!!        Self.json1.SetRemovePrefix(True)
!!        Self.json1.SetReplaceColons(True)
!!        Self.json1.SetTagCase(jf:CaseAsIs)  ! CaseAsIs uses the NAME attribute, not the LABEL        
!!        
!!        
!!        If omitted(_allRecords) = True Or _allRecords = 0
!!            Self.json1.Save(_t, Self.st1,,1,0,False)
!!        Else
!!            Self.json1.Save(_t, Self.st1)
!!        End
!!        If Self.st1.Length() > 0
!!            StringRef &= NEW String(Self.st1.Length())
!!            StringRef = Self.st1.GetValue()
!!            Return StringRef
!!        End
!!        Return null
!!            
!!        
!!c25_WinApiClass.QueueToJsonStringTheory     Procedure(*StringTheory _st, *queue _q, <Byte _disposeQ>, <Byte _skipFormatted>, <Byte _compress>)
!!
!!
!!    Code
!!        
!!        _st.Start()
!!        
!!        Self.json1.Start()
!!        If _q &= NULL
!!            Return ''
!!        End
!!        Self.json1.SetTagCase(jf:CaseAsIs)
!!        
!!        !If omitted(_skipFormatted) = False And _skipFormatted = True
!!            Self.Json1.Save(_q, _st)
!!        !Else
!!        !    Self.Json1.Save(_q, Self.st1,'',json:Object, True)
!!        !End
!!        If _disposeQ
!!            Free(_q)
!!            Dispose(_q)
!!        End
!!        Self.json1.Start() 
!!              
!!        Return ''
!!        
!!        
!!c25_WinApiClass.QueueToJsonString     Procedure(*queue _q, <Byte _disposeQ>, <Byte _skipFormatted>, <Byte _compress>)
!!
!!
!!    Code
!!        
!!        Self.st1.Start()
!!        Self.json1.Start()
!!        If _q &= NULL
!!            Return ''
!!        End
!!        Self.json1.SetTagCase(jf:CaseAsIs)
!!        
!!        If omitted(_skipFormatted) = False And _skipFormatted = True
!!            Self.Json1.Save(_q, Self.st1,'',json:Object, False)
!!        Else
!!            Self.Json1.Save(_q, Self.st1,'',json:Object, True)
!!        End
!!        If _disposeQ
!!            Free(_q)
!!            Dispose(_q)
!!        End
!!        Self.json1.Start() 
!!        
!!!        If _compress = TRUE
!!!            Self.st1.gzip()
!!!        End        
!!        Return Self.st1.GetValue()
!!        
!!        
!!        
!!c25_WinApiClass.QueueToJsonStringRef     Procedure(*queue _q, <Byte _disposeQ>, <Byte _skipFormatted>, <Byte _compress>)
!!
!!StringRef  &String
!!
!!    Code
!!        
!!        
!!        Self.st1.Start()
!!        Self.json1.Start()
!!        If _q &= NULL
!!            Return null
!!        End
!!        If omitted(_skipFormatted) = False And _skipFormatted = True
!!            Self.Json1.Save(_q, Self.st1,'',json:Object, False)
!!        Else
!!            Self.Json1.Save(_q, Self.st1,'',json:Object, True)
!!        End
!!
!!        If _disposeQ
!!            Free(_q)
!!            Dispose(_q)
!!        End  
!!        If Self.st1.Length() > 0
!!            If _compress = TRUE
!!                Self.st1.gzip(1)
!!            End
!!            
!!            StringRef &= NEW String(Self.st1.Length())
!!            StringRef = Self.st1.GetValue()
!!            Return StringRef
!!        End
!!        Return null
!!
!!        
!!c25_WinApiClass.StringRefToQueue      Procedure(*String _strRef, *queue _q, <Byte _initFree>, <Byte _skipDisposeStringRef>)
!!
!!StringRef  &String,AUTO
!!
!!    Code
!!        
!!        If _q &= NULL
!!            Return ''
!!        End
!!        If _initFree
!!            Free(_q)
!!        End
!!        Clear(_q)
!!        
!!        StringRef &= _strRef
!!        If not StringRef &= NULL
!!            _q = _strRef
!!        End
!!        Add(_q)
!!        If _skipDisposeStringRef = 0 Or Omitted(_skipDisposeStringRef) = TRUE
!!            Dispose(StringRef)
!!        End
!!        
!!        Return _q
!!
!!c25_WinApiClass.StringRefJSonToQueue      Procedure(*String _strRef, *queue _q, <Byte _initFree>, <Byte _skipDisposeStringRef>)
!!
!!StringRef  &String,AUTO
!!
!!    Code
!!        
!!        If _q &= NULL
!!            Return ''
!!        End
!!        If _initFree
!!            Free(_q)
!!        End
!!        Clear(_q)
!!        Self.json1.Start()
!!        
!!        StringRef &= _strRef
!!        If not StringRef &= NULL
!!            Self.st1.Start()
!!            Self.st1.SetValue(StringRef)
!!            Self.json1.Load(_q,Self.st1)
!!            Self.json1.Start()
!!        End
!!
!!        If _skipDisposeStringRef = 0 Or Omitted(_skipDisposeStringRef) = TRUE
!!            Dispose(StringRef)
!!        End
!!        
!!        Return _q
!!        
!!c25_WinApiClass.StringToStringRefPtr     Procedure(String _s, <Byte _globalAlloc>)
!!
!!StringRef                       &String
!!
!!GrpDummyString                  Group,Pre(GrpDummyString)
!!DummyString                         &String
!!                                End
!!AnyField                        ANY
!!AdrGroup                        Group,pre()
!!PtrAddress                          Long
!!PtrSize                             Long
!!                                End
!!AddressAndSizeFromAny           String(8),over(AdrGroup)
!!PtrAndSizeRef                   &String
!!PtrAndSize                      Group(PtrAndSize_TYPE),Pre(PtrAndSize)
!!                                End
!!
!!    Code
!!        
!!        If _globalAlloc = TRUE
!!            
!!        Else
!!            PtrAndSizeRef &= NEW String(8)
!!            Clear(PtrAndSizeRef,-1)
!!            If Size(_s) < 1
!!                Return 0
!!            End
!!
!!            StringRef &= NEW String(Size(_s))
!!            StringRef = _s
!!
!!            GrpDummyString.DummyString &= StringRef
!!            AnyField &= What(GrpDummyString,1)
!!            AddressAndSizeFromAny = AnyField
!!            PtrAndSize = AddressAndSizeFromAny
!!            PtrAndSizeRef = AddressAndSizeFromAny
!!
!!            Return Address(PtrAndSizeRef)      
!!        End
!!        Return 0
!!
!!c25_WinApiClass.StringRefPtrToString      Procedure(Long _ptrAndSizePtr)
!!
!!StringRef                               &String
!!PtrAndSize                              Group(PtrAndSize_TYPE),Pre(PtrAndSize)
!!                                        End
!!
!!    Code
!!
!!        If c25_IsBadreadPtr(_ptrAndSizePtr,8) <> 0
!!            Return ''
!!        End
!!        Peek(_ptrAndSizePtr,PtrAndSize)
!!        StringRef &= (_ptrAndSizePtr)
!!        Dispose(StringRef)
!!
!!        StringRef &= NULL
!!
!!        If PtrAndSize.Size < 1 Or PtrAndSize.Ptr = 0
!!            Return ''
!!        End
!!
!!        If not Self.BufferStr &= NULL
!!            Dispose(Self.BufferStr)
!!        End
!!
!!        Self.BufferStr &= NEW String(PtrAndSize.Size)
!!        Peek(PtrAndSize.Ptr,Self.BufferStr)
!!
!!        Return Self.BufferStr
!!
!!c25_WinApiClass.StringRefPtrToQueue     Procedure(Long _ptrAndSizePtr, *Queue _q, <Byte _add>)
!!
!!    Code
!!
!!        If _q &= NULL
!!            Return 0
!!        End
!!        Clear(_q)
!!        _q = Self.StringRefPtrToString(_ptrAndSizePtr)
!!        If _add
!!            Add(_q)
!!        End
!!        Return 0
!!
!!c25_WinApiClass.CreateString Procedure(<String _value>,<Long _len>)
!!
!!NewString                       &String
!!
!!    Code
!!
!!        If OMITTED(_value) = False
!!            If Len(clip(_value)) < 1
!!                Return NULL
!!            End
!!            If Omitted(_len) = False And _len > 0
!!                NewString &= NEW String(_len)
!!            Else
!!                NewString &= NEW String(Len(clip(_value)))
!!            End
!!            NewString = _value
!!            Return NewString
!!        ElsIf OMITTED(_len) = False And _len > 0
!!            NewString &= NEW String(_len)
!!            Return NewString
!!        End
!!        Return null
!!
!!
!!!c25_WinApiClass.DnsLookupIp   Procedure(String _domainName)
!!!
!!!NetStr String(128)
!!!
!!!    Code
!!!        
!!!        Loop 10 Times
!!!            NetStr = clip(_domainName)
!!!            NetOptions(NET:DNSLOOKUP, NetStr)
!!!            If Clip(NetStr) <> clip(_domainName)
!!!                BREAK
!!!            End
!!!        End
!!!        Return Clip(NetStr)
!!!
!!!c25_WinApiClass.DnsLookupIpStrRef   Procedure(String _domainName)
!!!
!!!NetStr    String(256)
!!!NetStrRef   &String
!!!StringRef &String
!!!
!!!    Code
!!!        
!!!        NetStrRef   &= NEW String(Len(Clip(_domainName) + 1))
!!!        NetStrRef   = Clip(_domainName) & Chr(0)
!!!        NetOptions(NET:DNSLOOKUP, NetStrRef)
!!!        Message('in dnslook ' & NetStrRef)
!!!    
!!!        If Len(Clip(NetStr)) < 1
!!!           ! Message('warning NetStr < 1')
!!!            Return NULL
!!!        End
!!!        StringRef &= NEW String(Len(Clip(NetStr)))
!!!        StringRef = Clip(NetStr)
!!!        Return StringRef
!!        
!!c25_WinApiClass.GetBits8FromString1               Procedure(*String _str)
!!
!!Code
!!
!!    Self.STRING1 = _str
!!
!!    Self.BITS8 = '00000000'
!!    Self.OneLong = Val(Self.STRING1)
!!
!!    If BAND(Self.OneLong,00000001B)
!!        Self.BITS8[8] = '1'
!!    End
!!    If BAND(Self.OneLong,00000010B)
!!        Self.BITS8[7] = '1'
!!    End
!!    If BAND(Self.OneLong,00000100B)
!!        Self.BITS8[6] = '1'
!!    End
!!    If BAND(Self.OneLong,00001000B)
!!        Self.BITS8[5] = '1'
!!    End
!!    If BAND(Self.OneLong,00010000B)
!!        Self.BITS8[4] = '1'
!!    End
!!    If BAND(Self.OneLong,00100000B)
!!        Self.BITS8[3] = '1'
!!    End
!!    If BAND(Self.OneLong,01000000B)
!!        Self.BITS8[2] = '1'
!!    End
!!    If BAND(Self.OneLong,10000000B)
!!        Self.BITS8[1] = '1'
!!    End
!!    Return Self.BITS8
!!
!!c25_WinApiClass.GetBits32FromStr4                 Procedure(*String _str)
!!
!!    Code
!!
!!        Self.Str4 = _str
!!        Return Self.GetBits8FromString1(Self.Str4[4]) & Self.GetBits8FromString1(Self.Str4[3]) & Self.GetBits8FromString1(Self.Str4[2]) & Self.GetBits8FromString1(Self.Str4[1])
!!
!!c25_WinApiClass.DictKeyExists                     Procedure(*Dictionary_TYPE _dict, String _key, <Byte _caseSensitive>)
!!
!!    Code
!!
!!        If _dict &= NULL
!!            Message('error DictKeyExists Q is null')
!!            Return False
!!        End
!!        If not Self.DictKey &= null
!!            Dispose(Self.DictKey)
!!        End
!!        If omitted(_caseSensitive) = False
!!            If _caseSensitive = True
!!                Self.DictKey &= Self.BinaryCopy(Clip(_key))
!!            ELSE
!!                Self.DictKey &= Self.BinaryCopy(Upper(Clip(_key)))
!!            End
!!        ELSE
!!            Self.DictKey &= Self.BinaryCopy(Upper(Clip(_key)))
!!        End
!!
!!        I# = 0
!!        LOOP
!!            I# = I# + 1
!!            Get(_dict,I#)
!!            If Errorcode() <> 0
!!                BREAK
!!            End
!!            If _dict.Key &= NULL
!!                CYCLE
!!            End
!!            If _caseSensitive
!!                If Self.DictKey <> Clip(_dict.Key)
!!                    CYCLE
!!                End
!!            Else
!!                If Self.DictKey <> Upper(Clip(_dict.Key))
!!                    CYCLE
!!                End
!!            End
!!            Return TRUE
!!        End
!!        Return False
!!
!!c25_WinApiClass.DictAddKeyValue       Procedure(*Dictionary_TYPE _dict, String _key, String _value, <Byte _caseSensitive>)
!!
!!    Code
!!
!!    If Self.DictKeyExists(_dict, _key, _caseSensitive) = False
!!        _dict.Key &= Self.BinaryCopy(_key)
!!        _dict.Value &= Self.BinaryCopy(_value)
!!        Add(_dict,+_dict.Key)
!!        Return True
!!    End
!!    Return 0
!!
!!c25_WinApiClass.DictGetValue                      Procedure(*Dictionary_TYPE _dict, String _key, <Byte _caseSensitive>)
!!
!!    Code
!!
!!        If _dict &= NULL
!!            Return False
!!        End
!!        If not Self.DictKey &= null
!!            Dispose(Self.DictKey)
!!        End
!!        If omitted(_caseSensitive) = False
!!            If _caseSensitive = True
!!                Self.DictKey &= Self.BinaryCopy(Clip(_key))
!!            ELSE
!!                Self.DictKey &= Self.BinaryCopy(Upper(Clip(_key)))
!!            End
!!        ELSE
!!            Self.DictKey &= Self.BinaryCopy(Upper(Clip(_key)))
!!        End
!!        R# = Records(_dict)
!!        I# = 0
!!        LOOP R# Times
!!            I# = I# + 1
!!            Get(_dict,I#)
!!            If Errorcode() <> 0
!!                BREAK
!!            End
!!            If _dict.Key &= NULL
!!                CYCLE
!!            End
!!            If _caseSensitive
!!                If Self.DictKey <> Clip(_dict.Key)
!!                    CYCLE
!!                End
!!            Else
!!                If Self.DictKey <> Upper(Clip(_dict.Key))
!!                    CYCLE
!!                End
!!            End
!!            Return _dict.Value
!!        End
!!        Return ''
!!
!!c25_WinApiClass.GetGlobalMemPtrFromReg32      Procedure()
!!
!!SubKey                                          cstring(128)
!!phkResult                                       Long
!!dwDisposition                                   Long
!!ValueName                                       cstring(128)
!!ProcessId                                       Long
!!ValReturn                                       Long
!!ValReturnLen                                    Long
!!
!!    Code
!!
!!        SubKey = Self.SubKeyPathDefault & 'Instances'
!!        c25_RegOpenKeyExA(080000002h,Address(SubKey), 0,  KEY_ALL_ACCESS ,Address(phkResult))
!!        ProcessId = c25_GetProcessId(c25_GetCurrentProcess())
!!        If phkResult <> 0
!!            ValueName = Clip(Left(ProcessId))
!!            ValReturnLen = 4
!!            R# = c25_RegQueryValueExA(phkResult,Address(ValueName),0 ,0,Address(ValReturn),Address(ValReturnLen))
!!            c25_RegCloseKey(phkResult)
!!            If ValReturn <> 0
!!                Return ValReturn
!!            ELSE
!!                Return 0
!!            End
!!        End
!!        !Message('error failed GetGlobalMemPtrFromReg32')
!!        Return 0
!!        
!!c25_WinApiClass.GetLogServerWinHandleFromReg32      Procedure()
!!
!!SubKey                                          cstring(128)
!!phkResult                                       Long
!!dwDisposition                                   Long
!!ValueName                                       cstring(128)
!!ProcessId                                       Long
!!ValReturn                                       Long
!!ValReturnLen                                    Long
!!HKEY_LOCAL_MACHINE2 EQUATE(080000002h)
!!
!!    Code
!!
!!        SubKey = Self.SubKeyPathDefault
!!        c25_RegOpenKeyExA(HKEY_LOCAL_MACHINE2,Address(SubKey), 0,  KEY_ALL_ACCESS ,Address(phkResult))
!!        If phkResult <> 0
!!            ValueName = 'LogServerWinHandle'
!!            ValReturnLen = 4
!!            R# = c25_RegQueryValueExA(phkResult,Address(ValueName),0 ,0,Address(ValReturn),Address(ValReturnLen))
!!            c25_RegCloseKey(phkResult)
!!            If ValReturn <> 0
!!                Return ValReturn
!!            ELSE
!!                Return 0
!!            End
!!        End
!!        Return 0
!!        
!!        
!!
!!c25_WinApiClass.SetGlobalDictionaryValue   Procedure(String _key, String _value)
!!
!!    Code
!!
!!        If not Self.GlobalMem &= NULL
!!            Return Self.GlobalMem.SetGlobalDictionaryValue(_key, _value)
!!        ELSE
!!            Message('bad, Self.GlobalMem &= NULL')
!!        End
!!        Return ''
!!
!!c25_WinApiClass.GetGlobalDictionaryValue   Procedure(String _key, <any _valueIfNull>)
!!
!!    Code
!!
!!        If not Self.GlobalMem &= NULL
!!            If omitted(_valueIfNull) = True
!!                Return Self.GlobalMem.GetGlobalDictionaryValue(_key)
!!            Else
!!                Return Self.GlobalMem.GetGlobalDictionaryValue(_key, _valueIfNull)
!!            End
!!        ELSE
!!            Message('bad, GetGlobalDictionaryValue Self.GlobalMem &= NULL')
!!        End
!!        Return ''
!!        
!!!c25_WinApiClass.GetGlobalDictionaryValue   Procedure(String _key, Long _valueIfNull)
!!!
!!!    Code
!!!
!!!        If not Self.GlobalMem &= NULL
!!!            If omitted(_valueIfNull) = True
!!!                Return Self.GlobalMem.GetGlobalDictionaryValue(_key)
!!!            Else
!!!                Return Self.GlobalMem.GetGlobalDictionaryValue(_key, Clip(_valueIfNull))
!!!            End
!!!        ELSE
!!!            Message('bad, GetGlobalDictionaryValue Self.GlobalMem &= NULL')
!!!        End
!!!        Return ''
!!        
!!c25_WinApiClass.RemoveGlobalDictionaryValue   Procedure(String _key, <Byte _caseSensitive>)
!!
!!    Code
!!
!!        If not Self.GlobalMem &= NULL
!!            If omitted(_caseSensitive) = True
!!                Return Self.GlobalMem.RemoveGlobalDictionaryValue(_key)
!!            Else
!!                Return Self.GlobalMem.RemoveGlobalDictionaryValue(_key, _caseSensitive)
!!            End
!!        ELSE
!!            Message('bad, GetGlobalDictionaryValue Self.GlobalMem &= NULL')
!!        End
!!        Return ''
!!
!!
!!c25_WinApiClass.InitGlobalMem         Procedure()
!!
!!    Code
!!
!!        If Self.GlobalMemPtr = 0
!!            Self.GlobalMemPtr = Self.GetGlobalMemPtrFromReg32()
!!            If Self.GlobalMemPtr <> 0
!!                Self.GlobalMem &= (Self.GlobalMemPtr)
!!            End
!!        End
!!        Return Self.GlobalMemPtr
!!

!!
!!c25_WinApiClass.Guid74To16      Procedure(String _guid74)
!!
!!Guid74 String(74)
!!Guid16 String(16)
!!Guid36 String(36)
!!
!!    Code
!!
!!        Guid74        = _guid74
!!
!!        Self.st1.Start()
!!        Self.st1.SetValue(Guid74)
!!        Self.st2.Start()
!!        Self.st2.SetValue(Self.st1.Sub(3,8) & '-' & Self.st1.Sub(15,4)  & '-' &  Self.st1.Sub(23,4)  & '-' &  Self.st1.Sub(31,2) & Self.st1.Sub(37,2)  & '-' &  Self.st1.Sub(43,2) & Self.st1.Sub(49,2) & Self.st1.Sub(55,2) & Self.st1.Sub(61,2) & Self.st1.Sub(67,2) & Self.st1.Sub(73,2) )
!!
!!        Guid36      = Upper(Self.st2.GetValue())
!!        Guid16      = Self.Guid16FromGuid36(Guid36)
!!
!!        Return Guid16
!!
!!c25_WinApiClass.Guid74To36      Procedure(String _guid74)
!!
!!Guid74 String(74)
!!Guid36 String(36)
!!
!!    Code
!!
!!        Guid74        = _guid74
!!
!!        Self.st1.Start()
!!        Self.st1.SetValue(Guid74)
!!        Self.st2.Start()
!!        Self.st2.SetValue(Self.st1.Sub(3,8) & '-' & Self.st1.Sub(15,4)  & '-' &  Self.st1.Sub(23,4)  & '-' &  Self.st1.Sub(31,2) & Self.st1.Sub(37,2)  & '-' &  Self.st1.Sub(43,2) & Self.st1.Sub(49,2) & Self.st1.Sub(55,2) & Self.st1.Sub(61,2) & Self.st1.Sub(67,2) & Self.st1.Sub(73,2) )
!!
!!        Guid36 = Upper(Self.st2.GetValue())
!!        Return Guid36
!!
!!c25_WinApiClass.GetProcessHeapHandle                  Procedure()
!!
!!    Code
!!
!!        If Self.ProcessHeapHandle = 0
!!            Self.ProcessHeapHandle = c25_GetProcessHeap()
!!        End
!!        Return Self.ProcessHeapHandle
!!
!!c25_WinApiClass.HeapAlloc                             Procedure(Long _size)
!!
!!HeapMemAddress Long
!!
!!    Code
!!
!!        If _size < 1
!!            Return 0
!!        End
!!        HeapMemAddress = c25_HeapAlloc(Self.GetProcessHeapHandle(),HEAP_NO_SERIALIZE + HEAP_ZERO_MEMORY,_size)
!!        If HeapMemAddress = 0
!!            Message('error HeapAlloc in c25WinApiClass')
!!        End
!!        Return HeapMemAddress
!!
!!c25_WinApiClass.INT64ToBits                           Procedure(String _int64)
!!
!!    Code
!!
!!    Self.Bits64 = All('0',64)
!!    Self.Int64 = _int64
!!
!!    Self.BytePos = 0
!!    Loop 8 TIMES
!!        Self.BytePos = Self.BytePos + 1
!!        Self.ByteVal = Val(Self.Int64[9-Self.BytePos])
!!
!!        If Self.ByteVal = 0
!!            CYCLE
!!        End
!!        Self.BitPos = (Self.BytePos*8) - 7
!!        If BAND(Self.ByteVal,10000000b)
!!            Self.Bits64[Self.BitPos] = '1'
!!        End
!!        If BAND(Self.ByteVal,01000000b)
!!            Self.Bits64[Self.BitPos+1] = '1'
!!        End
!!        If BAND(Self.ByteVal,00100000b)
!!            Self.Bits64[Self.BitPos+2] = '1'
!!        End
!!        If BAND(Self.ByteVal,00010000b)
!!            Self.Bits64[Self.BitPos+3] = '1'
!!        End
!!        If BAND(Self.ByteVal,00001000b)
!!            Self.Bits64[Self.BitPos+4] = '1'
!!        End
!!        If BAND(Self.ByteVal,00000100b)
!!            Self.Bits64[Self.BitPos+5] = '1'
!!        End
!!        If BAND(Self.ByteVal,00000010b)
!!            Self.Bits64[Self.BitPos+6] = '1'
!!        End
!!        If BAND(Self.ByteVal,01000001b)
!!            Self.Bits64[Self.BitPos+7] = '1'
!!        End
!!    End
!!    Return Self.Bits64
!!
!!c25_WinApiClass.GenerateRandomBuffer                  Procedure(<Long _size>, <Long _bufferPtr>,<Long _algorithmProvider>)
!!
!!NTSTATUS                                Long
!!BufferHeapMemAddress                    Long
!!BCRYPT_ALG_HANDLE                       Long
!!BCRYPT_RNG_USE_ENTROPY_IN_BUFFER        EQUATE(1)
!!BCRYPT_USE_SYSTEM_PREFERRED_RNG         EQUATE(2)
!!
!!TestBlock String(64000)
!!
!!    Code
!!
!!        If _size < 1
!!            Message('error, buffer size is too small at c25_WinApiClass.GenerateRandomBuffer')
!!            Return 0
!!        End
!!        If OMITTED(_bufferPtr)
!!            BufferHeapMemAddress = Self.HeapAlloc(_size)
!!            If BufferHeapMemAddress = 0
!!                Message('error HeapAlloc in c25_WinApiClass.GenerateRandomBuffer')
!!                Return 0
!!            End
!!        End
!!        NTSTATUS = c25_BCryptGenRandom(0, BufferHeapMemAddress, _size,  BCRYPT_USE_SYSTEM_PREFERRED_RNG)
!!        If NTSTATUS <> 0
!!            Message('NTSTATUS ' & NTSTATUS)
!!            Return 0
!!        Else
!!            Self.st1.Start()
!!        End
!!        Return BufferHeapMemAddress
!!
!!c25_WinApiClass.GetExecutionThread                    Procedure() ! CLARION THREAD INFO
!!
!!    Code
!!
!!        Return Thread()
!!
!!c25_WinApiClass.GetCurrentThread                      Procedure()
!!
!!    Code
!!
!!        Return c25_GetCurrentThread()
!!
!!c25_WinApiClass.GetCurrentProcess                     Procedure() ! pseudo Process Handle / mostly -1
!!
!!    Code
!!
!!        Return c25_GetCurrentProcess()
!!
!!c25_WinApiClass.GetThreadHandle                       Procedure() ! Global Windows Thread HAndle
!!
!!GlobalThreadHandle                      Long
!!
!!    Code
!!
!!        c25_DuplicateHandle(Self.GetCurrentProcess(), Self.GetCurrentThread(), Self.GetCurrentProcess(), Address(GlobalThreadHandle), 0, 0, 0)
!!        c25_CloseHandle(GlobalThreadHandle)
!!        Return GlobalThreadHandle
!!
!!c25_WinApiClass.GetThreadId                           Procedure()
!!
!!    Code
!!
!!        Return c25_GetThreadId(Self.GetCurrentThread())
!!
!!c25_WinApiClass.GetProcessHandle                      Procedure() ! Global Windows Process Handle
!!
!!GlobalProcessHandle                      Long
!!
!!    Code
!!
!!        c25_DuplicateHandle(Self.GetCurrentProcess(), Self.GetCurrentProcess(), Self.GetCurrentProcess(), Address(GlobalProcessHandle), 0, 0, 0)
!!        c25_CloseHandle(GlobalProcessHandle)
!!        Return GlobalProcessHandle
!!
!!c25_WinApiClass.GetShortFromStr2                      Procedure(String _str2)
!!
!!    Code
!!
!!    Self.Str2 = _str2
!!    Return Self.ShortOverStr2
!!
!!c25_WinApiClass.GetUShortFromStr2                     Procedure(String _str2)
!!
!!    Code
!!
!!    Self.Str2 = _str2
!!    Return Self.UShortOverStr2
!!
!!c25_WinApiClass.GetLongFromStr4                       Procedure(String _str4)
!!
!!    Code
!!
!!    Self.Str4 = _str4
!!    Return Self.LongOverStr4
!!
!!c25_WinApiClass.GetULongFromStr4                      Procedure(String _str4)
!!
!!    Code
!!
!!    Self.Str4 = _str4
!!    Return Self.ULongOverStr4
!!
!!c25_WinApiClass.IsInstalled                           Procedure()
!!
!!CurrentExeFullPathAnsi              String(2048)
!!TargetExeFullPathAnsi               &String
!!IsInstalled                         Byte
!!
!!CurrentExeFullPathUtf16             String(2048)
!!TargetExeFullPathUtf16              &String
!!
!!    Code
!!
!!        Self.KnownFolders = Self.GetKnownFolders()
!!        CurrentExeFullPathAnsi = Self.GetCurrentExeFullPathAnsi()
!!        TargetExeFullPathAnsi  &= Self.ConcatAnsi(False, , Self.KnownFolders.ApplicationFullPathAnsi, '\' , Self.KnownFolders.ApplicationNameAnsi, '.exe' & Chr(0))
!!
!!        CurrentExeFullPathUtf16 = Self.GetCurrentExeFullPathUtf16()
!!        TargetExeFullPathUtf16  &= Self.ConcatUtf16(False, , Self.KnownFolders.ApplicationFullPathUtf16, '\' & Chr(0), Self.KnownFolders.ApplicationNameUtf16, '.' & Chr(0) & 'e' & Chr(0) & 'x' & Chr(0) & 'e' & Chr(0),  Chr(0) & Chr(0))
!!
!!        If Lower(Clip(CurrentExeFullPathUtf16)) = Lower(Clip(TargetExeFullPathUtf16))
!!            IsInstalled = True
!!        End
!!        Dispose(TargetExeFullPathAnsi)
!!        Dispose(TargetExeFullPathUtf16)
!!
!!        Return IsInstalled
!!
        
        
!c25_WinApiClass.GetKnownFolder      Procedure()




!c25_WinApiClass.GetKnownFolders                       Procedure()
!
!KnownFolders    Group(KnownFolders_TYPE),Pre(KnownFolders)
!                End
!
!    Code
!
!        Clear(KnownFolders)
!
!!        KnownFolders.KnownPath_ProgramFilesUtf16            &= Self.GetKnownPath('ProgramFiles')
!!        KnownFolders.KnownPath_ProgramFilesUtf8             &= Self.BitConverterClass.Utf16ToUtf8(KnownFolders.KnownPath_ProgramFilesUtf16)
!!        KnownFolders.KnownPath_ProgramFilesAnsi             &= Self.BitConverterClass.Utf16ToAnsi(KnownFolders.KnownPath_ProgramFilesUtf16)
!!        KnownFolders.KnownPath_ApplicationShortcutsUtf16    &= Self.GetKnownPath('ApplicationShortcuts')
!!        KnownFolders.KnownPath_LocalAppDataUtf16            &= Self.GetKnownPath('LocalAppData')
!!        KnownFolders.KnownPath_RoamingAppDataUtf16          &= Self.GetKnownPath('RoamingAppData')
!!        KnownFolders.KnownPath_DocumentsUtf16               &= Self.GetKnownPath('DOCUMENTS')
!!        KnownFolders.KnownPath_ProgramDataUtf16             &= Self.GetKnownPath('PROGRAMDATA')
!!        KnownFolders.KnownPath_ProgramDataUtf8              &= Self.BitConverterClass.Utf16ToUtf8(KnownFolders.KnownPath_ProgramDataUtf16)
!!        KnownFolders.KnownPath_ProgramDataAnsi              &= Self.BitConverterClass.Utf16ToAnsi(KnownFolders.KnownPath_ProgramDataUtf16)
!!        KnownFolders.KnownPath_DesktopUtf16                 &= Self.GetKnownPath('Desktop')
!!        KnownFolders.ApplicationNameAnsi                    &= Self.BitConverterClass.BinaryCopy('AllMyDrives')
!!        KnownFolders.ApplicationNameUtf8                    &= Self.BitConverterClass.AnsiToUtf8(KnownFolders.ApplicationNameAnsi)
!!        KnownFolders.ApplicationNameUtf16                   &= Self.BitConverterClass.AnsiToUtf16(KnownFolders.ApplicationNameAnsi)
!!        KnownFolders.ApplicationFolderAnsi                  &= Self.BitConverterClass.BinaryCopy('AllMyDrives')
!!        KnownFolders.ApplicationFolderUtf8                  &= Self.BitConverterClass.AnsiToUtf8(KnownFolders.ApplicationFolderAnsi)
!!        KnownFolders.ApplicationFolderUtf16                 &= Self.BitConverterClass.AnsiToUtf16(KnownFolders.ApplicationFolderAnsi)
!!        KnownFolders.ApplicationDriveAnsi                   = KnownFolders.KnownPath_ProgramFilesAnsi[1]
!!        KnownFolders.ApplicationDriveUtf8                   = KnownFolders.KnownPath_ProgramFilesUtf8[1]
!!        KnownFolders.ApplicationDriveUtf16                  = KnownFolders.KnownPath_ProgramFilesUtf16[1 : 2]
!!        
!!        KnownFolders.ApplicationFullPathAnsi                &= Self.BitConverterClass.ConcatAnsi(True, '\',KnownFolders.KnownPath_ProgramFilesAnsi,KnownFolders.ApplicationFolderAnsi)
!!        KnownFolders.ApplicationFullPathUtf8                &= Self.BitConverterClass.ConcatUtf8(True, '\',KnownFolders.KnownPath_ProgramFilesUtf8,KnownFolders.ApplicationFolderUtf8)
!!        KnownFolders.ApplicationFullPathUtf16               &= Self.BitConverterClass.ConcatUtf16(True, '\' & Chr(0),KnownFolders.KnownPath_ProgramFilesUtf16,KnownFolders.ApplicationFolderUtf16)
!!        
!!        
!!        KnownFolders.DataStoreDriveAnsi                     = KnownFolders.ApplicationDriveAnsi
!!        KnownFolders.DataStoreDriveUtf8                     = KnownFolders.ApplicationDriveUtf8
!!        KnownFolders.DataStoreDriveUtf16                    = KnownFolders.ApplicationDriveUtf16
!!        KnownFolders.DataStoreDataFolderAnsi                &= Self.BitConverterClass.BinaryCopy('Data')
!!        KnownFolders.DataStoreDataFolderUtf8                &= Self.BitConverterClass.AnsiToUtf8(KnownFolders.DataStoreDataFolderAnsi)
!!        KnownFolders.DataStoreDataFolderUtf16               &= Self.BitConverterClass.AnsiToUtf16(KnownFolders.DataStoreDataFolderAnsi)
!!        KnownFolders.DataStoreAppFullPathUtf16              &= Self.BitConverterClass.ConcatUtf16(true, '\' & Chr(0),KnownFolders.KnownPath_LocalAppDataUtf16,KnownFolders.ApplicationFolderUtf16)
!!        KnownFolders.DataStoreAppFullPathAnsi               &= Self.BitConverterClass.Utf16ToAnsi(KnownFolders.DataStoreAppFullPathUtf16)
!!        KnownFolders.DataStoreAppFullPathUtf8               &= Self.BitConverterClass.Utf16ToUtf8(KnownFolders.DataStoreAppFullPathUtf16)
!!        KnownFolders.DataStoreFullPathUtf16                 &= Self.BitConverterClass.ConcatUtf16(true, '\' & Chr(0),KnownFolders.KnownPath_LocalAppDataUtf16,KnownFolders.ApplicationFolderUtf16,KnownFolders.DataStoreDataFolderUtf16)
!!        KnownFolders.DataStoreFullPathAnsi                  &= Self.BitConverterClass.Utf16ToAnsi(KnownFolders.DataStoreFullPathUtf16)
!!        KnownFolders.DataStoreFullPathUtf8                  &= Self.BitConverterClass.Utf16ToUtf8(KnownFolders.DataStoreFullPathUtf16)
!!        KnownFolders.ProgramDataFolderUtf16                 &= Self.BitConverterClass.ConcatUtf16(true, '\' & Chr(0),KnownFolders.KnownPath_ProgramDataUtf16,KnownFolders.ApplicationFolderUtf16)
!!        KnownFolders.ProgramDataFolderAnsi                  &= Self.BitConverterClass.Utf16ToAnsi(KnownFolders.ProgramDataFolderUtf16)
!!        KnownFolders.DataStoreUserFullPathUtf16             &= Self.BitConverterClass.ConcatUtf16(true, '\' & Chr(0),KnownFolders.KnownPath_RoamingAppDataUtf16,KnownFolders.ApplicationFolderUtf16)
!!        KnownFolders.DataStoreUserFullPathAnsi              &= Self.BitConverterClass.Utf16ToAnsi(KnownFolders.DataStoreUserFullPathUtf16)
!!        KnownFolders.DataStoreUserFullPathUtf8              &= Self.BitConverterClass.Utf16ToUtf8(KnownFolders.DataStoreUserFullPathUtf16)
!
!        Return KnownFolders

!!c25_WinApiClass.ReplaceCharsAnsi                      Procedure(String _str, String _old, String _new, <Long _codePage>)
!!
!!    Code
!!
!!        Self.st1.Start()
!!        Self.st1.encoding = st:EncodeAnsi
!!        If omitted(_codePage) = False
!!            Self.st1.CodePage = _codePage
!!        ELSE
!!            Self.st1.CodePage = st:CP_OEMCP
!!        End
!!        Self.st1.SetValue(_str)
!!        Self.st1.Replace(_old,_new)
!!        _str = Self.st1.GetValue()
!!        Return _str
!!
!!c25_WinApiClass.ReplaceCharsUtf8                      Procedure(String _str, String _old, String _new)
!!
!!    Code
!!
!!        Self.st1.Start()
!!        Self.st1.encoding = st:EncodeUtf8
!!        Self.st1.CodePage = st:CP_UTF8
!!        Self.st1.SetValue(_str)
!!        Self.st1.Replace(_old,_new)
!!        _str = Self.st1.GetValue()
!!        Return _str
!!
!!c25_WinApiClass.ReplaceCharsUtf16                     Procedure(String _str, String _old, String _new)
!!
!!    Code
!!
!!        Self.st1.Start()
!!        Self.st1.encoding = st:EncodeUtf16
!!        Self.st1.SetValue(_str)
!!        Self.st1.Replace(_old,_new)
!!        Return _str
!!
!!c25_WinApiClass.RemoveTrailingZeros                   Procedure(String _str, <Long _encoding>)
!!
!!StringRefOut                            &String
!!
!!    Code
!!
!!        L# = Len(_str)
!!        NL# = L#
!!
!!        Case _encoding
!!        Of st:EncodeUtf16
!!            P# = L# + 1
!!            Loop
!!                P# = P# - 1
!!                If P# < 1
!!                    Break
!!                End
!!
!!                If _str[P#] = Chr(0)
!!                    NL# = P# - 1
!!                End
!!            End
!!            If (NL#%2) ! odd
!!                NL# = NL# + 1
!!            End
!!            If NL# < 1
!!                Return NULL
!!            Else
!!                StringRefOut &= NEW String(NL#)
!!                StringRefOut = _str
!!                Return StringRefOut
!!            End
!!        ELSE
!!            P# = L# + 1
!!            Loop
!!                P# = P# - 1
!!                If P# < 1
!!                    Break
!!                End
!!
!!                If _str[P#] = Chr(0)
!!                    NL# = P# - 1
!!                End
!!            End
!!
!!            If NL# < 1
!!                Return NULL
!!            Else
!!                StringRefOut &= NEW String(NL#)
!!                StringRefOut = _str
!!                Return StringRefOut
!!            End
!!
!!        End
!!        Return NULL
!!
!!c25_WinApiClass.ConcatAnsiStr                         Procedure(<Byte _preRemoveTrailingZeros>,<String _divider>,String _s1, String _s2, <String _s3>,  <String _s4>, <String _s5>, <String _s6>, <String _s7>, <String _s8>)
!!
!!StringRefOut                    &String
!!
!!    Code
!!
!!        Self.StAnsi.Start()
!!        Self.StAnsi.encoding = st:EncodeAnsi
!!        Self.StAnsi.CodePage = st:CP_THREAD_ACP
!!        Self.StAnsi.Append(_s1)
!!
!!        If _preRemoveTrailingZeros = True
!!            Loop
!!                If Self.StAnsi.Length() < 1
!!                    Break
!!                End
!!                If Self.StAnsi.EndsWith(Chr(0))
!!                    Self.StAnsi.RemoveFromPosition(Self.StAnsi.Length()-0,1)
!!                Else
!!                    BREAK
!!                End
!!            End
!!        End
!!
!!        If omitted(_divider) = False
!!            Self.StAnsi.Append(_divider)
!!        End
!!        Self.StAnsi.Append(_s2)
!!        If _preRemoveTrailingZeros = True
!!            Loop
!!                If Self.StAnsi.Length() < 1
!!                    Break
!!                End
!!                If Self.StAnsi.EndsWith(Chr(0))
!!                    Self.StAnsi.RemoveFromPosition(Self.StAnsi.Length()-0,1)
!!                Else
!!                    BREAK
!!                End
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s3) = False
!!            Self.StAnsi.Append(_divider)
!!            Self.StAnsi.Append(_s3)
!!        ElsIf omitted(_s3) = False
!!            Self.StAnsi.Append(_s3)
!!        End
!!        If _preRemoveTrailingZeros = True
!!            Loop
!!                If Self.StAnsi.Length() < 1
!!                    Break
!!                End
!!                If Self.StAnsi.EndsWith(Chr(0))
!!                    Self.StAnsi.RemoveFromPosition(Self.StAnsi.Length()-0,1)
!!                Else
!!                    BREAK
!!                End
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s4) = False
!!            Self.StAnsi.Append(_divider)
!!            Self.StAnsi.Append(_s4)
!!        ElsIf omitted(_s4) = False
!!            Self.StAnsi.Append(_s4)
!!        End
!!        If _preRemoveTrailingZeros = True
!!            Loop
!!                If Self.StAnsi.Length() < 1
!!                    Break
!!                End
!!                If Self.StAnsi.EndsWith(Chr(0))
!!                    Self.StAnsi.RemoveFromPosition(Self.StAnsi.Length()-0,1)
!!                Else
!!                    BREAK
!!                End
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s5) = False
!!            Self.StAnsi.Append(_divider)
!!            Self.StAnsi.Append(_s5)
!!        ElsIf omitted(_s5) = False
!!            Self.StAnsi.Append(_s5)
!!        End
!!        If _preRemoveTrailingZeros = True
!!            Loop
!!                If Self.StAnsi.Length() < 1
!!                    Break
!!                End
!!                If Self.StAnsi.EndsWith(Chr(0))
!!                    Self.StAnsi.RemoveFromPosition(Self.StAnsi.Length()-0,1)
!!                Else
!!                    BREAK
!!                End
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s6) = False
!!            Self.StAnsi.Append(_divider)
!!            Self.StAnsi.Append(_s6)
!!        ElsIf omitted(_s6) = False
!!            Self.StAnsi.Append(_s6)
!!        End
!!        If _preRemoveTrailingZeros = True
!!            Loop
!!                If Self.StAnsi.Length() < 1
!!                    Break
!!                End
!!                If Self.StAnsi.EndsWith(Chr(0))
!!                    Self.StAnsi.RemoveFromPosition(Self.StAnsi.Length()-0,1)
!!                Else
!!                    BREAK
!!                End
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s7) = False
!!            Self.StAnsi.Append(_divider)
!!            Self.StAnsi.Append(_s7)
!!        ElsIf omitted(_s7) = False
!!            Self.StAnsi.Append(_s7)
!!        End
!!        If _preRemoveTrailingZeros = True
!!            Loop
!!                If Self.StAnsi.Length() < 1
!!                    Break
!!                End
!!                If Self.StAnsi.EndsWith(Chr(0))
!!                    Self.StAnsi.RemoveFromPosition(Self.StAnsi.Length()-0,1)
!!                Else
!!                    BREAK
!!                End
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s8) = False
!!            Self.StAnsi.Append(_divider)
!!            Self.StAnsi.Append(_s8)
!!        ElsIf omitted(_s8) = False
!!            Self.StAnsi.Append(_s8)
!!        End
!!        If _preRemoveTrailingZeros = True
!!            Loop
!!                If Self.StAnsi.Length() < 1
!!                    Break
!!                End
!!                If Self.StAnsi.EndsWith(Chr(0))
!!                    Self.StAnsi.RemoveFromPosition(Self.StAnsi.Length()-0,1)
!!                Else
!!                    BREAK
!!                End
!!            End
!!        End
!!
!!        If Self.StAnsi.Length() > 0
!!            StringRefOut &= NEW String(Self.StAnsi.Length())
!!            StringRefOut = Self.StAnsi.GetValue()
!!
!!            If not Self.BufferStr &= NULL
!!                Dispose(Self.BufferStr)
!!            End
!!            Self.BufferStr &= NEW String(Len(StringRefOut))
!!            Self.BufferStr = StringRefOut
!!            Dispose(StringRefOut)
!!            Return Self.BufferStr
!!        End
!!
!!        Return ''
!!
!!c25_WinApiClass.ConcatUtf8Str                         Procedure(<Byte _preRemoveTrailingZeros>,<String _divider>,String _s1, String _s2, <String _s3>,  <String _s4>, <String _s5>, <String _s6>, <String _s7>, <String _s8>)
!!
!!StringRefOut                    &String
!!
!!    Code
!!
!!        Self.StUtf8.Start()
!!        Self.StUtf8.encoding = st:EncodeUtf8
!!        Self.StUtf8.CodePage = st:CP_UTF8
!!        Self.StUtf8.Append(_s1)
!!
!!        If _preRemoveTrailingZeros = True
!!            Loop
!!                If Self.StUtf8.Length() < 1
!!                    Break
!!                End
!!                If Self.StUtf8.EndsWith(Chr(0))
!!                    Self.StUtf8.RemoveFromPosition(Self.StUtf8.Length()-0,1)
!!                Else
!!                    BREAK
!!                End
!!            End
!!        End
!!
!!        If omitted(_divider) = False
!!            Self.StUtf8.Append(_divider)
!!        End
!!        Self.StUtf8.Append(_s2)
!!        If _preRemoveTrailingZeros = True
!!            Loop
!!                If Self.StUtf8.Length() < 1
!!                    Break
!!                End
!!                If Self.StUtf8.EndsWith(Chr(0))
!!                    Self.StUtf8.RemoveFromPosition(Self.StUtf8.Length()-0,1)
!!                Else
!!                    BREAK
!!                End
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s3) = False
!!            Self.StUtf8.Append(_divider)
!!            Self.StUtf8.Append(_s3)
!!        ElsIf omitted(_s3) = False
!!            Self.StUtf8.Append(_s3)
!!        End
!!        If _preRemoveTrailingZeros = True
!!            Loop
!!                If Self.StUtf8.Length() < 1
!!                    Break
!!                End
!!                If Self.StUtf8.EndsWith(Chr(0))
!!                    Self.StUtf8.RemoveFromPosition(Self.StUtf8.Length()-0,1)
!!                Else
!!                    BREAK
!!                End
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s4) = False
!!            Self.StUtf8.Append(_divider)
!!            Self.StUtf8.Append(_s4)
!!        ElsIf omitted(_s4) = False
!!            Self.StUtf8.Append(_s4)
!!        End
!!        If _preRemoveTrailingZeros = True
!!            Loop
!!                If Self.StUtf8.Length() < 1
!!                    Break
!!                End
!!                If Self.StUtf8.EndsWith(Chr(0))
!!                    Self.StUtf8.RemoveFromPosition(Self.StUtf8.Length()-0,1)
!!                Else
!!                    BREAK
!!                End
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s5) = False
!!            Self.StUtf8.Append(_divider)
!!            Self.StUtf8.Append(_s5)
!!        ElsIf omitted(_s5) = False
!!            Self.StUtf8.Append(_s5)
!!        End
!!        If _preRemoveTrailingZeros = True
!!            Loop
!!                If Self.StUtf8.Length() < 1
!!                    Break
!!                End
!!                If Self.StUtf8.EndsWith(Chr(0))
!!                    Self.StUtf8.RemoveFromPosition(Self.StUtf8.Length()-0,1)
!!                Else
!!                    BREAK
!!                End
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s6) = False
!!            Self.StUtf8.Append(_divider)
!!            Self.StUtf8.Append(_s6)
!!        ElsIf omitted(_s6) = False
!!            Self.StUtf8.Append(_s6)
!!        End
!!        If _preRemoveTrailingZeros = True
!!            Loop
!!                If Self.StUtf8.Length() < 1
!!                    Break
!!                End
!!                If Self.StUtf8.EndsWith(Chr(0))
!!                    Self.StUtf8.RemoveFromPosition(Self.StUtf8.Length()-0,1)
!!                Else
!!                    BREAK
!!                End
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s7) = False
!!            Self.StUtf8.Append(_divider)
!!            Self.StUtf8.Append(_s7)
!!        ElsIf omitted(_s7) = False
!!            Self.StUtf8.Append(_s7)
!!        End
!!        If _preRemoveTrailingZeros = True
!!            Loop
!!                If Self.StUtf8.Length() < 1
!!                    Break
!!                End
!!                If Self.StUtf8.EndsWith(Chr(0))
!!                    Self.StUtf8.RemoveFromPosition(Self.StUtf8.Length()-0,1)
!!                Else
!!                    BREAK
!!                End
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s8) = False
!!            Self.StUtf8.Append(_divider)
!!            Self.StUtf8.Append(_s8)
!!        ElsIf omitted(_s8) = False
!!            Self.StUtf8.Append(_s8)
!!        End
!!        If _preRemoveTrailingZeros = True
!!            Loop
!!                If Self.StUtf8.Length() < 1
!!                    Break
!!                End
!!                If Self.StUtf8.EndsWith(Chr(0))
!!                    Self.StUtf8.RemoveFromPosition(Self.StUtf8.Length()-0,1)
!!                Else
!!                    BREAK
!!                End
!!            End
!!        End
!!
!!        If Self.StUtf8.Length() > 0
!!            StringRefOut &= NEW String(Self.StUtf8.Length())
!!            StringRefOut = Self.StUtf8.GetValue()
!!
!!            If not Self.BufferStr &= NULL
!!                Dispose(Self.BufferStr)
!!            End
!!            Self.BufferStr &= NEW String(Len(StringRefOut))
!!            Self.BufferStr = StringRefOut
!!            Dispose(StringRefOut)
!!            Return Self.BufferStr
!!        End
!!
!!        Return ''
!!
!!c25_WinApiClass.ConcatUtf16Str                        Procedure(<Byte _preRemoveTrailingZeros>,<String _divider>,String _s1, String _s2, <String _s3>,  <String _s4>, <String _s5>, <String _s6>, <String _s7>, <String _s8>)
!!
!!StringRefOut                    &String
!!PreRemoveTrailingZeros          Byte
!!
!!    Code
!!
!!        PreRemoveTrailingZeros = _preRemoveTrailingZeros
!!        PreRemoveTrailingZeros = False ! not working yet
!!        Self.StUtf16.Start()
!!        Self.StUtf16.encoding = st:EncodeUtf16
!!        Self.StUtf16.Append(_s1)
!!
!!        If PreRemoveTrailingZeros = True
!!            Loop
!!                If Self.StUtf16.Length() < 1
!!                    Break
!!                End
!!                If Self.StUtf16.EndsWith(Chr(0) & Chr(0))
!!                    Self.StUtf16.RemoveFromPosition(Self.StUtf16.Length()-1,2)
!!                Else
!!                    BREAK
!!                End
!!            End
!!            If (Self.StUtf16.Length()%2) ! odd
!!                Self.StUtf16.Append(Chr(0))
!!            End
!!        End
!!
!!        If omitted(_divider) = False
!!            Self.StUtf16.Append(_divider)
!!        End
!!        Self.StUtf16.Append(_s2)
!!        If PreRemoveTrailingZeros = True
!!            Loop
!!                If Self.StUtf16.Length() < 1
!!                    Break
!!                End
!!                If Self.StUtf16.EndsWith(Chr(0) & Chr(0))
!!                    Self.StUtf16.RemoveFromPosition(Self.StUtf16.Length()-1,2)
!!                Else
!!                    BREAK
!!                End
!!            End
!!            If (Self.StUtf16.Length()%2) ! odd
!!                Self.StUtf16.Append(Chr(0))
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s3) = False
!!            Self.StUtf16.Append(_divider)
!!            Self.StUtf16.Append(_s3)
!!        ElsIf omitted(_s3) = False
!!            Self.StUtf16.Append(_s3)
!!        End
!!        If PreRemoveTrailingZeros = True
!!            Loop
!!                If Self.StUtf16.Length() < 1
!!                    Break
!!                End
!!                If Self.StUtf16.EndsWith(Chr(0) & Chr(0))
!!                    Self.StUtf16.RemoveFromPosition(Self.StUtf16.Length()-1,2)
!!                Else
!!                    BREAK
!!                End
!!            End
!!            If (Self.StUtf16.Length()%2) ! odd
!!                Self.StUtf16.Append(Chr(0))
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s4) = False
!!            Self.StUtf16.Append(_divider)
!!            Self.StUtf16.Append(_s4)
!!        ElsIf omitted(_s4) = False
!!            Self.StUtf16.Append(_s4)
!!        End
!!        If PreRemoveTrailingZeros = True
!!            Loop
!!                If Self.StUtf16.Length() < 1
!!                    Break
!!                End
!!                If Self.StUtf16.EndsWith(Chr(0) & Chr(0))
!!                    Self.StUtf16.RemoveFromPosition(Self.StUtf16.Length()-1,2)
!!                Else
!!                    BREAK
!!                End
!!            End
!!            If (Self.StUtf16.Length()%2) ! odd
!!                Self.StUtf16.Append(Chr(0))
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s5) = False
!!            Self.StUtf16.Append(_divider)
!!            Self.StUtf16.Append(_s5)
!!        ElsIf omitted(_s5) = False
!!            Self.StUtf16.Append(_s5)
!!        End
!!        If PreRemoveTrailingZeros = True
!!            Loop
!!                If Self.StUtf16.Length() < 1
!!                    Break
!!                End
!!                If Self.StUtf16.EndsWith(Chr(0) & Chr(0))
!!                    Self.StUtf16.RemoveFromPosition(Self.StUtf16.Length()-1,2)
!!                Else
!!                    BREAK
!!                End
!!            End
!!            If (Self.StUtf16.Length()%2) ! odd
!!                Self.StUtf16.Append(Chr(0))
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s6) = False
!!            Self.StUtf16.Append(_divider)
!!            Self.StUtf16.Append(_s6)
!!        ElsIf omitted(_s6) = False
!!            Self.StUtf16.Append(_s6)
!!        End
!!        If PreRemoveTrailingZeros = True
!!            Loop
!!                If Self.StUtf16.Length() < 1
!!                    Break
!!                End
!!                If Self.StUtf16.EndsWith(Chr(0) & Chr(0))
!!                    Self.StUtf16.RemoveFromPosition(Self.StUtf16.Length()-1,2)
!!                Else
!!                    BREAK
!!                End
!!            End
!!            If (Self.StUtf16.Length()%2) ! odd
!!                Self.StUtf16.Append(Chr(0))
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s7) = False
!!            Self.StUtf16.Append(_divider)
!!            Self.StUtf16.Append(_s7)
!!        ElsIf omitted(_s7) = False
!!            Self.StUtf16.Append(_s7)
!!        End
!!        If PreRemoveTrailingZeros = True
!!            Loop
!!                If Self.StUtf16.Length() < 1
!!                    Break
!!                End
!!                If Self.StUtf16.EndsWith(Chr(0) & Chr(0))
!!                    Self.StUtf16.RemoveFromPosition(Self.StUtf16.Length()-1,2)
!!                Else
!!                    BREAK
!!                End
!!            End
!!            If (Self.StUtf16.Length()%2) ! odd
!!                Self.StUtf16.Append(Chr(0))
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s8) = False
!!            Self.StUtf16.Append(_divider)
!!            Self.StUtf16.Append(_s8)
!!        ElsIf omitted(_s8) = False
!!            Self.StUtf16.Append(_s8)
!!        End
!!        If PreRemoveTrailingZeros = True
!!            Loop
!!                If Self.StUtf16.Length() < 1
!!                    Break
!!                End
!!                If Self.StUtf16.EndsWith(Chr(0) & Chr(0))
!!                    Self.StUtf16.RemoveFromPosition(Self.StUtf16.Length()-1,2)
!!                Else
!!                    BREAK
!!                End
!!            End
!!            If (Self.StUtf16.Length()%2) ! odd
!!                Self.StUtf16.Append(Chr(0))
!!            End
!!        End
!!
!!        If Self.StUtf16.Length() > 0
!!            If (Self.StUtf16.Length()%2) ! odd
!!                Self.StUtf16.Append(Chr(0))
!!            Else
!!            End
!!
!!            StringRefOut &= NEW String(Self.StUtf16.Length())
!!            StringRefOut = Self.StUtf16.GetValue()
!!
!!            If not Self.BufferStr &= NULL
!!                Dispose(Self.BufferStr)
!!            End
!!            Self.BufferStr &= NEW String(Len(StringRefOut))
!!            Self.BufferStr = StringRefOut
!!            Dispose(StringRefOut)
!!            Return Self.BufferStr
!!        End
!!
!!        Return ''
!!
!!c25_WinApiClass.ConcatAnsi                            Procedure(<Byte _preRemoveTrailingZeros>,<String _divider>,String _s1, String _s2, <String _s3>,  <String _s4>, <String _s5>, <String _s6>, <String _s7>, <String _s8>)
!!
!!StringRefOut                    &String
!!
!!    Code
!!
!!        Self.StAnsi.Start()
!!        Self.StAnsi.encoding = st:EncodeAnsi
!!        Self.StAnsi.CodePage = st:CP_THREAD_ACP
!!        Self.StAnsi.Append(_s1)
!!
!!        If _preRemoveTrailingZeros = True
!!            Loop
!!                If Self.StAnsi.Length() < 1
!!                    Break
!!                End
!!                If Self.StAnsi.EndsWith(Chr(0))
!!                    Self.StAnsi.RemoveFromPosition(Self.StAnsi.Length()-0,1)
!!                Else
!!                    BREAK
!!                End
!!            End
!!        End
!!
!!        If omitted(_divider) = False
!!            Self.StAnsi.Append(_divider)
!!        End
!!        Self.StAnsi.Append(_s2)
!!        If _preRemoveTrailingZeros = True
!!            Loop
!!                If Self.StAnsi.Length() < 1
!!                    Break
!!                End
!!                If Self.StAnsi.EndsWith(Chr(0))
!!                    Self.StAnsi.RemoveFromPosition(Self.StAnsi.Length()-0,1)
!!                Else
!!                    BREAK
!!                End
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s3) = False
!!            Self.StAnsi.Append(_divider)
!!            Self.StAnsi.Append(_s3)
!!        ElsIf omitted(_s3) = False
!!            Self.StAnsi.Append(_s3)
!!        End
!!        If _preRemoveTrailingZeros = True
!!            Loop
!!                If Self.StAnsi.Length() < 1
!!                    Break
!!                End
!!                If Self.StAnsi.EndsWith(Chr(0))
!!                    Self.StAnsi.RemoveFromPosition(Self.StAnsi.Length()-0,1)
!!                Else
!!                    BREAK
!!                End
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s4) = False
!!            Self.StAnsi.Append(_divider)
!!            Self.StAnsi.Append(_s4)
!!        ElsIf omitted(_s4) = False
!!            Self.StAnsi.Append(_s4)
!!        End
!!        If _preRemoveTrailingZeros = True
!!            Loop
!!                If Self.StAnsi.Length() < 1
!!                    Break
!!                End
!!                If Self.StAnsi.EndsWith(Chr(0))
!!                    Self.StAnsi.RemoveFromPosition(Self.StAnsi.Length()-0,1)
!!                Else
!!                    BREAK
!!                End
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s5) = False
!!            Self.StAnsi.Append(_divider)
!!            Self.StAnsi.Append(_s5)
!!        ElsIf omitted(_s5) = False
!!            Self.StAnsi.Append(_s5)
!!        End
!!        If _preRemoveTrailingZeros = True
!!            Loop
!!                If Self.StAnsi.Length() < 1
!!                    Break
!!                End
!!                If Self.StAnsi.EndsWith(Chr(0))
!!                    Self.StAnsi.RemoveFromPosition(Self.StAnsi.Length()-0,1)
!!                Else
!!                    BREAK
!!                End
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s6) = False
!!            Self.StAnsi.Append(_divider)
!!            Self.StAnsi.Append(_s6)
!!        ElsIf omitted(_s6) = False
!!            Self.StAnsi.Append(_s6)
!!        End
!!        If _preRemoveTrailingZeros = True
!!            Loop
!!                If Self.StAnsi.Length() < 1
!!                    Break
!!                End
!!                If Self.StAnsi.EndsWith(Chr(0))
!!                    Self.StAnsi.RemoveFromPosition(Self.StAnsi.Length()-0,1)
!!                Else
!!                    BREAK
!!                End
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s7) = False
!!            Self.StAnsi.Append(_divider)
!!            Self.StAnsi.Append(_s7)
!!        ElsIf omitted(_s7) = False
!!            Self.StAnsi.Append(_s7)
!!        End
!!        If _preRemoveTrailingZeros = True
!!            Loop
!!                If Self.StAnsi.Length() < 1
!!                    Break
!!                End
!!                If Self.StAnsi.EndsWith(Chr(0))
!!                    Self.StAnsi.RemoveFromPosition(Self.StAnsi.Length()-0,1)
!!                Else
!!                    BREAK
!!                End
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s8) = False
!!            Self.StAnsi.Append(_divider)
!!            Self.StAnsi.Append(_s8)
!!        ElsIf omitted(_s8) = False
!!            Self.StAnsi.Append(_s8)
!!        End
!!        If _preRemoveTrailingZeros = True
!!            Loop
!!                If Self.StAnsi.Length() < 1
!!                    Break
!!                End
!!                If Self.StAnsi.EndsWith(Chr(0))
!!                    Self.StAnsi.RemoveFromPosition(Self.StAnsi.Length()-0,1)
!!                Else
!!                    BREAK
!!                End
!!            End
!!        End
!!
!!        If Self.StAnsi.Length() > 0
!!            StringRefOut &= NEW String(Self.StAnsi.Length())
!!            StringRefOut = Self.StAnsi.GetValue()
!!            Return StringRefOut
!!        End
!!
!!        Return NULL
!!
!!c25_WinApiClass.ConcatUtf8                            Procedure(<Byte _preRemoveTrailingZeros>,<String _divider>,String _s1, String _s2, <String _s3>,  <String _s4>, <String _s5>, <String _s6>, <String _s7>, <String _s8>)
!!
!!StringRefOut                    &String
!!
!!    Code
!!
!!        Self.StUtf8.Start()
!!        Self.StUtf8.encoding = st:EncodeUtf8
!!        Self.StUtf8.CodePage = st:CP_UTF8
!!        Self.StUtf8.Append(_s1)
!!
!!        If _preRemoveTrailingZeros = True
!!            Loop
!!                If Self.StUtf8.Length() < 1
!!                    Break
!!                End
!!                If Self.StUtf8.EndsWith(Chr(0))
!!                    Self.StUtf8.RemoveFromPosition(Self.StUtf8.Length()-0,1)
!!                Else
!!                    BREAK
!!                End
!!            End
!!        End
!!
!!        If omitted(_divider) = False
!!            Self.StUtf8.Append(_divider)
!!        End
!!        Self.StUtf8.Append(_s2)
!!        If _preRemoveTrailingZeros = True
!!            Loop
!!                If Self.StUtf8.Length() < 1
!!                    Break
!!                End
!!                If Self.StUtf8.EndsWith(Chr(0))
!!                    Self.StUtf8.RemoveFromPosition(Self.StUtf8.Length()-0,1)
!!                Else
!!                    BREAK
!!                End
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s3) = False
!!            Self.StUtf8.Append(_divider)
!!            Self.StUtf8.Append(_s3)
!!        ElsIf omitted(_s3) = False
!!            Self.StUtf8.Append(_s3)
!!        End
!!        If _preRemoveTrailingZeros = True
!!            Loop
!!                If Self.StUtf8.Length() < 1
!!                    Break
!!                End
!!                If Self.StUtf8.EndsWith(Chr(0))
!!                    Self.StUtf8.RemoveFromPosition(Self.StUtf8.Length()-0,1)
!!                Else
!!                    BREAK
!!                End
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s4) = False
!!            Self.StUtf8.Append(_divider)
!!            Self.StUtf8.Append(_s4)
!!        ElsIf omitted(_s4) = False
!!            Self.StUtf8.Append(_s4)
!!        End
!!        If _preRemoveTrailingZeros = True
!!            Loop
!!                If Self.StUtf8.Length() < 1
!!                    Break
!!                End
!!                If Self.StUtf8.EndsWith(Chr(0))
!!                    Self.StUtf8.RemoveFromPosition(Self.StUtf8.Length()-0,1)
!!                Else
!!                    BREAK
!!                End
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s5) = False
!!            Self.StUtf8.Append(_divider)
!!            Self.StUtf8.Append(_s5)
!!        ElsIf omitted(_s5) = False
!!            Self.StUtf8.Append(_s5)
!!        End
!!        If _preRemoveTrailingZeros = True
!!            Loop
!!                If Self.StUtf8.Length() < 1
!!                    Break
!!                End
!!                If Self.StUtf8.EndsWith(Chr(0))
!!                    Self.StUtf8.RemoveFromPosition(Self.StUtf8.Length()-0,1)
!!                Else
!!                    BREAK
!!                End
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s6) = False
!!            Self.StUtf8.Append(_divider)
!!            Self.StUtf8.Append(_s6)
!!        ElsIf omitted(_s6) = False
!!            Self.StUtf8.Append(_s6)
!!        End
!!        If _preRemoveTrailingZeros = True
!!            Loop
!!                If Self.StUtf8.Length() < 1
!!                    Break
!!                End
!!                If Self.StUtf8.EndsWith(Chr(0))
!!                    Self.StUtf8.RemoveFromPosition(Self.StUtf8.Length()-0,1)
!!                Else
!!                    BREAK
!!                End
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s7) = False
!!            Self.StUtf8.Append(_divider)
!!            Self.StUtf8.Append(_s7)
!!        ElsIf omitted(_s7) = False
!!            Self.StUtf8.Append(_s7)
!!        End
!!        If _preRemoveTrailingZeros = True
!!            Loop
!!                If Self.StUtf8.Length() < 1
!!                    Break
!!                End
!!                If Self.StUtf8.EndsWith(Chr(0))
!!                    Self.StUtf8.RemoveFromPosition(Self.StUtf8.Length()-0,1)
!!                Else
!!                    BREAK
!!                End
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s8) = False
!!            Self.StUtf8.Append(_divider)
!!            Self.StUtf8.Append(_s8)
!!        ElsIf omitted(_s8) = False
!!            Self.StUtf8.Append(_s8)
!!        End
!!        If _preRemoveTrailingZeros = True
!!            Loop
!!                If Self.StUtf8.Length() < 1
!!                    Break
!!                End
!!                If Self.StUtf8.EndsWith(Chr(0))
!!                    Self.StUtf8.RemoveFromPosition(Self.StUtf8.Length()-0,1)
!!                Else
!!                    BREAK
!!                End
!!            End
!!        End
!!
!!        If Self.StUtf8.Length() > 0
!!            StringRefOut &= NEW String(Self.StUtf8.Length())
!!            StringRefOut = Self.StUtf8.GetValue()
!!            Return StringRefOut
!!        Else
!!            StringRefOut &= NEW String(6)
!!            StringRefOut = '<NULL>'
!!            Return StringRefOut
!!        End
!!
!!        Return NULL
!!
!!c25_WinApiClass.ConcatUtf16                           Procedure(<Byte _preRemoveTrailingZeros>,<String _divider>,String _s1, String _s2, <String _s3>,  <String _s4>, <String _s5>, <String _s6>, <String _s7>, <String _s8>)
!!
!!StringRefOut                    &String
!!PreRemoveTrailingZeros          Byte
!!
!!    Code
!!
!!        PreRemoveTrailingZeros = _preRemoveTrailingZeros
!!        PreRemoveTrailingZeros = False ! not working yet
!!        Self.StUtf16.Start()
!!        Self.StUtf16.encoding = st:EncodeUtf16
!!        Self.StUtf16.Append(_s1)
!!
!!        If PreRemoveTrailingZeros = True
!!            Loop
!!                If Self.StUtf16.Length() < 1
!!                    Break
!!                End
!!                If Self.StUtf16.EndsWith(Chr(0) & Chr(0))
!!                    Self.StUtf16.RemoveFromPosition(Self.StUtf16.Length()-1,2)
!!                Else
!!                    BREAK
!!                End
!!            End
!!            If (Self.StUtf16.Length()%2) ! odd
!!                Self.StUtf16.Append(Chr(0))
!!            End
!!        End
!!
!!        If omitted(_divider) = False
!!            Self.StUtf16.Append(_divider)
!!        End
!!        Self.StUtf16.Append(_s2)
!!        If PreRemoveTrailingZeros = True
!!            Loop
!!                If Self.StUtf16.Length() < 1
!!                    Break
!!                End
!!                If Self.StUtf16.EndsWith(Chr(0) & Chr(0))
!!                    Self.StUtf16.RemoveFromPosition(Self.StUtf16.Length()-1,2)
!!                Else
!!                    BREAK
!!                End
!!            End
!!            If (Self.StUtf16.Length()%2) ! odd
!!                Self.StUtf16.Append(Chr(0))
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s3) = False
!!            Self.StUtf16.Append(_divider)
!!            Self.StUtf16.Append(_s3)
!!        ElsIf omitted(_s3) = False
!!            Self.StUtf16.Append(_s3)
!!        End
!!        If PreRemoveTrailingZeros = True
!!            Loop
!!                If Self.StUtf16.Length() < 1
!!                    Break
!!                End
!!                If Self.StUtf16.EndsWith(Chr(0) & Chr(0))
!!                    Self.StUtf16.RemoveFromPosition(Self.StUtf16.Length()-1,2)
!!                Else
!!                    BREAK
!!                End
!!            End
!!            If (Self.StUtf16.Length()%2) ! odd
!!                Self.StUtf16.Append(Chr(0))
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s4) = False
!!            Self.StUtf16.Append(_divider)
!!            Self.StUtf16.Append(_s4)
!!        ElsIf omitted(_s4) = False
!!            Self.StUtf16.Append(_s4)
!!        End
!!        If PreRemoveTrailingZeros = True
!!            Loop
!!                If Self.StUtf16.Length() < 1
!!                    Break
!!                End
!!                If Self.StUtf16.EndsWith(Chr(0) & Chr(0))
!!                    Self.StUtf16.RemoveFromPosition(Self.StUtf16.Length()-1,2)
!!                Else
!!                    BREAK
!!                End
!!            End
!!            If (Self.StUtf16.Length()%2) ! odd
!!                Self.StUtf16.Append(Chr(0))
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s5) = False
!!            Self.StUtf16.Append(_divider)
!!            Self.StUtf16.Append(_s5)
!!        ElsIf omitted(_s5) = False
!!            Self.StUtf16.Append(_s5)
!!        End
!!        If PreRemoveTrailingZeros = True
!!            Loop
!!                If Self.StUtf16.Length() < 1
!!                    Break
!!                End
!!                If Self.StUtf16.EndsWith(Chr(0) & Chr(0))
!!                    Self.StUtf16.RemoveFromPosition(Self.StUtf16.Length()-1,2)
!!                Else
!!                    BREAK
!!                End
!!            End
!!            If (Self.StUtf16.Length()%2) ! odd
!!                Self.StUtf16.Append(Chr(0))
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s6) = False
!!            Self.StUtf16.Append(_divider)
!!            Self.StUtf16.Append(_s6)
!!        ElsIf omitted(_s6) = False
!!            Self.StUtf16.Append(_s6)
!!        End
!!        If PreRemoveTrailingZeros = True
!!            Loop
!!                If Self.StUtf16.Length() < 1
!!                    Break
!!                End
!!                If Self.StUtf16.EndsWith(Chr(0) & Chr(0))
!!                    Self.StUtf16.RemoveFromPosition(Self.StUtf16.Length()-1,2)
!!                Else
!!                    BREAK
!!                End
!!            End
!!            If (Self.StUtf16.Length()%2) ! odd
!!                Self.StUtf16.Append(Chr(0))
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s7) = False
!!            Self.StUtf16.Append(_divider)
!!            Self.StUtf16.Append(_s7)
!!        ElsIf omitted(_s7) = False
!!            Self.StUtf16.Append(_s7)
!!        End
!!        If PreRemoveTrailingZeros = True
!!            Loop
!!                If Self.StUtf16.Length() < 1
!!                    Break
!!                End
!!                If Self.StUtf16.EndsWith(Chr(0) & Chr(0))
!!                    Self.StUtf16.RemoveFromPosition(Self.StUtf16.Length()-1,2)
!!                Else
!!                    BREAK
!!                End
!!            End
!!            If (Self.StUtf16.Length()%2) ! odd
!!                Self.StUtf16.Append(Chr(0))
!!            End
!!        End
!!
!!        If omitted(_divider) = False And omitted(_s8) = False
!!            Self.StUtf16.Append(_divider)
!!            Self.StUtf16.Append(_s8)
!!        ElsIf omitted(_s8) = False
!!            Self.StUtf16.Append(_s8)
!!        End
!!        If PreRemoveTrailingZeros = True
!!            Loop
!!                If Self.StUtf16.Length() < 1
!!                    Break
!!                End
!!                If Self.StUtf16.EndsWith(Chr(0) & Chr(0))
!!                    Self.StUtf16.RemoveFromPosition(Self.StUtf16.Length()-1,2)
!!                Else
!!                    BREAK
!!                End
!!            End
!!            If (Self.StUtf16.Length()%2) ! odd
!!                Self.StUtf16.Append(Chr(0))
!!            End
!!        End
!!
!!        If Self.StUtf16.Length() > 0
!!            If (Self.StUtf16.Length()%2) ! odd
!!                Self.StUtf16.Append(Chr(0))
!!            Else
!!            End
!!            StringRefOut &= NEW String(Self.StUtf16.Length())
!!            StringRefOut = Self.StUtf16.GetValue()
!!
!!            Return StringRefOut
!!        End
!!
!!        Return NULL
!!
!!c25_WinApiClass.AnsiToUtf8                            Procedure(String _ansi)
!!
!!StringRefOut &String
!!
!!    Code
!!
!!        Self.StAnsiToUtf8.Start()
!!        Self.StAnsiToUtf8.encoding = st:EncodeAnsi
!!        Self.StAnsiToUtf8.codepage = st:CP_ACP
!!
!!        Self.StAnsiToUtf8.SetValue(clip(_ansi))
!!        Self.StAnsiToUtf8.ToUnicode(st:EncodeUtf8)
!!
!!        If Self.StAnsiToUtf8.Length() > 0
!!            StringRefOut &= NEW String(Self.StAnsiToUtf8.Length())
!!            StringRefOut = Self.StAnsiToUtf8.GetValue()
!!            Return StringRefOut
!!        ELSE
!!            Return NULL
!!        End
!!
!!c25_WinApiClass.AnsiToUtf8GetLength                   Procedure(String _ansi)
!!
!!StringRefOut                                    &String
!!
!!    Code
!!
!!        StringRefOut &= Self.BitConverterClass.AnsiToUtf8(_ansi)
!!        If StringRefOut &= NULL
!!            Return 0
!!        End
!!        L# = Len(StringRefOut)
!!        Dispose(StringRefOut)
!!        Return L#
!!
!!c25_WinApiClass.AnsiToUtf16                           Procedure(String _ansi, <Byte _debug>)
!!
!!StringRefOut &String
!!
!!    Code
!!
!!        If Size(_ansi) < 1 or Size(_ansi) > 2000000 Or Len(Clip(_ansi)) < 1
!!            Return NULL
!!        End
!!        StringRefOut &= NEW String(Len(Clip(_ansi)))
!!
!!        Self.StAnsiToUtf16.Start()
!!
!!        Self.StAnsiToUtf16.encoding = st:EncodeAnsi
!!        Self.StAnsiToUtf16.codepage = st:CP_ACP
!!
!!        Self.StAnsiToUtf16.Append(_ansi)
!!        If _debug
!!            Message('done Self.StAnsiToUtf16.Append(_ansi)')
!!        End
!!        Self.StAnsiToUtf16.ToUnicode(st:EncodeUtf16)
!!        If _debug
!!            Message('done Self.StAnsiToUtf16.Append(_ansi)')
!!        End
!!        If _debug
!!            Message('Self.StAnsiToUtf16.Length() ' & Self.StAnsiToUtf16.Length())
!!        End
!!        If Self.StAnsiToUtf16.Length() > 0
!!            StringRefOut &= NEW String(Self.StAnsiToUtf16.Length())
!!            StringRefOut = Self.StAnsiToUtf16.GetValue()
!!            If _debug
!!                Message('Return stringrefout')
!!            End
!!            Return StringRefOut
!!        ELSE
!!            If _debug
!!                Message('Return null')
!!            End
!!            Return NULL
!!        End
!!        Return NULL
!!
!!c25_WinApiClass.AnsiToUtf16GetLength                  Procedure(String _ansi)
!!
!!StringRefOut                                    &String
!!
!!    Code
!!
!!        StringRefOut &= Self.BitConverterClass.AnsiToUtf16(_ansi)
!!        If StringRefOut &= NULL
!!            Return 0
!!        End
!!        L# = Len(StringRefOut)
!!        Dispose(StringRefOut)
!!        Return L#
!!
!!c25_WinApiClass.MultiSzZeroToCRLFUtf16Str             Procedure(String _utf16)
!!
!!    Code
!!
!!        If not Self.ReturnString &= NULL
!!            Dispose(Self.ReturnString)
!!        End
!!        Self.ReturnString &= Self.MultiSzZeroToCRLFUtf16(_utf16)
!!        If Self.ReturnString &= NULL
!!            Return ''
!!        End
!!        Return Clip(Self.ReturnString)
!!
!!c25_WinApiClass.MultiSzZeroToCRLFUtf16                Procedure(String _utf16)
!!
!!CroppedUtf16        &String
!!StringRefOut        &String
!!
!!    Code
!!
!!        CroppedUtf16 &= Self.CropZerosUtf16(_utf16)
!!
!!        L# = Len(CroppedUtf16)
!!        If L# < 2
!!            Return null
!!        End
!!
!!        Self.StUtf16.Start()
!!        Self.StUtf16.encoding = st:EncodeUtf16
!!
!!        P# = -1
!!        Loop
!!            P# = P# + 2
!!            If P# >= L#
!!                BREAK
!!            End
!!            If P# + 3 =< L#
!!                If CroppedUtf16[P# : P# + 3] = Chr(0) & Chr(0) & Chr(0) & Chr(0)
!!                    BREAK
!!                End
!!            End
!!            If CroppedUtf16[P# : P# + 1] = Chr(0) & Chr(0)
!!                Self.StUtf16.Append(Chr(13) & Chr(0) & Chr(10) & Chr(0))
!!            Else
!!                Self.StUtf16.Append(CroppedUtf16[P# : P# + 1])
!!            End
!!        End
!!        Self.StUtf16.Append(Chr(13) & Chr(0) & Chr(10) & Chr(0))
!!        Dispose(CroppedUtf16)
!!
!!        If Self.StUtf16.Length() < 1
!!            Return NULL
!!        End
!!        StringRefOut &= NEW String(Self.StUtf16.Length())
!!        StringRefOut = Self.StUtf16.GetValue()
!!
!!        Return StringRefOut
!!
!!c25_WinApiClass.CropZerosAnsi                         Procedure(String _ansi)
!!
!!StringRefOut        &String
!!
!!    Code
!!
!!        If Len(_ansi) < 1
!!            Return NULL
!!        End
!!
!!        L# = Len(Self.CropZerosAnsiStr(_ansi))
!!        If L# < 1
!!            Return NULL
!!        End
!!        StringRefOut &= NEW String(L#)
!!        StringRefOut = Self.CropZerosAnsiStr(_ansi)
!!
!!        Return StringRefOut
!!
!!c25_WinApiClass.CropZerosAnsiStr                      Procedure(String _ansi)
!!
!!    Code
!!
!!        P# = Len(Clip(_ansi)) + 1
!!        Loop
!!            P# = P# - 1
!!            If P# < 1
!!                Return ''
!!            ELSE
!!                If _ansi[P#] = Chr(0)
!!                    Cycle
!!                ELSE
!!                    If P# = 1
!!                        Return _ansi[P#]
!!                    ELSE
!!                        Return _ansi[1 : P#]
!!                    End
!!                End
!!            End
!!        End
!!        Return ''
!!
!!c25_WinApiClass.CropZerosUtf8                         Procedure(String _utf8)
!!
!!StringRefOut        &String
!!
!!    Code
!!
!!        If LEN(CLIP(_utf8)) < 1
!!            Return NULL
!!        End
!!        StringRefOut        &= NEW String(LEN(CLIP(_utf8)))
!!        StringRefOut        = Self.CropZerosAnsiStr(_utf8)
!!        Return StringRefOut
!!
!!c25_WinApiClass.CropZerosUtf8Str                      Procedure(String _utf8)
!!
!!    Code
!!
!!        Return Self.CropZerosAnsiStr(_utf8)
!!
!!c25_WinApiClass.CropZerosUtf16                        Procedure(String _utf16)
!!
!!StringRefOut        &String
!!
!!    Code
!!
!!        If Len(_utf16) < 1
!!            Return NULL
!!        End
!!
!!        L# = Len(Self.CropZerosUtf16Str(_utf16))
!!        If L# < 2
!!            Return NULL
!!        End
!!        StringRefOut &= NEW String(L#)
!!        StringRefOut = Self.CropZerosUtf16Str(_utf16)
!!
!!        Return StringRefOut
!!
!!c25_WinApiClass.CropZerosUtf16Str                     Procedure(String _utf16)
!!
!!    Code
!!
!!        P# = Len(Clip(_utf16)) + 1
!!        LOOP
!!            P# = P# - 1
!!            If P# < 1
!!                Return ''
!!            ELSE
!!                If _utf16[P#] = Chr(0)
!!                    Cycle
!!                ELSE
!!                    If P# = 1
!!                        Return _utf16[1] & Chr(0)
!!                    Else
!!                        If (P#%2) ! odd
!!                            Return _utf16[1 : P#] & Chr(0)
!!                        Else
!!                            Return _utf16[1 : P#]
!!                        End
!!                    End
!!                End
!!            End
!!        End
!!        Return ''
!!
!!c25_WinApiClass.Utf8ToAnsi                            Procedure(String _utf8)
!!
!!StringRefOut &String
!!
!!    Code
!!
!!        If Len(Clip(_utf8)) < 1
!!            Return NULL
!!        End
!!        Self.StUtf8ToAnsi.Start()
!!        Self.StUtf8ToAnsi.encoding = st:EncodeUtf8
!!        Self.StUtf8ToAnsi.codepage = st:CP_UTF8
!!
!!        Self.StUtf8ToAnsi.SetValue(clip(_utf8))
!!        Self.StUtf8ToAnsi.ToAnsi()
!!
!!        If Self.StUtf8ToAnsi.Length() > 0
!!            StringRefOut &= NEW String(Self.StUtf8ToAnsi.Length())
!!            StringRefOut = Self.StUtf8ToAnsi.GetValue()
!!            Return StringRefOut
!!        ELSE
!!            Return NULL
!!        End
!!
!!c25_WinApiClass.Utf8ToUtf8                            Procedure(String _utf8)
!!
!!StringRefOut                        &String
!!
!!    Code
!!
!!        If Len(_utf8) < 1
!!            Return NULL
!!        End
!!
!!        StringRefOut &= NEW String(Len(_utf8))
!!        StringRefOut = _utf8
!!        Return StringRefOut
!!
!!c25_WinApiClass.Utf8ToUtf16                           Procedure(String _utf8)
!!
!!StringRefOut &String
!!
!!    Code
!!
!!        If Len(Clip(_utf8)) < 1
!!            Return NULL
!!        End
!!        Self.StUtf8ToUtf16.Start()
!!        Self.StUtf8ToUtf16.encoding = st:EncodeUtf8
!!        Self.StUtf8ToUtf16.codepage = st:CP_UTF8
!!
!!        Self.StUtf8ToUtf16.SetValue(clip(_utf8))
!!        Self.StUtf8ToUtf16.ToUnicode(st:EncodeUtf16)
!!
!!        If Self.StUtf8ToUtf16.Length() > 0
!!            StringRefOut &= NEW String(Self.StUtf8ToUtf16.Length())
!!            StringRefOut = Self.StUtf8ToUtf16.GetValue()
!!            Return StringRefOut
!!        ELSE
!!            Return NULL
!!        End
!!
!!c25_WinApiClass.Utf16ToUtf8                           Procedure(String _utf16)
!!
!!StringRefOut &String
!!
!!    Code
!!
!!        If Len(_utf16) < 2
!!            Return NULL
!!        End
!!
!!        Self.StUtf16ToUtf8.Start()
!!        Self.StUtf16ToUtf8.encoding = st:EncodeUtf16
!!
!!        Self.StUtf16ToUtf8.SetValue(_utf16)
!!        Self.StUtf16ToUtf8.ToUnicode(st:EncodeUtf8)
!!
!!        If Self.StUtf16ToUtf8.Length() > 0
!!            StringRefOut &= NEW String(Self.StUtf16ToUtf8.Length())
!!            StringRefOut = Self.StUtf16ToUtf8.GetValue()
!!            Return StringRefOut
!!        ELSE
!!            Return NULL
!!        End
!!
!!c25_WinApiClass.Utf16ToUtf16                          Procedure(String _utf16)
!!
!!StringRefOut                        &String
!!
!!    Code
!!
!!        If Len(clip(_utf16)) < 2
!!            Return NULL
!!        End
!!
!!        StringRefOut &= NEW String(Len(clip(_utf16)))
!!        StringRefOut = _utf16
!!        Return StringRefOut
!!
!!c25_WinApiClass.BlobToBlob                            Procedure(String _blob)
!!
!!StringRefOut                    &String
!!
!!    Code
!!
!!        If Len(_blob) < 1
!!            Return null
!!        End
!!
!!        StringRefOut &= NEW String(Len(_blob))
!!        StringRefOut = _blob
!!        Return StringRefOut
!!
!!c25_WinApiClass.BlobToBlob                            Procedure(*String _blob)
!!
!!StringRefOut                    &String
!!
!!    Code
!!
!!        If Len(_blob) < 1
!!            Return NULL
!!        End
!!
!!        StringRefOut &= NEW String(Len(_blob))
!!        StringRefOut = _blob
!!        Return StringRefOut
!!
!!c25_WinApiClass.BinaryCopy                            Procedure(String _binary)
!!
!!StringRefOut                    &String
!!
!!    Code
!!
!!        If Size(_binary) < 1
!!            Return NULL
!!        End
!!        StringRefOut &= NEW String(Size(_binary))
!!        StringRefOut = _binary
!!        Return StringRefOut
!!
!!c25_WinApiClass.AnsiToAnsi                            Procedure(String _ansi)
!!
!!StringRefOut                    &String
!!
!!    Code
!!
!!        If Size(_ansi) < 1 or Size(_ansi) > 2000000 Or Len(Clip(_ansi)) < 1
!!            Return NULL
!!        End
!!        StringRefOut &= NEW String(Len(Clip(_ansi)))
!!        StringRefOut = _ansi
!!
!!        Return StringRefOut
!!
!!c25_WinApiClass.Utf16ToUtf8GetLength                  Procedure(String _utf16)
!!
!!StringRefOut                                    &String
!!
!!    Code
!!
!!        If len(clip(_utf16)) < 1
!!            Return 0
!!        End
!!        StringRefOut &= Self.BitConverterClass.Utf16ToUtf8(clip(_utf16))
!!        L# = Len(StringRefOut)
!!        Dispose(StringRefOut)
!!        Return L#
!!
!!c25_WinApiClass.Utf16ToAnsi                           Procedure(String _utf16)
!!
!!StringRefOut &String
!!StUtf16ToAnsi &StringTheory()
!!
!!    Code
!!
!!        StUtf16ToAnsi &= NEW StringTheory()
!!
!!        StUtf16ToAnsi.Start()
!!        StUtf16ToAnsi.encoding = st:EncodeUtf16
!!
!!        If Len(Clip(_utf16)) > 1
!!            StUtf16ToAnsi.SetValue(Clip(_utf16) )
!!            StUtf16ToAnsi.ToAnsi(st:EncodeUtf16)
!!
!!            StringRefOut &= NEW String(StUtf16ToAnsi.Length())
!!            StringRefOut = StUtf16ToAnsi.GetValue()
!!            Dispose(StUtf16ToAnsi)
!!            Return StringRefOut
!!        End
!!        Dispose(StUtf16ToAnsi)
!!        Return NULL
!!
!!c25_WinApiClass.Utf16ToAnsiStr                        Procedure(String _utf16)
!!
!!    Code
!!
!!        If Len(clip(_utf16)) < 1
!!            Return ''
!!        End
!!
!!        Self.StUtf16ToAnsi.Start()
!!        Self.StUtf16ToAnsi.encoding = st:EncodeUtf16
!!
!!        Self.StUtf16ToAnsi.SetValue(clip(_utf16))
!!        Self.StUtf16ToAnsi.ToAnsi(st:EncodeUtf16)
!!
!!        Return Self.StUtf16ToAnsi.GetValue()
!!
!!c25_WinApiClass.Utf16ToAnsiGetLength                  Procedure(String _utf16)
!!
!!StringRefOut                                    &String
!!
!!    Code
!!
!!        StringRefOut &= Self.BitConverterClass.Utf16ToAnsi(_utf16)
!!        L# = Len(StringRefOut)
!!        Dispose(StringRefOut)
!!        Return L#
!!
!!c25_WinApiClass.UuidCreateA                           Procedure(<Byte _lowerCase>)
!!
!!AliasGuidString                 String(36)
!!AliasGuidCStringPtr             Long
!!GuidBlob16                      String(16)
!!PtrUuid                         Long
!!
!!    Code
!!
!!        CLEAR(GuidBlob16,-1)
!!        CLEAR(AliasGuidString)
!!        c25_UuidCreate(Address(GuidBlob16))
!!        c25_uuidtostringa(Address(GuidBlob16), Address(AliasGuidCStringPtr))
!!        Peek(AliasGuidCStringPtr,AliasGuidString)
!!        If _lowerCase
!!            Return Lower(AliasGuidString)
!!        End
!!        Return Upper(AliasGuidString)
!!
!!c25_WinApiClass.UuidCreateSequential                  Procedure(<Byte _lowerCase>)
!!
!!AliasGuidString                 String(36)
!!AliasGuidCStringPtr             Long
!!GuidBlob16                      String(16)
!!PtrUuid                         Long
!!
!!    Code
!!
!!        CLEAR(GuidBlob16,-1)
!!        CLEAR(AliasGuidString)
!!        c25_UuidCreateSequential(Address(GuidBlob16))
!!        c25_uuidtostringa(Address(GuidBlob16), Address(AliasGuidCStringPtr))
!!        Peek(AliasGuidCStringPtr,AliasGuidString)
!!        If _lowerCase
!!            Return Lower(AliasGuidString)
!!        End
!!        Return Upper(AliasGuidString)
!!
!!c25_WinApiClass.UuidToString                          Procedure(String _bytes16)
!!
!!AliasGuidString                     String(36)
!!OutBuffer                           String(128)
!!AliasGuidCStringPtr                 Long
!!GuidBlob16                          String(16)
!!
!!    Code
!!
!!        GuidBlob16 = _bytes16
!!        c25_uuidtostringa(Address(GuidBlob16), Address(AliasGuidCStringPtr))
!!        If AliasGuidCStringPtr <> 0
!!            c25_MemCpy(Address(OutBuffer),AliasGuidCStringPtr,36)
!!            c25_RpcStringFreeA(Address(AliasGuidCStringPtr))
!!            AliasGuidString = OutBuffer
!!            Return Upper(AliasGuidString)
!!        End
!!        Return '00000000-0000-0000-0000-000000000000'
!!
!!c25_WinApiClass.BufferToByteQ Procedure(<String _buffer>, <Long _startAddress>,<Long _expectedLength>,<String _fileName>)
!!
!!BytesQ                          QUEUE,Pre(BytesQ)
!!Ordinal                             Long
!!Pos                                 Long
!!Address                             Long
!!ValChar                             String(1)
!!ValHex                              String(2)
!!ValNum                              Byte
!!BadPtr                              Byte
!!                                End
!!Line512                         String(512)
!!
!!    Code
!!
!!        If omitted(_startAddress) = False
!!            If _startAddress = 0
!!                Return ''
!!            End
!!            A# = _startAddress
!!        End
!!        If omitted(_buffer) = False
!!            If Size(_buffer) = 0
!!                Return ''
!!            End
!!            A# = Address(_buffer)
!!        End
!!
!!        O# = -1
!!        P# = 0
!!        LOOP !1 Times
!!            O# = O# + 1
!!            P# = P# + 1
!!            If omitted(_expectedLength) = False
!!                If P# > _expectedLength
!!                    BREAK
!!                End
!!            End
!!            BytesQ.Ordinal   = O#
!!            BytesQ.Pos       = P#
!!            BytesQ.Address   = A# + O#
!!            If c25_IsBadreadPtr(BytesQ.Address,1) = True
!!                BytesQ.BadPtr = TRUE
!!                Add(BytesQ)
!!                BREAK
!!            End
!!            Peek(BytesQ.Address,BytesQ.ValChar)
!!            Peek(BytesQ.Address,BytesQ.ValNum)
!!            BytesQ.ValHex    = BYTETOHEX(BytesQ.ValNum,0)
!!            Add(BytesQ)
!!        End
!!
!!        Self.st1.Start()
!!        I# = 0
!!        Loop Records(BytesQ) Times
!!            I# = I# + 1
!!            Get(BytesQ,I#)
!!            Clear(Line512)
!!            Line512[1 : 10] = BytesQ.Ordinal
!!            Line512[12] = '|'
!!            Line512[14 : 24] = BytesQ.Pos
!!            Line512[26] = '|'
!!            Line512[28 : 38] = BytesQ.Address
!!            Line512[40] = '|'
!!            Line512[42 : 52] = BytesQ.ValChar
!!            Line512[54] = '|'
!!            Line512[56 : 66] = BytesQ.ValNum
!!            Line512[68] = '|'
!!            Line512[70 : 80] = BytesQ.ValHex
!!            Line512[82] = '|'
!!            If BytesQ.BadPtr = TRUE
!!                Line512[84 : 100] = 'BAD PTR'
!!            End
!!            Self.st1.Append(Clip(Line512) & Chr(13) & Chr(10))
!!        End
!!        If omitted(_fileName) = False
!!            Self.st1.SaveFile(_fileName)
!!        Else
!!            SETCLIPBOARD(Self.st1.GetValue())
!!        End
!!
!!        Return ''
!!
!!c25_WinApiClass.ParseZeroTerminatedStringA         Procedure(Long _ptr, <Byte _excludeTermZero>, <Byte _debug>)
!!
!!FakeRef                                                 &String
!!
!!    Code
!!
!!        If _debug
!!            Message('start ParseZeroTerminatedStringA')
!!        End
!!
!!        If _ptr = 0
!!            Return ''
!!        End
!!
!!        Self.AddressPtr = _ptr - 1
!!        Loop 64000000 Times
!!            Self.AddressPtr = Self.AddressPtr + 1
!!            If _debug
!!            End
!!            If c25_IsBadReadPtr(Self.AddressPtr,1)
!!                Return ''
!!            End
!!            Peek(Self.AddressPtr,Self.ByteOut)
!!            If _debug
!!            End
!!            If Self.ByteOut = 0
!!                Break
!!            End
!!        End
!!        If _excludeTermZero = True
!!            Self.BufferLength = Self.AddressPtr - _ptr
!!        Else
!!            Self.BufferLength = Self.AddressPtr - _ptr + 1
!!        End
!!        If Self.BufferLength < 1
!!            Return ''
!!        End
!!
!!        If not Self.ReturnString &= NULL
!!            If _debug
!!                Message('try Dispose(Self.ReturnString)')
!!            End
!!            If _debug
!!                Message('Self.ReturnString : ' & Self.ReturnString)
!!            End
!!            FakeRef &= Self.ReturnString
!!            Self.ReturnString &= null
!!            Dispose(FakeRef)
!!            If _debug
!!                Message('try Dispose(Self.ReturnString) OK')
!!            End
!!        End
!!
!!        Self.ReturnString &= NEW String(Self.BufferLength)
!!        If _debug
!!            Message('Self.BufferLength ' & Self.BufferLength)
!!        End
!!
!!        c25_MemCpy(Address(Self.ReturnString),_ptr,Self.BufferLength)
!!
!!        If _debug
!!            Message('will Return : ' & Self.ReturnString)
!!        End
!!
!!        Return Self.ReturnString
!!
!!c25_WinApiClass.ParseZeroTerminatedUtf16String        Procedure(Long _address, Long _getLengthOrBufferLen, <Byte _excludeTermZero>,<Byte _skipReturnString>)
!!
!!    Code
!!
!!        If _getLengthOrBufferLen = -1 Or _getLengthOrBufferLen = 0
!!            Self.AddressPtr = _address - 2
!!            Loop 64000000 Times
!!                Self.AddressPtr = Self.AddressPtr + 2
!!                Peek(Self.AddressPtr,Self.ShortOut)
!!                If Self.ShortOut = 0
!!                    Break
!!                End
!!            End
!!            If _excludeTermZero = 1
!!                Self.BufferLength = Self.AddressPtr - _address
!!            Else
!!                Self.BufferLength = Self.AddressPtr - _address + 2
!!            End
!!            If _getLengthOrBufferLen = -1
!!                Return Self.BufferLength
!!            End
!!        End
!!        If _getLengthOrBufferLen > 0
!!            Self.BufferLength = _getLengthOrBufferLen
!!        End
!!        If Self.BufferLength < 2000001
!!            If not Self.ReturnString &= NULL
!!                Dispose(Self.ReturnString)
!!            End
!!            Self.ReturnString &= NEW String(Self.BufferLength)
!!            c25_MemCpy(Address(Self.ReturnString),_address,Self.BufferLength)
!!            If _skipReturnString = 1
!!                Return ''
!!            End
!!            Return Self.ReturnString
!!        End
!!
!!        Return ''
!!
        
        
        
        

        
        
        
        
        
        
c25_WinApiClass.GetKnownPathEnumNameById    Procedure(string _knownFolderId)

    CODE

        
        
    Case _knownFolderId


    Of KnownFolderId_AccountPictures
        Return 'AccountPictures'
    Of KnownFolderId_AddNewPrograms
        Return 'AddNewPrograms'
    Of KnownFolderId_AdminTools
        Return 'AdminTools'
    Of KnownFolderId_AppMods
        Return 'AppMods'
    Of KnownFolderId_AppCaptures
        Return 'AppCaptures'
    Of KnownFolderId_AppDataDesktop
        Return 'AppDataDesktop'
    Of KnownFolderId_AppDataDocuments
        Return 'AppDataDocuments'
    Of KnownFolderId_AppDataFavorites
        Return 'AppDataFavorites'
    Of KnownFolderId_AppDataProgramData
        Return 'AppDataProgramData'
    Of KnownFolderId_ApplicationShortcuts
        Return 'ApplicationShortcuts'
    Of KnownFolderId_AppsFolder
        Return 'AppsFolder'
    Of KnownFolderId_AppUpdates
        Return 'AppUpdates'
    Of KnownFolderId_CameraRollLibrary
        Return 'CameraRollLibrary'
    Of KnownFolderId_CdBurning
        Return 'CdBurning'
    Of KnownFolderId_ChangeRemovePrograms
        Return 'ChangeRemovePrograms'
    Of KnownFolderId_CommonAdminTools
        Return 'CommonAdminTools'
    Of KnownFolderId_CommonOemLinks
        Return 'CommonOemLinks'
    Of KnownFolderId_CommonPrograms
        Return 'CommonPrograms'
    Of KnownFolderId_CommonStartMenu
        Return 'CommonStartMenu'
    Of KnownFolderId_CommonStartMenuPlaces
        Return 'CommonStartMenuPlaces'
    Of KnownFolderId_CommonStartup
        Return 'CommonStartup'
    Of KnownFolderId_CommonTemplates
        Return 'CommonTemplates'
    Of KnownFolderId_ComputerFolder
        Return 'ComputerFolder'
    Of KnownFolderId_ConflictFolder
        Return 'ConflictFolder'
    Of KnownFolderId_ConnectionsFolder
        Return 'ConnectionsFolder'
    Of KnownFolderId_Contacts
        Return 'Contacts'
    Of KnownFolderId_ControlPanelFolder
        Return 'ControlPanelFolder'
    Of KnownFolderId_Cookies
        Return 'Cookies'
    Of KnownFolderId_CurrentAppMods
        Return 'CurrentAppMods'
    Of KnownFolderId_Desktop
        Return 'Desktop'
    Of KnownFolderId_DevelopmentFiles
        Return 'DevelopmentFiles'
    Of KnownFolderId_Device
        Return 'Device'
    Of KnownFolderId_DeviceMetaDatastore
        Return 'DeviceMetaDatastore'
    Of KnownFolderId_Documents
        Return 'Documents'
    Of KnownFolderId_DocumentsLibrary
        Return 'DocumentsLibrary'
    Of KnownFolderId_Downloads
        Return 'Downloads'
    Of KnownFolderId_Favorites
        Return 'Favorites'
    Of KnownFolderId_Fonts
        Return 'Fonts'
    Of KnownFolderId_Games
        Return 'Games'
    Of KnownFolderId_GameTasks
        Return 'GameTasks'
    Of KnownFolderId_History
        Return 'History'
    Of KnownFolderId_HomeGroup
        Return 'HomeGroup'
    Of KnownFolderId_HomeGroupCurrentUser
        Return 'HomeGroupCurrentUser'
    Of KnownFolderId_ImplicitAppShortcuts
        Return 'ImplicitAppShortcuts'
    Of KnownFolderId_InternetCache
        Return 'InternetCache'
    Of KnownFolderId_InternetFolder
        Return 'InternetFolder'
    Of KnownFolderId_Libraries
        Return 'Libraries'
    Of KnownFolderId_Links
        Return 'Links'
    Of KnownFolderId_LocalAppData
        Return 'LocalAppData'
    Of KnownFolderId_LocalAppDataLow
        Return 'LocalAppDataLow'
    Of KnownFolderId_LocalDocuments
        Return 'LocalDocuments'
    Of KnownFolderId_LocalDownloads
        Return 'LocalDownloads'
    Of KnownFolderId_LocalizedResourcesDir
        Return 'LocalizedResourcesDir'
    Of KnownFolderId_LocalMusic
        Return 'LocalMusic'
    Of KnownFolderId_LocalPictures
        Return 'LocalPictures'
    Of KnownFolderId_LocalVideos
        Return 'LocalVideos'
    Of KnownFolderId_Music
        Return 'Music'
    Of KnownFolderId_MusicLibrary
        Return 'MusicLibrary'
    Of KnownFolderId_Nethood
        Return 'Nethood'
    Of KnownFolderId_NetworkFolder
        Return 'NetworkFolder'
    Of KnownFolderId_Objects3D
        Return 'Objects3D'
    Of KnownFolderId_OneDrive
        Return 'OneDrive'
    Of KnownFolderId_OriginalImages
        Return 'OriginalImages'
    Of KnownFolderId_PhotoAlbums
        Return 'PhotoAlbums'
    Of KnownFolderId_Pictures
        Return 'Pictures'
    Of KnownFolderId_PicturesLibrary
        Return 'PicturesLibrary'
    Of KnownFolderId_PlayLists
        Return 'PlayLists'
    Of KnownFolderId_PrintersFolder
        Return 'PrintersFolder'
    Of KnownFolderId_Printhood
        Return 'Printhood'
    Of KnownFolderId_Profile
        Return 'Profile'
    Of KnownFolderId_ProgramData
        Return 'ProgramData'
    Of KnownFolderId_ProgramFiles
        Return 'ProgramFiles'
    Of KnownFolderId_ProgramFilesCommon
        Return 'ProgramFilesCommon'
    Of KnownFolderId_ProgramFilesCommonX64
        Return 'ProgramFilesCommonX64'
    Of KnownFolderId_ProgramFilesCommonX86
        Return 'ProgramFilesCommonX86'
    Of KnownFolderId_ProgramFilesX64
        Return 'ProgramFilesX64'
    Of KnownFolderId_ProgramFilesX86
        Return 'ProgramFilesX86'
    Of KnownFolderId_Programs
        Return 'Programs'
    Of KnownFolderId_Public
        Return 'Public'
    Of KnownFolderId_PublicDesktop
        Return 'PublicDesktop'
    Of KnownFolderId_PublicDocuments
        Return 'PublicDocuments'
    Of KnownFolderId_PublicDownloads
        Return 'PublicDownloads'
    Of KnownFolderId_PublicGametasks
        Return 'PublicGametasks'
    Of KnownFolderId_PublicLibraries
        Return 'PublicLibraries'
    Of KnownFolderId_PublicMusic
        Return 'PublicMusic'
    Of KnownFolderId_PublicPictures
        Return 'PublicPictures'
    Of KnownFolderId_PublicRingtones
        Return 'PublicRingtones'
    Of KnownFolderId_PublicUserTiles
        Return 'PublicUserTiles'
    Of KnownFolderId_PublicVideos
        Return 'PublicVideos'
    Of KnownFolderId_QuickLaunch
        Return 'QuickLaunch'
    Of KnownFolderId_Recent
        Return 'Recent'
    Of KnownFolderId_RecordedCalls
        Return 'RecordedCalls'
    Of KnownFolderId_RecordedTvLibrary
        Return 'RecordedTvLibrary'
    Of KnownFolderId_RecycleBinFolder
        Return 'RecycleBinFolder'
    Of KnownFolderId_ResourceDir
        Return 'ResourceDir'
    Of KnownFolderId_RetailDemo
        Return 'RetailDemo'
    Of KnownFolderId_Ringtones
        Return 'Ringtones'
    Of KnownFolderId_RoamedTileImages
        Return 'RoamedTileImages'
    Of KnownFolderId_RoamingAppData
        Return 'RoamingAppData'
    Of KnownFolderId_RoamingTiles
        Return 'RoamingTiles'
    Of KnownFolderId_SampleMusic
        Return 'SampleMusic'
    Of KnownFolderId_SamplePictures
        Return 'SamplePictures'
    Of KnownFolderId_SamplePlaylists
        Return 'SamplePlaylists'
    Of KnownFolderId_SampleVideos
        Return 'SampleVideos'
    Of KnownFolderId_SavedGames
        Return 'SavedGames'
    Of KnownFolderId_SavedPictures
        Return 'SavedPictures'
    Of KnownFolderId_SavedPicturesLibrary
        Return 'SavedPicturesLibrary'
    Of KnownFolderId_SavedSearches
        Return 'SavedSearches'
    Of KnownFolderId_ScreenShots
        Return 'ScreenShots'
    Of KnownFolderId_Search_Csc
        Return 'Search_Csc'
    Of KnownFolderId_Search_Mapi
        Return 'Search_Mapi'
    Of KnownFolderId_SearchHistory
        Return 'SearchHistory'
    Of KnownFolderId_SearchHome
        Return 'SearchHome'
    Of KnownFolderId_SearchTemplates
        Return 'SearchTemplates'
    Of KnownFolderId_SendTo
        Return 'SendTo'
    Of KnownFolderId_SidebarDefaultParts
        Return 'SidebarDefaultParts'
    Of KnownFolderId_SidebarParts
        Return 'SidebarParts'
    Of KnownFolderId_SkyDrive
        Return 'SkyDrive'
    Of KnownFolderId_SkyDriveCameraRoll
        Return 'SkyDriveCameraRoll'
    Of KnownFolderId_SkyDriveDocuments
        Return 'SkyDriveDocuments'
    Of KnownFolderId_SkyDriveMusic
        Return 'SkyDriveMusic'
    Of KnownFolderId_SkyDrivePictures
        Return 'SkyDrivePictures'
    Of KnownFolderId_StartMenu
        Return 'StartMenu'
    Of KnownFolderId_StartMenuAllPrograms
        Return 'StartMenuAllPrograms'
    Of KnownFolderId_Startup
        Return 'Startup'
    Of KnownFolderId_SyncManagerFolder
        Return 'SyncManagerFolder'
    Of KnownFolderId_SyncResultsFolder
        Return 'SyncResultsFolder'
    Of KnownFolderId_SyncSetupFolder
        Return 'SyncSetupFolder'
    Of KnownFolderId_System
        Return 'System'
    Of KnownFolderId_SystemX86
        Return 'SystemX86'
    Of KnownFolderId_Templates
        Return 'Templates'
    Of KnownFolderId_UserPinned
        Return 'UserPinned'
    Of KnownFolderId_UserProfiles
        Return 'UserProfiles'
    Of KnownFolderId_UserProgramFiles
        Return 'UserProgramFiles'
    Of KnownFolderId_UserProgramFilesCommon
        Return 'UserProgramFilesCommon'
    Of KnownFolderId_UsersFiles
        Return 'UsersFiles'
    Of KnownFolderId_UsersLibraries
        Return 'UsersLibraries'
    Of KnownFolderId_Videos
        Return 'Videos'
    Of KnownFolderId_VideosLibrary
        Return 'VideosLibrary'
    Of KnownFolderId_Windows
        Return 'Windows'
    END
    Return ''
    
c25_WinApiClass.GetKnownPathGuidById    Procedure(string _knownFolderId)

    CODE 
        
        
    Case _knownFolderId

    Of KnownFolderId_AccountPictures
        Return '008CA0B1-55B4-4C56-B8A8-4DE4B299D3BE'
    Of KnownFolderId_AddNewPrograms
        Return 'DE61D971-5EBC-4F02-A3A9-6C82895E5C04'
    Of KnownFolderId_AdminTools
        Return '724EF170-A42D-4FEF-9F26-B60E846FBA4F'
    Of KnownFolderId_AppMods
        Return '7AD67899-66AF-43BA-9156-6AAD42E6C596'
    Of KnownFolderId_AppCaptures
        Return 'EDC0FE71-98D8-4F4A-B920-C8DC133CB165'
    Of KnownFolderId_AppDataDesktop
        Return 'B2C5E279-7ADD-439F-B28C-C41FE1BBF672'
    Of KnownFolderId_AppDataDocuments
        Return '7BE16610-1F7F-44AC-BFF0-83E15F2FFCA1'
    Of KnownFolderId_AppDataFavorites
        Return '7CFBEFBC-DE1F-45AA-B843-A542AC536CC9'
    Of KnownFolderId_AppDataProgramData
        Return '559D40A3-A036-40FA-AF61-84CB430A4D34'
    Of KnownFolderId_ApplicationShortcuts
        Return 'A3918781-E5F2-4890-B3D9-A7E54332328C'
    Of KnownFolderId_AppsFolder
        Return '1E87508D-89C2-42F0-8A7E-645A0F50CA58'
    Of KnownFolderId_AppUpdates
        Return 'A305CE99-F527-492B-8B1A-7E76FA98D6E4'
    Of KnownFolderId_CameraRollLibrary
        Return '2B20DF75-1EDA-4039-8097-38798227D5B7'
    Of KnownFolderId_CdBurning
        Return '9E52AB10-F80D-49DF-ACB8-4330F5687855'
    Of KnownFolderId_ChangeRemovePrograms
        Return 'DF7266AC-9274-4867-8D55-3BD661DE872D'
    Of KnownFolderId_CommonAdminTools
        Return 'D0384E7D-BAC3-4797-8F14-CBA229B392B5'
    Of KnownFolderId_CommonOemLinks
        Return 'C1BAE2D0-10DF-4334-BEDD-7AA20B227A9D'
    Of KnownFolderId_CommonPrograms
        Return '0139D44E-6AFE-49F2-8690-3DAFCAE6FFB8'
    Of KnownFolderId_CommonStartMenu
        Return 'A4115719-D62E-491D-AA7C-E74B8BE3B067'
    Of KnownFolderId_CommonStartMenuPlaces
        Return 'A440879F-87A0-4F7D-B700-0207B966194A'
    Of KnownFolderId_CommonStartup
        Return '82A5EA35-D9CD-47C5-9629-E15D2F714E6E'
    Of KnownFolderId_CommonTemplates
        Return 'B94237E7-57AC-4347-9151-B08C6C32D1F7'
    Of KnownFolderId_ComputerFolder
        Return '0AC0837C-BBF8-452A-850D-79D08E667CA7'
    Of KnownFolderId_ConflictFolder
        Return '4BFEFB45-347D-4006-A5BE-AC0CB0567192'
    Of KnownFolderId_ConnectionsFolder
        Return '6F0CD92B-2E97-45D1-88FF-B0D186B8DEDD'
    Of KnownFolderId_Contacts
        Return '56784854-C6CB-462B-8169-88E350ACB882'
    Of KnownFolderId_ControlPanelFolder
        Return '82A74AEB-AEB4-465C-A014-D097EE346D63'
    Of KnownFolderId_Cookies
        Return '2B0F765D-C0E9-4171-908E-08A611B84FF6'
    Of KnownFolderId_CurrentAppMods
        Return '3DB40B20-2A30-4DBE-917E-771DD21DD099'
    Of KnownFolderId_Desktop
        Return 'B4BFCC3A-DB2C-424C-B029-7FE99A87C641'
    Of KnownFolderId_DevelopmentFiles
        Return 'DBE8E08E-3053-4BBC-B183-2A7B2B191E59'
    Of KnownFolderId_Device
        Return '1C2AC1DC-4358-4B6C-9733-AF21156576F0'
    Of KnownFolderId_DeviceMetaDatastore
        Return '5CE4A5E9-E4EB-479D-B89F-130C02886155'
    Of KnownFolderId_Documents
        Return 'FDD39AD0-238F-46AF-ADB4-6C85480369C7'
    Of KnownFolderId_DocumentsLibrary
        Return '7B0DB17D-9CD2-4A93-9733-46CC89022E7C'
    Of KnownFolderId_Downloads
        Return '374DE290-123F-4565-9164-39C4925E467B'
    Of KnownFolderId_Favorites
        Return '1777F761-68AD-4D8A-87BD-30B759FA33DD'
    Of KnownFolderId_Fonts
        Return 'FD228CB7-AE11-4AE3-864C-16F3910AB8FE'
    Of KnownFolderId_Games
        Return 'CAC52C1A-B53D-4EDC-92D7-6B2E8AC19434'
    Of KnownFolderId_GameTasks
        Return '054FAE61-4DD8-4787-80B6-090220C4B700'
    Of KnownFolderId_History
        Return 'D9DC8A3B-B784-432E-A781-5A1130A75963'
    Of KnownFolderId_HomeGroup
        Return '52528A6B-B9E3-4ADD-B60D-588C2DBA842D'
    Of KnownFolderId_HomeGroupCurrentUser
        Return '9B74B6A3-0DFD-4F11-9E78-5F7800F2E772'
    Of KnownFolderId_ImplicitAppShortcuts
        Return 'BCB5256F-79F6-4CEE-B725-DC34E402FD46'
    Of KnownFolderId_InternetCache
        Return '352481E8-33BE-4251-BA85-6007CAEDCF9D'
    Of KnownFolderId_InternetFolder
        Return '4D9F7874-4E0C-4904-967B-40B0D20C3E4B'
    Of KnownFolderId_Libraries
        Return '1B3EA5DC-B587-4786-B4EF-BD1DC332AEAE'
    Of KnownFolderId_Links
        Return 'BFB9D5E0-C6A9-404C-B2B2-AE6DB6AF4968'
    Of KnownFolderId_LocalAppData
        Return 'F1B32785-6FBA-4FCF-9D55-7B8E7F157091'
    Of KnownFolderId_LocalAppDataLow
        Return 'A520A1A4-1780-4FF6-BD18-167343C5AF16'
    Of KnownFolderId_LocalDocuments
        Return 'F42EE2D3-909F-4907-8871-4C22FC0BF756'
    Of KnownFolderId_LocalDownloads
        Return '7D83EE9B-2244-4E70-B1F5-5393042AF1E4'
    Of KnownFolderId_LocalizedResourcesDir
        Return '2A00375E-224C-49DE-B8D1-440DF7EF3DDC'
    Of KnownFolderId_LocalMusic
        Return 'A0C69A99-21C8-4671-8703-7934162FCF1D'
    Of KnownFolderId_LocalPictures
        Return '0DDD015D-B06C-45D5-8C4C-F59713854639'
    Of KnownFolderId_LocalVideos
        Return '35286A68-3C57-41A1-BBB1-0EAE73D76C95'
    Of KnownFolderId_Music
        Return '4BD8D571-6D19-48D3-BE97-422220080E43'
    Of KnownFolderId_MusicLibrary
        Return '2112AB0A-C86A-4FFE-A368-0DE96E47012E'
    Of KnownFolderId_Nethood
        Return 'C5ABBF53-E17F-4121-8900-86626FC2C973'
    Of KnownFolderId_NetworkFolder
        Return 'D20BEEC4-5CA8-4905-AE3B-BF251EA09B53'
    Of KnownFolderId_Objects3D
        Return '31C0DD25-9439-4F12-BF41-7FF4EDA38722'
    Of KnownFolderId_OneDrive
        Return 'A52BBA46-E9E1-435F-B3D9-28DAA648C0F6'
    Of KnownFolderId_OriginalImages
        Return '2C36C0AA-5812-4B87-BFD0-4CD0DFB19B39'
    Of KnownFolderId_PhotoAlbums
        Return '69D2CF90-FC33-4FB7-9A0C-EBB0F0FCB43C'
    Of KnownFolderId_Pictures
        Return '33E28130-4E1E-4676-835A-98395C3BC3BB'
    Of KnownFolderId_PicturesLibrary
        Return 'A990AE9F-A03B-4E80-94BC-9912D7504104'
    Of KnownFolderId_PlayLists
        Return 'DE92C1C7-837F-4F69-A3BB-86E631204A23'
    Of KnownFolderId_PrintersFolder
        Return '76FC4E2D-D6AD-4519-A663-37BD56068185'
    Of KnownFolderId_Printhood
        Return '9274BD8D-CFD1-41C3-B35E-B13F55A758F4'
    Of KnownFolderId_Profile
        Return '5E6C858F-0E22-4760-9AFE-EA3317B67173'
    Of KnownFolderId_ProgramData
        Return '62AB5D82-FDC1-4DC3-A9DD-070D1D495D97'
    Of KnownFolderId_ProgramFiles
        Return '905E63B6-C1BF-494E-B29C-65B732D3D21A'
    Of KnownFolderId_ProgramFilesCommon
        Return 'F7F1ED05-9F6D-47A2-AAAE-29D317C6F066'
    Of KnownFolderId_ProgramFilesCommonX64
        Return '6365D5A7-0F0D-45E5-87F6-0DA56B6A4F7D'
    Of KnownFolderId_ProgramFilesCommonX86
        Return 'DE974D24-D9C6-4D3E-BF91-F4455120B917'
    Of KnownFolderId_ProgramFilesX64
        Return '6D809377-6AF0-444B-8957-A3773F02200E'
    Of KnownFolderId_ProgramFilesX86
        Return '7C5A40EF-A0FB-4BFC-874A-C0F2E0B9FA8E'
    Of KnownFolderId_Programs
        Return 'A77F5D77-2E2B-44C3-A6A2-ABA601054A51'
    Of KnownFolderId_Public
        Return 'DFDF76A2-C82A-4D63-906A-5644AC457385'
    Of KnownFolderId_PublicDesktop
        Return 'C4AA340D-F20F-4863-AFEF-F87EF2E6BA25'
    Of KnownFolderId_PublicDocuments
        Return 'ED4824AF-DCE4-45A8-81E2-FC7965083634'
    Of KnownFolderId_PublicDownloads
        Return '3D644C9B-1FB8-4F30-9B45-F670235F79C0'
    Of KnownFolderId_PublicGametasks
        Return 'DEBF2536-E1A8-4C59-B6A2-414586476AEA'
    Of KnownFolderId_PublicLibraries
        Return '48DAF80B-E6CF-4F4E-B800-0E69D84EE384'
    Of KnownFolderId_PublicMusic
        Return '3214FAB5-9757-4298-BB61-92A9DEAA44FF'
    Of KnownFolderId_PublicPictures
        Return 'B6EBFB86-6907-413C-9AF7-4FC2ABF07CC5'
    Of KnownFolderId_PublicRingtones
        Return 'E555AB60-153B-4D17-9F04-A5FE99FC15EC'
    Of KnownFolderId_PublicUserTiles
        Return '0482AF6C-08F1-4C34-8C90-E17EC98B1E17'
    Of KnownFolderId_PublicVideos
        Return '2400183A-6185-49FB-A2D8-4A392A602BA3'
    Of KnownFolderId_QuickLaunch
        Return '52A4F021-7B75-48A9-9F6B-4B87A210BC8F'
    Of KnownFolderId_Recent
        Return 'AE50C081-EBD2-438A-8655-8A092E34987A'
    Of KnownFolderId_RecordedCalls
        Return '2F8B40C2-83ED-48EE-B383-A1F157EC6F9A'
    Of KnownFolderId_RecordedTvLibrary
        Return '1A6FDBA2-F42D-4358-A798-B74D745926C5'
    Of KnownFolderId_RecycleBinFolder
        Return 'B7534046-3ECB-4C18-BE4E-64CD4CB7D6AC'
    Of KnownFolderId_ResourceDir
        Return '8AD10C31-2ADB-4296-A8F7-E4701232C972'
    Of KnownFolderId_RetailDemo
        Return '12D4C69E-24AD-4923-BE19-31321C43A767'
    Of KnownFolderId_Ringtones
        Return 'C870044B-F49E-4126-A9C3-B52A1FF411E8'
    Of KnownFolderId_RoamedTileImages
        Return 'AAA8D5A5-F1D6-4259-BAA8-78E7EF60835E'
    Of KnownFolderId_RoamingAppData
        Return '3EB685DB-65F9-4CF6-A03A-E3EF65729F3D'
    Of KnownFolderId_RoamingTiles
        Return '00BCFC5A-ED94-4E48-96A1-3F6217F21990'
    Of KnownFolderId_SampleMusic
        Return 'B250C668-F57D-4EE1-A63C-290EE7D1AA1F'
    Of KnownFolderId_SamplePictures
        Return 'C4900540-2379-4C75-844B-64E6FAF8716B'
    Of KnownFolderId_SamplePlaylists
        Return '15CA69B3-30EE-49C1-ACE1-6B5EC372AFB5'
    Of KnownFolderId_SampleVideos
        Return '859EAD94-2E85-48AD-A71A-0969CB56A6CD'
    Of KnownFolderId_SavedGames
        Return '4C5C32FF-BB9D-43B0-B5B4-2D72E54EAAA4'
    Of KnownFolderId_SavedPictures
        Return '3B193882-D3AD-4EAB-965A-69829D1FB59F'
    Of KnownFolderId_SavedPicturesLibrary
        Return 'E25B5812-BE88-4BD9-94B0-29233477B6C3'
    Of KnownFolderId_SavedSearches
        Return '7D1D3A04-DEBB-4115-95CF-2F29DA2920DA'
    Of KnownFolderId_ScreenShots
        Return 'B7BEDE81-DF94-4682-A7D8-57A52620B86F'
    Of KnownFolderId_Search_Csc
        Return 'EE32E446-31CA-4ABA-814F-A5EBD2FD6D5E'
    Of KnownFolderId_Search_Mapi
        Return '98EC0E18-2098-4D44-8644-66979315A281'
    Of KnownFolderId_SearchHistory
        Return '0D4C3DB6-03A3-462F-A0E6-08924C41B5D4'
    Of KnownFolderId_SearchHome
        Return '190337D1-B8CA-4121-A639-6D472D16972A'
    Of KnownFolderId_SearchTemplates
        Return '7E636BFE-DFA9-4D5E-B456-D7B39851D8A9'
    Of KnownFolderId_SendTo
        Return '8983036C-27C0-404B-8F08-102D10DCFD74'
    Of KnownFolderId_SidebarDefaultParts
        Return '7B396E54-9EC5-4300-BE0A-2482EBAE1A26'
    Of KnownFolderId_SidebarParts
        Return 'A75D362E-50FC-4FB7-AC2C-A8BEAA314493'
    Of KnownFolderId_SkyDrive
        Return 'A52BBA46-E9E1-435F-B3D9-28DAA648C0F6'
    Of KnownFolderId_SkyDriveCameraRoll
        Return '767E6811-49CB-4273-87C2-20F355E1085B'
    Of KnownFolderId_SkyDriveDocuments
        Return '24D89E24-2F19-4534-9DDE-6A6671FBB8FE'
    Of KnownFolderId_SkyDriveMusic
        Return 'C3F2459E-80D6-45DC-BFEF-1F769F2BE730'
    Of KnownFolderId_SkyDrivePictures
        Return '339719B5-8C47-4894-94C2-D8F77ADD44A6'
    Of KnownFolderId_StartMenu
        Return '625B53C3-AB48-4EC1-BA1F-A1EF4146FC19'
    Of KnownFolderId_StartMenuAllPrograms
        Return 'F26305EF-6948-40B9-B255-81453D09C785'
    Of KnownFolderId_Startup
        Return 'B97D20BB-F46A-4C97-BA10-5E3608430854'
    Of KnownFolderId_SyncManagerFolder
        Return '43668BF8-C14E-49B2-97C9-747784D784B7'
    Of KnownFolderId_SyncResultsFolder
        Return '289A9A43-BE44-4057-A41B-587A76D7E7F9'
    Of KnownFolderId_SyncSetupFolder
        Return '0F214138-B1D3-4A90-BBA9-27CBC0C5389A'
    Of KnownFolderId_System
        Return '1AC14E77-02E7-4E5D-B744-2EB1AE5198B7'
    Of KnownFolderId_SystemX86
        Return 'D65231B0-B2F1-4857-A4CE-A8E7C6EA7D27'
    Of KnownFolderId_Templates
        Return 'A63293E8-664E-48DB-A079-DF759E0509F7'
    Of KnownFolderId_UserPinned
        Return '9E3995AB-1F9C-4F13-B827-48B24B6C7174'
    Of KnownFolderId_UserProfiles
        Return '0762D272-C50A-4BB0-A382-697DCD729B80'
    Of KnownFolderId_UserProgramFiles
        Return '5CD7AEE2-2219-4A67-B85D-6C9CE15660CB'
    Of KnownFolderId_UserProgramFilesCommon
        Return 'BCBD3057-CA5C-4622-B42D-BC56DB0AE516'
    Of KnownFolderId_UsersFiles
        Return 'F3CE0F7C-4901-4ACC-8648-D5D44B04EF8F'
    Of KnownFolderId_UsersLibraries
        Return 'A302545D-DEFF-464B-ABE8-61C8648D939B'
    Of KnownFolderId_Videos
        Return '18989B1D-99B5-455B-841C-AB7C74E4DDFC'
    Of KnownFolderId_VideosLibrary
        Return '491E922F-5643-4AF4-A7EB-4E7A138D8174'
    Of KnownFolderId_Windows
        Return 'F38BF404-1D43-42F2-9305-67DE0B28FC23'
    END
    Return '00000000-0000-0000-0000-000000000000'



        



c25_WinApiClass.GetKnownPathById    Procedure(string _knownFolderId, <long _KNOWN_FOLDER_FLAG>, <bool _returnAnsi>)

!PeekByte                                byte
!Ptr                                     Long
!FoundFolderPathLen                      LONG
!FoundFolderPath                         &String
KnownFolderNamePointer                  Long
!KNOWN_FOLDER_FLAG                       Long
Guid16                                  string(16)
SaveRef                                 &STRING

RET                                     LONG

!St &StringTheory

    CODE
        
        !st &= NEW StringTheory()
        

    Self.Guid36 = _knownFolderId
    
    Self.KnownFolderNamePointer = 0
    If Omitted(_KNOWN_FOLDER_FLAG) = True
        Self.KNOWN_FOLDER_FLAG = 0400h + 04000h
    ELSE
        Self.KNOWN_FOLDER_FLAG = _KNOWN_FOLDER_FLAG
    END
    !Self.KNOWN_FOLDER_FLAG = 0
    Loop
        Guid16 = Self.BitConverterClass.Guid16FromGuid36(Self.Guid36)
        !If c25_SHGetKnownFolderPath(Address(Guid16),Self.KNOWN_FOLDER_FLAG, 0, Address(KnownFolderNamePointer)) = 0
        RET = c25_SHGetKnownFolderPath(Address(Guid16),Self.KNOWN_FOLDER_FLAG, 0, Address(KnownFolderNamePointer))
        If RET = 0
            BREAK
        End
        
        RET = c25_SHGetKnownFolderPath(Address(Guid16),Self.KNOWN_FOLDER_FLAG, -1, Address(KnownFolderNamePointer))
        If RET = 0
            BREAK
        End
        
        Self.KNOWN_FOLDER_FLAG = 0
        RET = c25_SHGetKnownFolderPath(Address(Guid16),Self.KNOWN_FOLDER_FLAG, -1, Address(KnownFolderNamePointer))
        If RET = 0
            BREAK
        End
        
        
        
        
!        st &= NEW StringTheory()
!        st.SetValue(Self.GetKnownPathEnumNameById(_knownFolderId) & ' RET ' & LongToHex(RET, false) & Chr(13) & Chr(10) )
!        st.SaveFile('m:\getknown.txt', true)
!        Dispose(st)
        
        
!        
!        
!        Guid16 = Self.BitConverterClass.Guid16FromGuid36(Upper(Self.Guid36))
!        If c25_SHGetKnownFolderPath(Address(Guid16),0, 0, Address(KnownFolderNamePointer)) = 0
!            BREAK
!        End
!        Guid16 = Self.BitConverterClass.Guid16FromGuid36(lower(Self.Guid36))
!        If c25_SHGetKnownFolderPath(Address(Guid16),0, 0, Address(KnownFolderNamePointer)) = 0
!            break
!        End        
!        
        
        If KnownFolderNamePointer <> 0
             c25_CoTaskMemFree(KnownFolderNamePointer)
        End
        
        
        
        return null
    END
    

    
    
    Self.KnownFolderNamePointer = KnownFolderNamePointer
    If Self.KnownFolderNamePointer = 0
        Return NULL
    End
    
    Self.Ptr = Self.KnownFolderNamePointer - 1
    Loop 16000 Times
        Self.Ptr = Self.Ptr + 1
        Peek(Self.Ptr, Self.PeekByte)
        If Self.PeekByte = 0
            Self.Ptr = Self.Ptr + 1
            Peek(Self.Ptr, Self.PeekByte)
            If Self.PeekByte = 0
                Break
            End
        End
    End
    Self.FoundFolderPathLen = Self.Ptr - Self.KnownFolderNamePointer
    If Self.FoundFolderPathLen > 0
        Self.FoundFolderPath &= NEW STRING(Self.FoundFolderPathLen)
        C25_Memcpy(Address(Self.FoundFolderPath), Self.KnownFolderNamePointer, Self.FoundFolderPathLen)
    End
    
    c25_CoTaskMemFree(Self.KnownFolderNamePointer)
    If omitted(_returnAnsi) = False And _returnAnsi = TRUE
        SaveRef &= Self.FoundFolderPath
        If _returnAnsi
            Self.FoundFolderPath &= Self.BitConverterClass.Utf16ToAnsi(Self.FoundFolderPath)
        End
        Dispose(SaveRef)
    End
    Return Self.FoundFolderPath

c25_WinApiClass.FileOrFolderExistUtf16                Procedure(<String _folderNameW>, <String _folderNameWPtr>)

Exist                                       Byte

    Code

        Clear(Self.Win32FindDataW)
        Clear(Self.DirectoryNameUtf16)

        If omitted(_folderNameW) = False
            Self.DirectoryNameUtf16   = Clip(_folderNameW)
        ElsIf omitted(_folderNameWPtr) = False
            Self.DirectoryNameUtf16 = Clip(_folderNameWPtr)
        End
        Self.DirectoryNameUtf16 = Clip(Self.DirectoryNameUtf16) & Chr(0) & Chr(0)

        Self.FileHandleFirst = c25_FindFirstFileW(Address(Self.DirectoryNameUtf16), Address(Self.Win32FindDataW))

        If Self.FileHandleFirst <> 0 And Self.FileHandleFirst <> -1 !INVALID_HANDLE_VALUE
            c25_FindClose(Self.FileHandleFirst)
            Exist = True
        End
        Return Exist

c25_WinApiClass.FindOrCreateFolderUtf16               Procedure(<String _folderNameW>, <String _folderNameWPtr>)

    Code

        Clear(Self.Win32FindDataW)
        Clear(Self.DirectoryNameUtf16)
        If omitted(_folderNameW) = False
            Self.DirectoryNameUtf16   = _folderNameW
        ElsIf omitted(_folderNameWPtr) = False
            Self.DirectoryNameUtf16 = _folderNameWPtr
        End
        Self.DirectoryNameUtf16 = Clip(Self.DirectoryNameUtf16) & Chr(0) & Chr(0)

        Self.FileHandleFirst = c25_FindFirstFileW(Address(Self.DirectoryNameUtf16), Address(Self.Win32FindDataW))

        If Self.FileHandleFirst = 0 Or Self.FileHandleFirst = -1
            Self.DirectoryHandle = c25_CreateDirectoryW(Address(Self.DirectoryNameUtf16),0)
            If  Self.DirectoryHandle <> -1
                
!                Self.StAnsi.Start()
!                Self.StAnsi.encoding = st:EncodeUtf16
!                Self.StAnsi.SetValue(Self.DirectoryNameUtf16)
!                Self.StAnsi.ToAnsi()

                Return -1 ! failed
            Else
                c25_CloseHandle( Self.DirectoryHandle)
            End
        Else
            c25_FindClose(Self.FileHandleFirst)
        End
        Return 0

!!c25_WinApiClass.GetCurrentExeFullPathAnsi             Procedure()
!!
!!FilePathAnsi                                    String(4096)
!!FilePathUtf16                                   &String
!!
!!    Code
!!
!!        X# = c25_GetModuleFileNameA(0, Address(FilePathAnsi), 255)
!!        If X# = 0
!!            Return ''
!!        End
!!        Return Clip(FilePathAnsi)
!!
!!c25_WinApiClass.GetCurrentExeFullPathUtf8             Procedure()
!!
!!    Code
!!
!!        Return 'unknown'
!!
c25_WinApiClass.GetCurrentExeFullPathUtf16            Procedure()

FilePathUtf16                                   String(4096)

    Code

        X# = c25_GetModuleFileNameW(0, Address(FilePathUtf16), 255)
        
        FilePathUtf16 = Self.BitConverterClass.CropZerosUtf16Str(FilePathUtf16)
        
        Return Clip(FilePathUtf16)
        
        
c25_WinApiClass.GetCurrentExeFullPathUtf16ByRef        Procedure()

FilePathUtf16                                               String(4096)
StrBy &STRING

    Code

        X# = c25_GetModuleFileNameW(0, Address(FilePathUtf16), 255)
        
        FilePathUtf16 = Self.BitConverterClass.CropZerosUtf16Str(FilePathUtf16)
        StrBy &= Self.BitConverterClass.BinaryCopy(Clip(FilePathUtf16))
        Return StrBy
        

!!c25_WinApiClass.RemoveFileUtf16                       Procedure(String _fileName, <Byte _messageBoxIfError>)
!!
!!FileNameUtf16                                   String(4096)
!!
!!    Code
!!
!!        FileNameUtf16 = Clip(_fileName) & Chr(0) & Chr(0)
!!
!!        R# = c25_DeleteFileW(Address(FileNameUtf16))
!!        If R# = 0
!!            If _messageBoxIfError = True
!!                Message('failed to delete: ' & Self.BitConverterClass.Utf16ToAnsi(FileNameUtf16))
!!            End
!!        End
!!        Return R#
!!
c25_WinApiClass.CopyFileUtf16                         Procedure(String _existingFileName, String _newFileName)

ExistingFileName                              String(4096)
NewFileName                                   String(4096)

    Code

        ExistingFileName    = Clip(_existingFileName) & Chr(0) & Chr(0)
        NewFileName         = Clip(_newFileName) & Chr(0) & Chr(0)

        R# = c25_CopyFileExW(Address(ExistingFileName),Address(NewFileName),0,0,0, C25_COPY_FILE_ALLOW_DECRYPTED_DESTINATION)

        Return R#

!!c25_WinApiClass.PutReg                                Procedure(<Long _key>,<String _nodePath>,String _valueName, String _value, <Long _regDataType>, <Byte _skipReplace>,<Byte _removeTrailingZeros>) !,String,proc
!!
!!GetReturn       String(1024),auto
!!RegKey          Long
!!RegDataType     Long
!!TestLong        Long,auto
!!TestA           String(128),auto
!!TestB           String(128),auto
!!
!!    Code
!!
!!        If omitted(_key)
!!            RegKey = Self.hKeyDefault
!!        Else
!!            RegKey = _key
!!        End
!!
!!        If omitted(_regDataType) = TRUE
!!            RegDataType = WE::REG_SZ
!!            If NUMERIC(_value)
!!                Clear(TestLong)
!!                Clear(TestA)
!!                Clear(TestB)
!!                TestLong = _value
!!                TestA = TestLong
!!                TestB = _value 
!!                If TestA = TestB
!!                    RegDataType = WE::REG_DWORD
!!                End
!!            End
!!        Else
!!            RegDataType = _regDataType
!!        End
!!              
!!        Case RegDataType
!!!        Of WE::REG_SZ                  !!// Unicode nul terminated String
!!!        Of WE::REG_EXPAND_SZ           !!// Unicode nul terminated String
!!!        Of WE::REG_BINARY              !!// Free form binary
!!        Of WE::REG_DWORD               !!// 32-bit number
!!            If omitted(_nodePath) = False
!!                X# = ds_PutReg(RegKey,Clip(_nodePath),Clip(_valueName),_value, RegDataType)
!!            ELSE
!!                X# = ds_PutReg(RegKey,Self.SubKeyPathDefault,Clip(_valueName),_value, RegDataType)
!!            End
!!!        Of WE::REG_DWORD_LITTLE_ENDIAN !!// 32-bit number (same as REG_DWORD)
!!!        Of WE::REG_DWORD_BIG_ENDIAN    !!// 32-bit number
!!!        Of WE::REG_MULTI_SZ            !!// Multiple Unicode strings
!!        ELSE
!!            If omitted(_nodePath) = False
!!                X# = ds_PutReg(RegKey,Clip(_nodePath),Clip(_valueName),_value, WE::REG_SZ)
!!            ELSE
!!                X# = ds_PutReg(RegKey,Self.SubKeyPathDefault,Clip(_valueName),_value, WE::REG_SZ)
!!            End            
!!        End
!!
!!        Return 0
!!
!!c25_WinApiClass.GetReg                                Procedure(<Long _key>,<String _nodePath>,String _valueName, <String _returnValueWhenNull>)
!!
!!Line1K  String(1024)
!!
!!    Code
!!
!!        If omitted(_key) = False
!!            If omitted(_nodePath) = False
!!                Return ds_GetReg(_key,Clip(_nodePath),Clip(_valueName))
!!            ELSE
!!                Return ds_GetReg(_key,Self.SubKeyPathDefault,Clip(_valueName))
!!            End
!!        Else
!!            If omitted(_nodePath) = False
!!                Return ds_GetReg(Self.hKeyDefault,Clip(_nodePath),Clip(_valueName))
!!            ELSE
!!                Return ds_GetReg(Self.hKeyDefault,Self.SubKeyPathDefault,Clip(_valueName))
!!            End
!!        End
!!
!!        Return 0
!!
!!c25_WinApiClass.FastHexFromLong       Procedure(Long _long)
!!
!!lng Long
!!str4                String(4),over(lng)
!!
!!    Code
!!
!!    lng = _long
!!    Return '0x' & Self.FastHexFromByte(Val(str4[4])) & Self.FastHexFromByte(Val(str4[3])) & Self.FastHexFromByte(Val(str4[2])) & Self.FastHexFromByte(Val(str4[1])) & 'H'
!!
!!c25_WinApiClass.FastHexFromByte                       Procedure(Byte _Byte)!,String
!!
!!    Code
!!
!!    EXECUTE _Byte
!!        Return'01';Return'02';Return'03';Return'04';Return'05';Return'06';Return'07';Return'08';
!!        Return'09';Return'0A';Return'0B';Return'0C';Return'0D';Return'0E';Return'0F';Return'10';
!!        Return'11';Return'12';Return'13';Return'14';Return'15';Return'16';Return'17';Return'18';
!!        Return'19';Return'1A';Return'1B';Return'1C';Return'1D';Return'1E';Return'1F';Return'20';
!!        Return'21';Return'22';Return'23';Return'24';Return'25';Return'26';Return'27';Return'28';
!!        Return'29';Return'2A';Return'2B';Return'2C';Return'2D';Return'2E';Return'2F';Return'30';
!!        Return'31';Return'32';Return'33';Return'34';Return'35';Return'36';Return'37';Return'38';
!!        Return'39';Return'3A';Return'3B';Return'3C';Return'3D';Return'3E';Return'3F';Return'40';
!!        Return'41';Return'42';Return'43';Return'44';Return'45';Return'46';Return'47';Return'48';
!!        Return'49';Return'4A';Return'4B';Return'4C';Return'4D';Return'4E';Return'4F';Return'50';
!!        Return'51';Return'52';Return'53';Return'54';Return'55';Return'56';Return'57';Return'58';
!!        Return'59';Return'5A';Return'5B';Return'5C';Return'5D';Return'5E';Return'5F';Return'60';
!!        Return'61';Return'62';Return'63';Return'64';Return'65';Return'66';Return'67';Return'68';
!!        Return'69';Return'6A';Return'6B';Return'6C';Return'6D';Return'6E';Return'6F';Return'70';
!!        Return'71';Return'72';Return'73';Return'74';Return'75';Return'76';Return'77';Return'78';
!!        Return'79';Return'7A';Return'7B';Return'7C';Return'7D';Return'7E';Return'7F';Return'80';
!!        Return'81';Return'82';Return'83';Return'84';Return'85';Return'86';Return'87';Return'88';
!!        Return'89';Return'8A';Return'8B';Return'8C';Return'8D';Return'8E';Return'8F';Return'90';
!!        Return'91';Return'92';Return'93';Return'94';Return'95';Return'96';Return'97';Return'98';
!!        Return'99';Return'9A';Return'9B';Return'9C';Return'9D';Return'9E';Return'9F';Return'A0';
!!        Return'A1';Return'A2';Return'A3';Return'A4';Return'A5';Return'A6';Return'A7';Return'A8';
!!        Return'A9';Return'AA';Return'AB';Return'AC';Return'AD';Return'AE';Return'AF';Return'B0';
!!        Return'B1';Return'B2';Return'B3';Return'B4';Return'B5';Return'B6';Return'B7';Return'B8';
!!        Return'B9';Return'BA';Return'BB';Return'BC';Return'BD';Return'BE';Return'BF';Return'C0';
!!        Return'C1';Return'C2';Return'C3';Return'C4';Return'C5';Return'C6';Return'C7';Return'C8';
!!        Return'C9';Return'CA';Return'CB';Return'CC';Return'CD';Return'CE';Return'CF';Return'D0';
!!        Return'D1';Return'D2';Return'D3';Return'D4';Return'D5';Return'D6';Return'D7';Return'D8';
!!        Return'D9';Return'DA';Return'DB';Return'DC';Return'DD';Return'DE';Return'DF';Return'E0';
!!        Return'E1';Return'E2';Return'E3';Return'E4';Return'E5';Return'E6';Return'E7';Return'E8';
!!        Return'E9';Return'EA';Return'EB';Return'EC';Return'ED';Return'EE';Return'EF';Return'F0';
!!        Return'F1';Return'F2';Return'F3';Return'F4';Return'F5';Return'F6';Return'F7';Return'F8';
!!        Return'F9';Return'FA';Return'FB';Return'FC';Return'FD';Return'FE';Return'FF'
!!    ELSE
!!        Return '00'
!!    End
!!
!!c25_WinApiClass.FastCharFromHex2                      Procedure(String _Hex)!,Byte
!!
!!    Code
!!
!!    If Val(_Hex[1]) > 039h
!!        If Val(_Hex[2]) > 039h
!!            Return Chr(((Val(_Hex[1])-55) * 16) + (Val(_Hex[2])-55))
!!        Else
!!            Return Chr(((Val(_Hex[1])-55) * 16) + (Val(_Hex[2])-48))
!!        End
!!    Else
!!        If Val(_Hex[2]) > 039h
!!            Return Chr(((Val(_Hex[1])-48) * 16) + (Val(_Hex[2])-55))
!!        Else
!!            Return Chr(((Val(_Hex[1])-48) * 16) + (Val(_Hex[2])-48))
!!        End
!!    End
!!
!!c25_WinApiClass.FastByteFromHex2                      Procedure(String _Hex)!,String
!!
!!    Code
!!
!!    If Val(_Hex[1]) > 039h
!!        If Val(_Hex[2]) > 039h
!!            Return ((Val(_Hex[1])-55) * 16) + (Val(_Hex[2])-55)
!!        Else
!!            Return ((Val(_Hex[1])-55) * 16) + (Val(_Hex[2])-48)
!!        End
!!    Else
!!        If Val(_Hex[2]) > 039h
!!            Return ((Val(_Hex[1])-48) * 16) + (Val(_Hex[2])-55)
!!        Else
!!            Return ((Val(_Hex[1])-48) * 16) + (Val(_Hex[2])-48)
!!        End
!!    End
!!
!!c25_WinApiClass.Guid16FromGuid36                      Procedure(String _guid36)
!!
!!    Code
!!        Self.Guid36 = _guid36
!!
!!    Return Self.FastCharFromHex2(Self.Guid36[7:8]) & |
!!        Self.FastCharFromHex2(Self.Guid36[5:6]) & |
!!        Self.FastCharFromHex2(Self.Guid36[3:4]) & |
!!        Self.FastCharFromHex2(Self.Guid36[1:2]) & |
!!        Self.FastCharFromHex2(Self.Guid36[12:13]) & |
!!        Self.FastCharFromHex2(Self.Guid36[10:11]) & |
!!        Self.FastCharFromHex2(Self.Guid36[17:18]) & |
!!        Self.FastCharFromHex2(Self.Guid36[15:16]) & |
!!        Self.FastCharFromHex2(Self.Guid36[20:21]) & |
!!        Self.FastCharFromHex2(Self.Guid36[22:23]) & |
!!        Self.FastCharFromHex2(Self.Guid36[25:26]) & |
!!        Self.FastCharFromHex2(Self.Guid36[27:28]) & |
!!        Self.FastCharFromHex2(Self.Guid36[29:30]) & |
!!        Self.FastCharFromHex2(Self.Guid36[31:32]) & |
!!        Self.FastCharFromHex2(Self.Guid36[33:34]) & |
!!        Self.FastCharFromHex2(Self.Guid36[35:36])
!!
!!c25_WinApiClass.FormatErrorMessageAnsiStr             Procedure(<ULong _errorcode>, <Long _ntstatus>, <Byte _showMessage>, <String _extraPrefixText>)
!!
!!    Code
!!
!!        If not Self.FormatMessageAnsi &= NULL
!!            Dispose(Self.FormatMessageAnsi)
!!        End
!!        Clear(Self.HResult) !                     Long
!!        Clear(Self.NTSTatusCode) !                Long
!!        Clear(Self.NTSTatusFacility) !            Long
!!        Clear(Self.NTSTatusSeverity) !            Byte
!!        Clear(Self.NTSTatusSeveritySuccess) !     Byte
!!        Clear(Self.NTSTatusSeverityInformational) !     Byte
!!        Clear(Self.NTSTatusSeverityWarning) !     Byte
!!        Clear(Self.NTSTatusSeverityError) !       Byte
!!        Clear(Self.NTSTatusCustomer) !            Byte
!!        Clear(Self.NTSTatusIsNTSTATUS) !          Byte
!!        Self.ErrorCodeInt = 0
!!        If omitted(_ntstatus) = False
!!            Self.NTSTatusCode = BAND(65535,_ntstatus)
!!            Self.ErrorCodeInt = Self.NTSTatusCode
!!
!!            Self.NTSTatusFacility = BAND(134152192,_ntstatus)
!!            Self.NTSTatusSeverity = BAND(3221225472,_ntstatus)
!!            If Self.NTSTatusSeverity = 0
!!                Self.NTSTatusSeveritySuccess = TRUE
!!            ELSE
!!                Case Self.NTSTatusSeverity
!!                Of 1
!!                    Self.NTSTatusSeverityInformational = True
!!                Of 2
!!                    Self.NTSTatusSeverityWarning = True
!!                Of 3
!!                    Self.NTSTatusSeverityError = True
!!                End
!!            End
!!        Else
!!            Self.ErrorCodeInt = _errorcode
!!        End
!!
!!        If Self.ErrorCodeInt <> 0
!!            L# = Len(Clip(Self.FormatErrorMessage(Self.ErrorCodeInt)))
!!            If omitted(_extraPrefixText) = False
!!                L# = L# + Len(Clip(_extraPrefixText))
!!            End
!!            L# = L# + 1024
!!            If L# > 0
!!                Self.FormatMessageAnsi &= NEW String(L#)
!!                If omitted(_extraPrefixText) = False
!!                    Self.FormatMessageAnsi = Clip(_extraPrefixText) & ' ' & Self.FormatErrorMessage(Self.ErrorCodeInt)
!!                Else
!!                    Self.FormatMessageAnsi = Self.FormatErrorMessage(Self.ErrorCodeInt)
!!                End
!!                If _showMessage = True
!!                    Message(Self.FormatMessageAnsi)
!!                End
!!            End
!!        End
!!
!!        Return Self.FormatMessageAnsi
!!
!!c25_WinApiClass.FormatErrorMessageAnsi                Procedure(<ULong _errorcode>, <Long _ntstatus>, <String _extraPrefixText>)
!!
!!MessageStringRef                                &String
!!
!!    Code
!!
!!        If not Self.FormatMessageAnsi &= NULL
!!            Dispose(Self.FormatMessageAnsi)
!!        End
!!        Clear(Self.HResult) !                     Long
!!        Clear(Self.NTSTatusCode) !                Long
!!        Clear(Self.NTSTatusFacility) !            Long
!!        Clear(Self.NTSTatusSeverity) !            Byte
!!        Clear(Self.NTSTatusSeveritySuccess) !     Byte
!!        Clear(Self.NTSTatusSeverityInformational) !     Byte
!!        Clear(Self.NTSTatusSeverityWarning) !     Byte
!!        Clear(Self.NTSTatusSeverityError) !       Byte
!!        Clear(Self.NTSTatusCustomer) !            Byte
!!        Clear(Self.NTSTatusIsNTSTATUS) !          Byte
!!        Self.ErrorCodeInt = 0
!!        If omitted(_ntstatus) = False
!!            Self.NTSTatusCode = BAND(65535,_ntstatus)
!!            Self.ErrorCodeInt = Self.NTSTatusCode
!!
!!            Self.NTSTatusFacility = BAND(134152192,_ntstatus)
!!            Self.NTSTatusSeverity = BAND(3221225472,_ntstatus)
!!            If Self.NTSTatusSeverity = 0
!!                Self.NTSTatusSeveritySuccess = TRUE
!!            ELSE
!!                Case Self.NTSTatusSeverity
!!                Of 1
!!                    Self.NTSTatusSeverityInformational = True
!!                Of 2
!!                    Self.NTSTatusSeverityWarning = True
!!                Of 3
!!                    Self.NTSTatusSeverityError = True
!!                End
!!            End
!!        Else
!!            Self.ErrorCodeInt = _errorcode
!!        End
!!
!!        If Self.ErrorCodeInt <> 0
!!            L# = Len(Clip(Self.FormatErrorMessage(Self.ErrorCodeInt)))
!!            If L# = 0
!!                Return NULL
!!            End
!!            If omitted(_extraPrefixText) = False
!!                L# = L# + Len(Clip(_extraPrefixText) + 1)
!!            End
!!            If L# > 0
!!                L# = L# + 1024
!!                Self.FormatMessageAnsi &= NEW String(L#)
!!                If omitted(_extraPrefixText) = False
!!                    Self.FormatMessageAnsi = Clip(_extraPrefixText) & ' ' & Self.FormatErrorMessage(Self.ErrorCodeInt)
!!                Else
!!                    Self.FormatMessageAnsi = Self.FormatErrorMessage(Self.ErrorCodeInt)
!!                End
!!
!!                MessageStringRef &= NEW String(L#)
!!                MessageStringRef = Self.FormatMessageAnsi
!!                Return Self.FormatMessageAnsi
!!            End
!!
!!        End
!!
!!        Return NULL
!!
!!c25_WinApiClass.FormatErrorMessage                    Procedure(Long _errorCode)
!!
!!winErrMessage       cstring(255)
!!errMessage          String(255)
!!numChars            ULong
!!
!!    Code
!!
!!    numChars = c25_FormatMessage(jo:FORMAT_MESSAGE_FROM_SYSTEM + jo:FORMAT_MESSAGE_IGNORE_INSERTS, 0, _errorCode, 0, winErrMessage, 255, 0)
!!
!!    errMessage = winErrMessage
!!    Return errMessage
!!
!!c25_WinApiClass.ReadDirectory                         Procedure(String _searchPath, <String _mask>, <Byte Recursdir>)
!!
!!RootPathA           String(32000)
!!RootPathW           &String
!!
!!SearchPathA         String(32000)
!!SearchPathW         &String
!!
!!FileNameA           &String
!!hFindFile           Long
!!h                   Long
!!Int64Grp            Like(INT64)
!!DecStr              String(20)
!!FileMaskA           String(255)
!!FileMaskW           &String
!!
!!    Code
!!
!!        Self.FoldersCount = 0
!!        Self.FilesCount  = 0
!!
!!        FileMaskA = '\' & Clip(_mask)
!!        FileMaskW &= Self.BitConverterClass.AnsiToUtf16(Clip(FileMaskA))
!!
!!        RootPathA       = Clip(_searchPath)
!!        RootPathW      &= Self.BitConverterClass.AnsiToUtf16(RootPathA)
!!
!!        SearchPathA     = Clip(_searchPath) & Clip(FileMaskA) & Chr(0)
!!        SearchPathW    &= Self.BitConverterClass.AnsiToUtf16(SearchPathA)
!!
!!        Self.CurrentPathW    &= Self.BitConverterClass.AnsiToUtf16(Clip(_searchPath))
!!        Self.CurrentPathA    = Self.BitConverterClass.Utf16ToAnsiStr(Self.CurrentPathW)
!!
!!        Clear(Self.Win32FindDataW)
!!        hFindFile = c25_findfirstfileExW(Address(SearchPathW), FindExInfoBasic, Address(Self.Win32FindDataW), 0, 0 , FIND_FIRST_EX_LARGE_FETCH)
!!        If hFindFile = 0 Or hFindFile = -1
!!            Message('first find error')
!!            Return 0
!!        End
!!        Self.ParseWin32FindDataW()
!!        Loop
!!            If hFindFile <> 0 And hFindFile <> -1
!!                Loop !100000000 Times
!!                    Clear(Self.Win32FindDataW)
!!                    h = c25_FindNextFileW(hFindFile, Address(Self.Win32FindDataW))
!!                    If h = 0
!!                        If c25_GetLastError() <> 18
!!                            Message('error ' & c25_GetLastError())
!!                        End
!!                        BREAK
!!                    End
!!                    Self.ParseWin32FindDataW()
!!                End
!!            End
!!
!!            Get(Self.FolderToScanQ,1)
!!            If Errorcode() <> 0
!!                BREAK
!!            End
!!            If Self.FolderToScanQ.FullPathUtf16 &= NULL
!!                Message('hier Self.FolderToScanQ.FullPathUtf16 is NULL')
!!                Cycle
!!            End
!!            Dispose(SearchPathW)
!!            Dispose(Self.CurrentPathW)
!!            SearchPathW         &= Self.ConcatUtf16(,,Self.FolderToScanQ.FullPathUtf16, FileMaskW, Chr(0) & Chr(0) )
!!            Self.CurrentPathW   &= Self.Utf16ToUtf16(Self.FolderToScanQ.FullPathUtf16)
!!            Dispose(Self.FolderToScanQ.FullPathUtf16)
!!            Delete(Self.FolderToScanQ)
!!
!!            If hFindFile <> 0 And hFindFile <> -1
!!                c25_FindClose(hFindFile)
!!            End
!!
!!            Clear(Self.Win32FindDataW)
!!            hFindFile = c25_findfirstfileExW(Address(SearchPathW), FindExInfoBasic, Address(Self.Win32FindDataW), 0, 0 ,0) ! FIND_FIRST_EX_LARGE_FETCH)
!!            If hFindFile = 0 Or hFindFile = -1
!!                Cycle
!!            End
!!            Self.ParseWin32FindDataW()
!!        End
!!        If hFindFile <> 0 And hFindFile <> -1
!!            c25_FindClose(hFindFile)
!!        End
!!
!!        G# = 0
!!        Loop
!!            G# = G# + 1
!!            Get(Self.FolderToScanQ,G#)
!!            If Errorcode() <> 0
!!                BREAK
!!            End
!!        End
!!        message('FolderCount ' & Self.FoldersCount & ', filescount: ' & Self.FilesCount)
!!
!!        Return ''
!!
!!c25_WinApiClass.ParseWin32FindDataW                   Procedure()
!!
!!    Code
!!
!!        Clear(Self.ClaFileQ)
!!
!!        Self.ClaFileQ.Attrib = Self.Win32FindDataW.FileAttributes
!!
!!       Self.ClaFileQ.FileNameUtf16         &= Self.Utf16ToUtf16(Clip(Self.Win32FindDataW.FileNameW))
!!        If Self.ClaFileQ.FileNameUtf16 &= NULL
!!            Message('1 Self.ClaFileQ.FileNameUtf16 is NULL')
!!            Return ''
!!        End
!!
!!        Self.ClaFileQ.FullPathUtf16         &= Self.ConcatUtf16(, ,Self.CurrentPathW, '\' & Chr(0),  Self.CropZerosUtf16(Self.ClaFileQ.FileNameUtf16))
!!        If Self.ClaFileQ.FullPathUtf16 &= NULL
!!            Message('2 Self.ClaFileQ.FullPathUtf16 is NULL')
!!            Return ''
!!        End
!!
!!        If Self.ClaFileQ.FullPathUtf16[1] = '.'
!!            Return ''
!!        End
!!        If BAND(Self.ClaFileQ.Attrib,ff_:DIRECTORY)
!!            Self.ClaFileQ.IsFolder = True
!!        ELSE
!!        End
!!        If Self.ClaFileQ.IsFolder
!!            Self.FoldersCount = Self.FoldersCount + 1
!!            Self.FolderToScanQ.FullPathUtf16 &= Self.Utf16ToUtf16(Self.CropZerosUtf16(Self.ClaFileQ.FullPathUtf16))
!!            Add(Self.FolderToScanQ)
!!            Clear(Self.FolderToScanQ)
!!        ELSE
!!            Self.FilesCount = Self.FilesCount + 1
!!        End
!!        Dispose(Self.ClaFileQ.FileNameUtf16)
!!        Dispose(Self.ClaFileQ.FullPathUtf16)
!!
!!        Return ''
!!
c25_WinApiClass.GetWindowRect Procedure(<Long _handle>)

ControlRect                                 Group(WindowRect_TYPE),Pre(ControlRect)
                                            End
    Code

        If _handle <> 0
            c25_getwindowrect(_handle, Address(ControlRect))
            ControlRect.Width = ControlRect.Right - ControlRect.Left
            ControlRect.Height = ControlRect.Bottom - ControlRect.Top
        End
        Return ControlRect
        