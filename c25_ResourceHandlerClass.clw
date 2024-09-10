                    Member


            Include('c25_ResourceHandlerClass.inc'),once
            Map
                Include('c25_WinApiPrototypes.clw')
                Include('i64.inc')
            End

c25ResourceHandlerClass.Construct       Procedure()

    Code

        Self.St1 &= NEW StringTheory
        Self.CRLF = Chr(13) & Chr(10)
        Self.Zero = Chr(0)
        Self.Zero2 = Chr(0) & Chr(0)
        Self.ResourcesQ &= NEW Resources_TYPE()
        Self.Js1 &= New JSONClass()
        Self.WinApi &= NEW c25WinApiClass()
        Self.BitConverter &= NEW c25BitConverterClass()
        Self.DevicePropertyCodeQ &= NEW DevicePropertyCode_TYPE
        Self.DevicePropDefQ &= NEW DevicePropDef_TYPE
        Self.SystemClassesQ &= NEW SystemClasses_TYPE
                        
c25ResourceHandlerClass.Destruct        Procedure()

    Code

c25ResourceHandlerClass.Start   Procedure(<Byte _isInstalledParam>)

ThreadInfoSourceAddress                                     Long
ThreadInfoTargetAddress                                     Long
ThreadInfo                                                  Group(ThreadInfo_TYPE)
                                                            End
SizeThreadInfo                                              Long
NanoClock                                                   &c25NanoSyncClass()
GetKnownFolders                                             Byte
GettingKnownFolders                                         Byte
GotKnownFolders                                             Byte
ToExtract                                                   Byte
Extracting                                                  Byte
Extracted                                                   Byte
ToUnRar                                                     Byte
UnRarring                                                   Byte
UnRarred                                                    Byte

    Code

        
!        Self.IsInstalledParam     = _isInstalledParam
        Self.KnownFolders &= NEW KnownFolders_TYPE()

        GettingKnownFolders = TRUE
        Self.KnownFolders = Self.WinApi.GetKnownFolders()
        Self.WinApi.FindOrCreateFolderUtf16(Self.KnownFolders.DataStoreAppFullPathUtf16)
        Self.WinApi.FindOrCreateFolderUtf16(Self.KnownFolders.DataStoreFullPathUtf16)
        Self.WinApi.FindOrCreateFolderUtf16(Self.KnownFolders.ApplicationFullPathUtf16)
        Self.WinApi.FindOrCreateFolderUtf16(Self.KnownFolders.ProgramDataFolderUtf16)
        Self.WinApi.FindOrCreateFolderUtf16(Self.KnownFolders.DataStoreUserFullPathUtf16)
        
!        Self.ExtractResources('hardwareclass')

        Return True

c25ResourceHandlerClass.GetResource                             Procedure(String _resourceName, <StringTheory _stOut>)

ResourceGrp                                                     Group(Resources_TYPE),pre(ResourceGrp)
                                                                End
ResourceName                                                    String(2048)
ResourceNameUpper                                               String(2048)
ExeFileName                                                     String(2048)
WriteHandle                                                     Long

    Code

        If not Self.BufferString &= null
            Dispose(Self.BufferString)
        End
        If Self.ProcessHeapHandle = 0
            Self.ProcessHeapHandle = c25_GetProcessHeap()
        End
        Self.ResourceType = 'IMAGE' & Chr(0)
        Self.AppInstance = 0
        c25_GetModuleHandleExA(c25_GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT ,0,Address(Self.AppInstance))
        ResourceName = Clip(_resourceName) & Chr(0) & Chr(0)

        Self.ResourceHandle = c25_FindResourceA(Self.AppInstance, Address(ResourceName), Address(Self.ResourceType))
        
        If Self.ResourceHandle = 0
            Return ''
        End
        Self.ResourceDataHandle = c25_LoadResource(Self.AppInstance, Self.ResourceHandle)
        If Self.ResourceDataHandle = 0
            Return ''
        End
        Self.ResourceDataHandlePtr = c25_LockResource(Self.ResourceDataHandle)
        If Self.ResourceDataHandlePtr = 0
            Return ''
        End
        Self.SizeResource = c25_SizeOfResource(Self.AppInstance,Self.ResourceHandle)
        If Self.SizeResource < 1
            Return ''
        End
        !Self.HeapMemAddress = c25_HeapAlloc(Self.ProcessHeapHandle,8,Self.SizeResource)
        !c25_MemCpy(Self.HeapMemAddress,Self.ResourceDataHandlePtr,Self.SizeResource)
