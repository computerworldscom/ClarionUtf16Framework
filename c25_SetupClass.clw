                    Member

        Map
            Include('c25_WinApiPrototypes.inc'),Once
        End
        Include('c25_SetupClass.inc'), once

c25_SetupClass.Construct                    Procedure()

ClassStarter                                &c25_ClassStarter
ClassTypeName                               cstring(128)

Code

    ClassTypeName = 'c25_SetupClass'

    ClassStarter &= NEW c25_ClassStarter()
    Self.ProgramHandlerClass &= (ClassStarter.Start(ClassTypeName))
    Dispose(ClassStarter)
    
    
    Self.BitConverterClass          &= NEW c25_BitConverterClass()
    Self.NanoSyncClass              &= NEW c25_NanoSyncClass()
    Self.WinApiClass                &= NEW c25_WinApiClass()
    
    !Self.AWEClass &= NEW c25_AWEClass()
    
    !Self.stLog                      &= NEW StringTheory()
    !Self.StLogFileName              = 'm:\c25_SetupClass.txt'
    

c25_SetupClass.Start        Procedure(<byte _skipCheckInstalled>)

ExtractResourcesThreadClass                     &c25_ExtractResourcesThreadClass

PathA                           string(2048)
PathB                           string(2048)
S                               &STRING

S1                               &STRING
S2                               &STRING


SECURITY_ATTRIBUTES             group,Pre(SECURITY_ATTRIBUTES)
nLength                             ULong
lpSecurityDescriptor                unsigned    ! Address of a security descriptor data structure
bInheritHandle                      Long
                                End
pOwner                          Long
lpbOwnerDefaulted               Long

!
!ppsidOwner                      long
!ppsidGroup                      Long
!ppDacl                          Long
!ppSacl                          long 
!ppSecurityDescriptor            Long




Code

!        If _skipCheckInstalled = 0
!            Self.RunningIsInstalled = Self.WinApi.IsInstalled()
!            If Self.RunningIsInstalled = False
!                Self.ExtractResources.Start()
!
!            Else
!                Self.LoadDlls()
!            End
!        End

    ExtractResourcesThreadClass                         &= NEW c25_ExtractResourcesThreadClass()
    ExtractResourcesThreadClass.Installed               = ExtractResourcesThreadClass.Start(False)
    Self.ExtractResourcesThreadClass                    &= ExtractResourcesThreadClass
    
    !Self.stLog.Start()
    
!    !PathA = Self.ProgramHandlerClass.BitConverterClass.CropZerosUtf16Str(Self.ProgramHandlerClass.WinApiClass.GetCurrentExeFullPathUtf16())
!    
!    S1 &= Self.ProgramHandlerClass.WinApiClass.GetCurrentExeFullPathUtf16ByRef()
!   
!    !Self.ProgramHandlerClass.BitConverterClass.St1.Append(S1)
!    
!    Self.ProgramHandlerClass.BitConverterClass.St1.Append(Self.ProgramHandlerClass.ApplicationFileNameAndPathUtf16)
!    
!    
!    
!!    Self.ProgramHandlerClass.BitConverterClass.St1.Append(Chr(13) & Chr(10) )   
!!    Self.ProgramHandlerClass.BitConverterClass.St1.Append(Self.ProgramHandlerClass.BitConverterClass.CropZerosUtf16Str(Self.ProgramHandlerClass.ApplicationFileNameAndPathUtf16))
!!    Self.ProgramHandlerClass.BitConverterClass.St1.Append(Chr(13) & Chr(10) )
!    
!    Self.ProgramHandlerClass.BitConverterClass.St1.SaveFile('m:\lognow.txt')
!    

    If lower(Self.ProgramHandlerClass.ApplicationFileNameAndPathUtf16) = lower(Self.ProgramHandlerClass.WinApiClass.GetCurrentExeFullPathUtf16())
        !Message('ja same')
    ELSE
        !todooooooooooooooooooo hier hier hier !!!!
        Self.ProgramHandlerClass.WinApiClass.CopyFileUtf16(Self.ProgramHandlerClass.WinApiClass.GetCurrentExeFullPathUtf16() ,Self.ProgramHandlerClass.ApplicationFileNameAndPathUtf16)
        !Message('nee not same')
    END
    
    