!        Case Lower(ResourceGrp.ReturnType)
!        Of 'memaddress'
!        Of 'file'
!            If Self.SizeResource < 1
!                Return ''
!            End
!            If ResourceGrp.ExtractToFullPathUtf16 &= null
!                Return ''
!            End
!            ResourceGrp.ExtractToFullPathUtf16 = Clip(ResourceGrp.ExtractToFullPathUtf16) & Chr(0) & Chr(0)
!            If Self.WinApi.FileOrFolderExistUtf16(ResourceGrp.ExtractToFullPathUtf16) = False
!                WriteHandle = c25_CreateFileW(Address(ResourceGrp.ExtractToFullPathUtf16),c25_GENERIC_WRITE + c25_GENERIC_READ, c25_FILE_SHARE_WRITE,0,c25_CREATE_NEW,080h,0)
!                If WriteHandle <> c25_INVALID_HANDLE_VALUE
!                    X# = c25_WriteFile(WriteHandle,Self.HeapMemAddress,Self.SizeResource,0,0)
!                    c25_CloseHandle(WriteHandle)
!                End
!            End
!            c25_HeapFree(Self.ProcessHeapHandle,0,Self.HeapMemAddress)
!        Else
        If omitted(_stOut) = False
            _stOut.Start()
            _stOut.SetValueByAddress(Self.ResourceDataHandlePtr, Self.SizeResource)
            !c25_HeapFree(Self.ProcessHeapHandle,0,Self.HeapMemAddress)
        Else
            Self.BufferString &= NEW String(Self.SizeResource)
            c25_MemCpy(Address(Self.BufferString),Self.ResourceDataHandlePtr,Self.SizeResource)
            c25_HeapFree(Self.ProcessHeapHandle,0,Self.HeapMemAddress)
            Return Self.BufferString
        End
        Return ''
        
        
c25ResourceHandlerClass.ExtractResource                     Procedure(<String _resourceName>, <Resources_TYPE _resourcesQ>)

ResourceGrp                                                     Group(Resources_TYPE),pre(ResourceGrp)
                                                                End
ResourceName                                                    String(2048)
ResourceNameUpper                                               String(2048)
ExeFileName                                                     String(2048)
WriteHandle                                                     Long

    Code

        Dispose(Self.BufferString)
        If Self.ProcessHeapHandle = 0
            Self.ProcessHeapHandle = c25_GetProcessHeap()
        End
        Self.ResourceType = 'IMAGE' & Chr(0)
        Self.AppInstance = 0
        c25_GetModuleHandleExA(c25_GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT ,0,Address(Self.AppInstance))
        If omitted(_resourceName) = False
            ResourceName = Clip(_resourceName) & Chr(0)
        End
        If omitted(_resourcesQ) = False
            ResourceGrp = _resourcesQ
            ResourceName = Clip(ResourceGrp.ResourceName) & Chr(0)
        End
        Self.ResourceHandle = c25_FindResourceA(Self.AppInstance, Address(ResourceName), Address(Self.ResourceType))
        If Self.ResourceHandle = 0
            Return ''
        End
        Self.ResourceDataHandle = c25_LoadResource(Self.AppInstance, Self.ResourceHandle)
        If Self.ResourceDataHandle = 0
            Return ''
        End
        Self.ResourceDataHandlePtr = c25_LockResource(Self.ResourceDataHandle)
        If Self.ResourceDataHandlePtr = 0
            Return ''
        End
        Self.SizeResource = c25_SizeOfResource(Self.AppInstance,Self.ResourceHandle)
        If Self.SizeResource < 1
            Return ''
        End
        Self.HeapMemAddress = c25_HeapAlloc(Self.ProcessHeapHandle,8,Self.SizeResource)
        c25_MemCpy(Self.HeapMemAddress,Self.ResourceDataHandlePtr,Self.SizeResource)
        Case Lower(ResourceGrp.ReturnType)
        Of 'memaddress'
        Of 'file'
            If Self.SizeResource < 1
                Return ''
            End
            If ResourceGrp.ExtractToFullPathUtf16 &= null
                Return ''
            End
            ResourceGrp.ExtractToFullPathUtf16 = Clip(ResourceGrp.ExtractToFullPathUtf16) & Chr(0) & Chr(0)
            If Self.WinApi.FileOrFolderExistUtf16(ResourceGrp.ExtractToFullPathUtf16) = False
                WriteHandle = c25_CreateFileW(Address(ResourceGrp.ExtractToFullPathUtf16),c25_GENERIC_WRITE + c25_GENERIC_READ, c25_FILE_SHARE_WRITE,0,c25_CREATE_NEW,080h,0)
                If WriteHandle <> c25_INVALID_HANDLE_VALUE
                    X# = c25_WriteFile(WriteHandle,Self.HeapMemAddress,Self.SizeResource,0,0)
                    c25_CloseHandle(WriteHandle)
                End
            End
            c25_HeapFree(Self.ProcessHeapHandle,0,Self.HeapMemAddress)
        Else
            Self.BufferString &= NEW String(Self.SizeResource)
            c25_MemCpy(Address(Self.BufferString),Self.ResourceDataHandlePtr,Self.SizeResource)
            c25_HeapFree(Self.ProcessHeapHandle,0,Self.HeapMemAddress)
            Return Self.BufferString
        End
        Return ''

c25ResourceHandlerClass.ExtractResources                    Procedure(<string _category>)

GenerateJsonFile                                                Byte
CurrentExeFullPathAnsi                                          String(4096)
TargetExeFullPathAnsi                                           &String
CurrentExeFullPathUtf16                                         String(4096)
TargetExeFullPathUtf16                                          &String
CloseAndRestart                                                 Byte
ShellExecuteInfoW                                               Group(ShellExecuteInfoW_TYPE),Pre(ShellExecuteInfoW)
                                                                End
InfoW_Verb                                                      &String
InfoW_File                                                      &String
InfoW_Parameters                                                &String
InfoW_Directory                                                 &String
GlobalMemDictionary                                             &Dictionary_TYPE

    Code

        Free(Self.ResourcesQ)
        GenerateJsonFile = False
        If GenerateJsonFile = TRUE
            Self.GenerateJsonFile()
        End
        R# = Self.ImportResourcesQJson('RESOURCES\JSON\RESOURCESQ_JSON')
        If R# = 0
            Return ''
        End