!    B# = Self.ProgramHandlerClass.WinApiClass.FileOrFolderExistUtf16( Self.ProgramHandlerClass.ApplicationFileNameAndPathUtf16)
!    
!    If B# = 0
!        Self.ProgramHandlerClass.WinApiClass.CopyFileUtf16(Self.ProgramHandlerClass.WinApiClass.GetCurrentExeFullPathUtf16()  ,Self.ProgramHandlerClass.ApplicationFileNameAndPathUtf16)
!    End
    
    !C25_GetSecurityDescriptorOwner(long pSecurityDescriptor, long pOwner, long lpbOwnerDefaulted)

        !C25_GetSecurityDescriptorOwner(long pSecurityDescriptor, long pOwner, long lpbOwnerDefaulted)
!    B# = C25_GetSecurityDescriptorOwner(Address(SECURITY_ATTRIBUTES), Address(pOwner), Address(lpbOwnerDefaulted))
!    
!    
!    Self.stLog.Append(pOwner & Self.ProgramHandlerClass.BitConverterClass.CRLF)
!    Self.stLog.Append(SECURITY_ATTRIBUTES.nLength & Self.ProgramHandlerClass.BitConverterClass.CRLF)
!    Self.stLog.Append(SECURITY_ATTRIBUTES.lpSecurityDescriptor & Self.ProgramHandlerClass.BitConverterClass.CRLF)
!    Self.stLog.Append(SECURITY_ATTRIBUTES.bInheritHandle & Self.ProgramHandlerClass.BitConverterClass.CRLF)
!    Self.stLog.Append(pOwner & Self.ProgramHandlerClass.BitConverterClass.CRLF)
    !Self.stLog.SaveFile(Self.StLogFileName)
    
    
    !Self.WinApiClass.LockMemory()
    !Self.ProgramHandlerClass.AWEClass.CreatePages()
    
    !Self.WinApiClass.GetSecurityInfo() !!!!!!!!!!!!! awe sucks
    
    
    
    !c25_GetNamedSecurityInfoA
    
    !c25_GetSecurityInfo(long handle, long objectType, long securityInfo, long ppsidOwner, long ppsidGroup, long, ppDacl, long ppSacl, long ppSecurityDescriptor), long,proc,name('GetSecurityInfo')
!    c25_GetSecurityInfo(Self.WinApiClass.GetProcessHandle(), SE_OBJECT_TYPE:SE_KERNEL_OBJECT, SECURITY_INFORMATION:OWNER_SECURITY_INFORMATION, ppsidOwner, long ppsidGroup, long, ppDacl, long ppSacl, long ppSecurityDescriptor), long,proc,name('GetSecurityInfo')
!    
!    ppsidOwner                      long
!    ppsidGroup                      Long
!    ppDacl                          Long
!    ppSacl                          long 
!    ppSecurityDescriptor            Long

    !SECURITY_DESCRIPTOR.Revision = 1
    !SECURITY_DESCRIPTOR.Control = 0
    
    !MemSize = Size(SECURITY_DESCRIPTOR)
    !dacl = c25_HeapAlloc(C25_Getprocessheap(), c25_HEAP_ZERO_MEMORY, 1000)
    !secDescr = c25_HeapAlloc(C25_Getprocessheap(), c25_HEAP_ZERO_MEMORY, 1000)
    
    
    !dacl = c25_GlobalAlloc(0, 1024)
    
    !Message(dacl)
    