!        If  Self.WinApi.GlobalMem.Dictionary &= NULL
!            Message(' Self.WinApi.GlobalMem.Dictionary is null')
!        End

        If Self.st1 &= NULL
            Self.st1 &= NEW StringTheory()
        End
        Self.st1.Start()
        I# = 0
        LOOP
            I# = I# + 1
            Get(Self.ResourcesQ,I#)
            If Errorcode() <> 0
                BREAK
            End
            If Self.IsInstalledParam = 1
                If Self.ResourcesQ.OnInstallOnly = 1
                    CYCLE
                End
                If Self.ResourcesQ.OnInstalledOnly = 0
                    CYCLE
                End
            End
            If Self.IsInstalledParam = 0
                If Self.ResourcesQ.OnInstalledOnly = 1
                    CYCLE
                End
            End
            Case Lower(Self.ResourcesQ.TargetFolderType)
            Of 'userdata'
                Self.ResourcesQ.ExtractToFullPathAnsi &= Self.BitConverter.ConcatAnsi(true, '\', Self.KnownFolders.DataStoreUserFullPathAnsi, Self.ResourcesQ.FileNameAnsi)
                Self.ResourcesQ.FileNameUtf16 &= Self.BitConverter.AnsiToUtf16(Clip(Self.ResourcesQ.FileNameAnsi))
                Self.ResourcesQ.ExtractToFullPathUtf16 &= Self.BitConverter.ConcatUtf16(False, , Self.KnownFolders.DataStoreUserFullPathUtf16, '\' & Chr(0), Self.ResourcesQ.FileNameUtf16, Chr(0) & Chr(0))
                Self.ExtractResource(,Self.ResourcesQ)
                Dispose(Self.ResourcesQ.ExtractToFullPathAnsi)
                Dispose(Self.ResourcesQ.FileNameUtf16)
                Dispose(Self.ResourcesQ.ExtractToFullPathUtf16)
            Of 'programdata'
                Self.ResourcesQ.ExtractToFullPathAnsi &= Self.BitConverter.ConcatAnsi(true, '\', Self.KnownFolders.ProgramDataFolderAnsi, Self.ResourcesQ.FileNameAnsi)
                Self.ResourcesQ.FileNameUtf16 &= Self.BitConverter.AnsiToUtf16(Clip(Self.ResourcesQ.FileNameAnsi))
                Self.ResourcesQ.ExtractToFullPathUtf16 &= Self.BitConverter.ConcatUtf16(False, , Self.KnownFolders.ProgramDataFolderUtf16, '\' & Chr(0), Self.ResourcesQ.FileNameUtf16, Chr(0) & Chr(0))
                Self.ExtractResource(,Self.ResourcesQ)
                Dispose(Self.ResourcesQ.ExtractToFullPathAnsi)
                Dispose(Self.ResourcesQ.FileNameUtf16)
                Dispose(Self.ResourcesQ.ExtractToFullPathUtf16)
            Of 'data'
                Self.ResourcesQ.ExtractToFullPathAnsi &= Self.BitConverter.ConcatAnsi(true, '\', Self.KnownFolders.DataStoreAppFullPathAnsi, Self.ResourcesQ.FileNameAnsi)
                Self.ResourcesQ.FileNameUtf16 &= Self.BitConverter.AnsiToUtf16(Clip(Self.ResourcesQ.FileNameAnsi))
                Self.ResourcesQ.ExtractToFullPathUtf16 &= Self.BitConverter.ConcatUtf16(False, , Self.KnownFolders.DataStoreAppFullPathUtf16, '\' & Chr(0), Self.ResourcesQ.FileNameUtf16, Chr(0) & Chr(0))
                Self.ExtractResource(,Self.ResourcesQ)
                Dispose(Self.ResourcesQ.ExtractToFullPathAnsi)
                Dispose(Self.ResourcesQ.FileNameUtf16)
                Dispose(Self.ResourcesQ.ExtractToFullPathUtf16)
            Of 'application'
                Self.ResourcesQ.ExtractToFullPathAnsi &= Self.BitConverter.BinaryCopy(Self.KnownFolders.ApplicationFullPathAnsi & '\' & Self.ResourcesQ.FileNameAnsi)
                Self.ResourcesQ.FileNameUtf16 &= Self.BitConverter.AnsiToUtf16(Clip(Self.ResourcesQ.FileNameAnsi))
                Self.ResourcesQ.ExtractToFullPathUtf16 &= Self.BitConverter.ConcatUtf16(False, , Self.KnownFolders.ApplicationFullPathUtf16, '\' & Chr(0), Self.ResourcesQ.FileNameUtf16, Chr(0) & Chr(0))

                Self.ExtractResource(,Self.ResourcesQ)
                Dispose(Self.ResourcesQ.ExtractToFullPathAnsi)
                Dispose(Self.ResourcesQ.FileNameUtf16)
                Dispose(Self.ResourcesQ.ExtractToFullPathUtf16)

                Self.ResourcesQ.ExtractToFullPathAnsi &= Self.BitConverter.BinaryCopy('.\' & Self.ResourcesQ.FileNameAnsi)
                Self.ResourcesQ.FileNameUtf16 &= Self.BitConverter.AnsiToUtf16(Clip(Self.ResourcesQ.FileNameAnsi))
                Self.ResourcesQ.ExtractToFullPathUtf16 &= Self.BitConverter.BinaryCopy('.' & Chr(0) & '\' & Chr(0) & Self.ResourcesQ.FileNameUtf16 & Chr(0) & Chr(0))

                Self.ExtractResource(,Self.ResourcesQ)

                Dispose(Self.ResourcesQ.ExtractToFullPathAnsi)
                Dispose(Self.ResourcesQ.FileNameUtf16)
                Dispose(Self.ResourcesQ.ExtractToFullPathUtf16)

            Of 'memory'
                If Self.Js1 &= null
                    Self.Js1 &= New JSONClass()
                End
                Self.Js1.Start()
                Self.Js1.SetTagCase(jF:CaseAny)
                Self.Js1.SetFreeQueueBeforeLoad(True)
                Self.st1.Start()
                Self.st1.SetValue(Self.ExtractResource(,Self.ResourcesQ))
                Case Self.ResourcesQ.FileNameAnsi
                Of 'DevicePropDef.json'
                    Self.DevicePropDefQ &= NEW DevicePropDef_TYPE
                    Self.Js1.Load(Self.DevicePropDefQ,Self.st1)
                    Z# = 0
                    LOOP
                        Z# = Z# + 1
                        Get(Self.DevicePropDefQ,Z#)
                        If Errorcode() <> 0
                            BREAK
                        End
                        Self.DevicePropDefQ.NameUtf16 &= Self.BitConverter.AnsiToUtf16(Clip(Self.DevicePropDefQ.NameAnsi))
                        Self.DevicePropDefQ.CodeNameUpperUtf16 &= Self.BitConverter.AnsiToUtf16(Clip(Self.DevicePropDefQ.CodeNameUpperAnsi))
                        Self.DevicePropDefQ.DescriptionUtf16 &= Self.BitConverter.AnsiToUtf16(Clip(Self.DevicePropDefQ.DescriptionAnsi))
                        Put(Self.DevicePropDefQ)
                    End

                Of 'SystemClasses.json'
                    Return Self.st1.GetValue()
!                    Self.SystemClassesQ &= NEW SystemClasses_TYPE
!
!                    Self.Js1.Load(Self.SystemClassesQ,Self.st1)
!                    Z# = 0
!                    LOOP
!                        Z# = Z# + 1
!                        Get(Self.SystemClassesQ,Z#)
!                        If Errorcode() <> 0
!                            BREAK
!                        End
!                        Self.SystemClassesQ.Guid36FormattedUtf16 &= Self.BitConverter.AnsiToUtf16(Clip(Self.SystemClassesQ.Guid36FormattedAnsi))
!                        Self.SystemClassesQ.Guid38FormattedUtf16 &= Self.BitConverter.AnsiToUtf16(Clip(Self.SystemClassesQ.Guid38FormattedAnsi))
!                        Self.SystemClassesQ.NameUtf16 &= Self.BitConverter.AnsiToUtf16(Clip(Self.SystemClassesQ.NameAnsi))
!                        Self.SystemClassesQ.ClassNameUtf16 &= Self.BitConverter.AnsiToUtf16(Clip(Self.SystemClassesQ.ClassNameAnsi))
!                        Self.SystemClassesQ.DescriptionUtf16 &= Self.BitConverter.AnsiToUtf16(Clip(Self.SystemClassesQ.DescriptionAnsi))
!                        Self.SystemClassesQ.Guid32HexUtf16 &= Self.BitConverter.AnsiToUtf16(Clip(Self.SystemClassesQ.Guid32HexAnsi))
!                        Self.SystemClassesQ.Guid47HexUtf16 &= Self.BitConverter.AnsiToUtf16(Clip(Self.SystemClassesQ.Guid47HexAnsi))
!                        Put(Self.SystemClassesQ)
!                    End
                Of 'Adapters.json'
                    !Self.WinApi.GlobalMem.SetGlobalDictionaryValue('Adapters.json', Self.st1.GetValue())
                Of 'Databases.json'
                    !Self.WinApi.GlobalMem.SetGlobalDictionaryValue('Databases.json', Self.st1.GetValue())

                Of 'Sources.json'
                    !Self.WinApi.GlobalMem.SetGlobalDictionaryValue('Sources.json', Self.st1.GetValue())
                Of 'Tables.json'
                    !Self.WinApi.GlobalMem.SetGlobalDictionaryValue('Tables.json', Self.st1.GetValue())
                End
            End
        End

        CurrentExeFullPathAnsi     = Self.WinApi.GetCurrentExeFullPathAnsi()
        TargetExeFullPathAnsi     &= Self.BitConverter.ConcatAnsi(False, , Self.KnownFolders.ApplicationFullPathAnsi, '\' , Self.KnownFolders.ApplicationNameAnsi, '.exe' & Chr(0))
        CurrentExeFullPathUtf16     = Self.WinApi.GetCurrentExeFullPathUtf16()
        TargetExeFullPathUtf16     &= Self.BitConverter.ConcatUtf16(False, , Self.KnownFolders.ApplicationFullPathUtf16, '\' & Chr(0), Self.KnownFolders.ApplicationNameUtf16, '.' & Chr(0) & 'e' & Chr(0) & 'x' & Chr(0) & 'e' & Chr(0), Chr(0) & Chr(0))

        If TargetExeFullPathUtf16 &= NULL
            Message('error TargetExeFullPathUtf16 is null')
        End

        If Lower(Clip(CurrentExeFullPathUtf16)) = Lower(Clip(TargetExeFullPathUtf16)) !And 1 > 2 ! force to always copy
        Else
            Self.WinApi.CopyFileUtf16(Clip(CurrentExeFullPathUtf16), TargetExeFullPathUtf16)
            CloseAndRestart = True
        End
        If CloseAndRestart = TRUE And 1 > 2
            InfoW_Verb                       &= NEW String(1000)
            InfoW_File                       &= NEW String(1000)
            InfoW_Parameters                 &= NEW String(1000)
            InfoW_Directory                  &= NEW String(1000)
            InfoW_Verb                          = 'r' & Chr(0) & 'u' & Chr(0) & 'n' & Chr(0) & 'a' & Chr(0) & 's' & Chr(0) & Chr(0) & Chr(0)
            InfoW_File                          = TargetExeFullPathUtf16
            InfoW_Directory                     = Clip(Self.KnownFolders.ApplicationFullPathUtf16)     & Chr(0) & Chr(0)
            Clear(SHELLEXECUTEINFOW)
            SHELLEXECUTEINFOW.Size           = Size(SHELLEXECUTEINFOW)
            SHELLEXECUTEINFOW.Mask           = 0
            SHELLEXECUTEINFOW.hwnd           = 0
            SHELLEXECUTEINFOW.Verb           = Address(InfoW_Verb)
            SHELLEXECUTEINFOW.File           = Address(InfoW_File)
            SHELLEXECUTEINFOW.Parameters     = 0
            SHELLEXECUTEINFOW.Directory      = Address(InfoW_Directory)
            SHELLEXECUTEINFOW.Show           = C25_SW_SHOWNORMAL
            SHELLEXECUTEINFOW.hInstApp       = 0
            SHELLEXECUTEINFOW.IDList         = 0
            SHELLEXECUTEINFOW.Class          = 0
            SHELLEXECUTEINFOW.keyClass       = 0
            SHELLEXECUTEINFOW.HotKey         = 0
            SHELLEXECUTEINFOW.Icon           = 0
            SHELLEXECUTEINFOW.Process        = 0

            X# = c25_ShellExecuteExW(Address(SHELLEXECUTEINFOW))
            Dispose(InfoW_Verb)
            Dispose(InfoW_File)
            Dispose(InfoW_Parameters)
            Dispose(InfoW_Directory)
        End
        Dispose(TargetExeFullPathUtf16)

        If CloseAndRestart = TRUE
        End

        Return ''

c25ResourceHandlerClass.ImportResourcesQJson        Procedure(String _resourceName, <Byte _fromDisk>)

FromFilePath                                            String(1024)

    Code

        Free(Self.ResourcesQ)
        FromFilePath = _resourceName
        If FromFilePath[2] = Chr(0) And Len(Clip(FromFilePath)) > 5
        Else
            Self.St1.Start()
            If _fromDisk
                Message('hier _fromDisk ' & _resourceName)
                Self.st1.LoadFile(Clip(FromFilePath))
            Else
                Message('hier ' & _resourceName)
                Self.st1.SetValue(Self.ExtractResource(_resourceName))
            End
        End

        If Self.Js1 &= null
            Self.Js1 &= New JSONClass()
        End
        Self.Js1.Start()
        Self.Js1.SetTagCase(jF:CaseAsIs)
        Self.Js1.SetFreeQueueBeforeLoad(True)
        Self.Js1.Load(Self.ResourcesQ,Self.st1)

        Return Records(Self.ResourcesQ)

c25ResourceHandlerClass.GenerateJsonFile        Procedure()

FileEntryQ      QUEUE,PRE(FileEntryQ)
name              String(FILE:MAXFILENAME)
shortname         String(13)
date              Long
time              Long
size              Long
attrib            Byte
                End
    Code

        Self.Js1 &= New(JSONClass)
        Self.Js1.Start()
        Self.Js1.SetTagCase(jF:CaseAsIs)
        Self.Js1.SetFreeQueueBeforeLoad(True)
        Self.ResourcesQ.OnInstallOnly = True
        Self.ResourcesQ.ResourceName = 'RESOURCES\DLL\SQLITE3_DAT'
        Self.ResourcesQ.FileNameAnsi = 'Sqlite3.dll'
        Self.ResourcesQ.ReturnType = 'file'
        Self.ResourcesQ.FileExtension = 'dll'
        Self.ResourcesQ.TargetFolderType = 'application'
        Add(Self.ResourcesQ);Clear(Self.ResourcesQ)

        Self.ResourcesQ.OnInstallOnly = True
        Self.ResourcesQ.ResourceName = 'RESOURCES\DLL\c25APPROOT_DAT'
        Self.ResourcesQ.FileNameAnsi = 'c25AppRoot.dll'
        Self.ResourcesQ.ReturnType = 'file'
        Self.ResourcesQ.FileExtension = 'dll'
        Self.ResourcesQ.TargetFolderType = 'application'
        Add(Self.ResourcesQ);Clear(Self.ResourcesQ)

        Self.ResourcesQ.OnInstallOnly = True
        Self.ResourcesQ.ResourceName = 'RESOURCES\DLL\CRC32C32_DAT'
        Self.ResourcesQ.FileNameAnsi = 'crc32c32.dll'
        Self.ResourcesQ.ReturnType = 'file'
        Self.ResourcesQ.FileExtension = 'dll'
        Self.ResourcesQ.TargetFolderType = 'application'
        Add(Self.ResourcesQ);Clear(Self.ResourcesQ)

        Self.ResourcesQ.OnInstallOnly = True
        Self.ResourcesQ.ResourceName = 'RESOURCES\DLL\c25GLOBALTHREADSAFE_DAT'
        Self.ResourcesQ.FileNameAnsi = 'c25GlobalThreadSafe.dll'
        Self.ResourcesQ.ReturnType = 'file'
        Self.ResourcesQ.FileExtension = 'dll'
        Self.ResourcesQ.TargetFolderType = 'application'
        Add(Self.ResourcesQ);Clear(Self.ResourcesQ)

        Self.ResourcesQ.OnInstallOnly       = True
        Self.ResourcesQ.ResourceName        = 'RESOURCES\DLL\c25DATABASEHANDLER_DAT'
        Self.ResourcesQ.FileNameAnsi        = 'c25DatabaseHandler.dll'
        Self.ResourcesQ.ReturnType          = 'file'
        Self.ResourcesQ.FileExtension       = 'dll'
        Self.ResourcesQ.TargetFolderType    = 'application'
        Add(Self.ResourcesQ);Clear(Self.ResourcesQ)

        Self.ResourcesQ.OnInstallOnly       = True
        Self.ResourcesQ.ResourceName        = 'RESOURCES\DLL\c25RENDERENGINE_DAT'
        Self.ResourcesQ.FileNameAnsi        = 'c25RenderEngine.dll'
        Self.ResourcesQ.ReturnType          = 'file'
        Self.ResourcesQ.FileExtension       = 'dll'
        Self.ResourcesQ.TargetFolderType    = 'application'
        Add(Self.ResourcesQ);Clear(Self.ResourcesQ)

        Self.ResourcesQ.OnInstallOnly = True
        Self.ResourcesQ.ResourceName = 'RESOURCES\SQLITE\CURSORQNAV_DAT'
        Self.ResourcesQ.FileNameAnsi = 'CursorQNav.sqlite'
        Self.ResourcesQ.ReturnType = 'file'
        Self.ResourcesQ.FileExtension = 'sqlite'
        Self.ResourcesQ.TargetFolderType = 'userdata'
        Add(Self.ResourcesQ);Clear(Self.ResourcesQ)

        Self.ResourcesQ.OnInstallOnly = True
        Self.ResourcesQ.ResourceName = 'RESOURCES\SQLITE\DEFAULTS_DAT'
        Self.ResourcesQ.FileNameAnsi = 'Defaults.sqlite'
        Self.ResourcesQ.ReturnType = 'file'
        Self.ResourcesQ.FileExtension = 'sqlite'
        Self.ResourcesQ.TargetFolderType = 'programdata'
        Add(Self.ResourcesQ);Clear(Self.ResourcesQ)

        directory(FileEntryQ,'.\resources\json\*.json',ff_:NORMAL)
        I# = 0
        LOOP
            I# = I# + 1
            Get(FileEntryQ,I#)
            If Errorcode() <> 0
                BREAK
            End
            Clear(Self.ResourcesQ)
            Self.ResourcesQ.OnInstallOnly           = False
            Self.ResourcesQ.OnInstalledOnly         = False
            Self.st1.Start()
            Self.st1.SetValue(FileEntryQ:name)
            Self.st1.Replace('.json','_json')
            Self.st1.Upper()
            Self.ResourcesQ.ResourceName            = 'RESOURCES\JSON\' & Self.st1.GetValue()
            Self.ResourcesQ.FileNameAnsi            = Clip(FileEntryQ:name)
            Self.ResourcesQ.ReturnType              = 'memoryfile'
            Self.ResourcesQ.FileExtension           = 'json'
            Self.ResourcesQ.TargetFolderType        = 'memory'
            Add(Self.ResourcesQ)
        End

        Self.Js1.DisableField(Self.ResourcesQ,'FileNameUtf8')
        Self.Js1.DisableField(Self.ResourcesQ,'FileNameUtf16')
        Self.Js1.DisableField(Self.ResourcesQ,'ExtractToFullPathAnsi')
        Self.Js1.DisableField(Self.ResourcesQ,'ExtractToFullPathUtf8')
        Self.Js1.DisableField(Self.ResourcesQ,'ExtractToFullPathUtf16')
        Self.Js1.Save(Self.ResourcesQ,'.\Resources\json\ResourcesQ.Json','',json:Object)
        Return ''

c25ResourceHandlerClass.ExtractFontsAndInstall  Procedure()

    Code

        Return ''