!    MemSize = Size(SECURITY_DESCRIPTOR)
!    MemAddress = c25_HeapAlloc(C25_Getprocessheap(), c25_HEAP_ZERO_MEMORY, MemSize)    
!
!    C25_Memcpy(MemAddress,Address(SECURITY_DESCRIPTOR),Size(SECURITY_DESCRIPTOR))
    
    !c25_GetSecurityInfo(long handle, long objectType, long securityInfo, long ppsidOwner, long ppsidGroup, long, ppDacl, long ppSacl, long ppSecurityDescriptor), long,proc,name('GetSecurityInfo')
    !Clear(pSecurityDescriptor,-1)
    
    
    !DACL_SECURITY_INFORMATION
    !RetVal = c25_GetSecurityInfo(FileHandle, SE_OBJECT_TYPE:SE_FILE_OBJECT, Address(SECURITY_DESCRIPTOR), 0, 0, 0, 0, Address(pSecurityDescriptor))
    
    !RetVal = c25_GetSecurityInfo(FileHandle, SE_OBJECT_TYPE:SE_FILE_OBJECT, SECURITY_INFORMATION:DACL_SECURITY_INFORMATION, 0, 0, dacl, 0, secDescr)  !Address(pSecurityDescriptor))
    !Message('c25_GetSecurityInfo RetVal ' & RetVal & ', C25_GetLastError(): ' & C25_GetLastError())    
    
    !C25_Closehandle(FileHandle)
    
    
    !Message('c25_GetSecurityInfo RetVal ' & RetVal & ', C25_GetLastError(): ' & C25_GetLastError() & ', lpnLengthNeeded: ' & lpnLengthNeeded)    
        
    
    
    
    
    !BitConverterClass                                                               &c25_BitConverterClass
    !B# = C25_AccessCheck(long pSecurityDescriptor, long ClientToken, long DesiredAccess, long GenericMapping, long PrivilegeSet, long PrivilegeSetLength, long GrantedAccess, long AccessStatus),Long,Pascal,Proc,Name('AccessCheck')
    !B# = C25_AccessCheck(long pSecurityDescriptor, long ClientToken, long DesiredAccess, long GenericMapping, long PrivilegeSet, long PrivilegeSetLength, long GrantedAccess, long AccessStatus),Long,Pascal,Proc,Name('AccessCheck')
    
!        dllName = 'Advapi32.dll'
!        Self.hAdvapi32 = joLoadLibrary(dllName)
!        If Self.hAdvapi32 = 0                                             ! check library handle is not zero
!            Self.ErrorTrap('Failed to load Advapi32.dll, not all the required API functions are available', joGetLastError())
!            Return 0
!        End
!    
!        B# = C25_AccessCheck(
!  [in]            PSECURITY_DESCRIPTOR pSecurityDescriptor,
!  [in]            HANDLE               ClientToken,
!  [in]            DWORD                DesiredAccess,
!  [in]            PGENERIC_MAPPING     GenericMapping,
!  [out, optional] PPRIVILEGE_SET       PrivilegeSet,
!  [in, out]       LPDWORD              PrivilegeSetLength,
!  [out]           LPDWORD              GrantedAccess,
!  [out]           LPBOOL               AccessStatus
!);    
!    
    
!        fp_DuplicateTokenEx         = Self.LocateProcedure(Self.hAdvapi32, 'DuplicateTokenEx')
!        fp_OpenProcessToken         = Self.LocateProcedure(Self.hAdvapi32, 'OpenProcessToken')
!        fp_OpenThreadToken          = Self.LocateProcedure(Self.hAdvapi32, 'OpenThreadToken')
!        ! Apr10: New
!        fp_AccessCheck              = Self.LocateProcedure(Self.hAdvapi32, 'AccessCheck')
!        fp_AdjustTokenGroups        = Self.LocateProcedure(Self.hAdvapi32, 'AdjustTokenGroups')
!        fp_AdjustTokenPrivileges    = Self.LocateProcedure(Self.hAdvapi32, 'AdjustTokenPrivileges')
!        fp_GetTokenInformation      = Self.LocateProcedure(Self.hAdvapi32, 'GetTokenInformation')
!        fp_SetThreadToken           = Self.LocateProcedure(Self.hAdvapi32, 'SetThreadToken')
!        fp_SetTokenInformation      = Self.LocateProcedure(Self.hAdvapi32, 'SetTokenInformation')    
    
    Return Self.RunningIsInstalled

c25_SetupClass.Destruct                           Procedure()

Code
        
        
        

