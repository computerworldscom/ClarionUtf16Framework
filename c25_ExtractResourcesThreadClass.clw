                    Member

            Include('c25_ExtractResourcesThreadClass.inc'),once
            Map
                Include('c25_WinApiPrototypes.inc')
                Include('i64.inc')
            End

c25_ExtractResourcesThreadClass.Construct                   Procedure()

ClassStarter    &c25_ClassStarter

Code
    
    Self.ClassTypeName = 'c25_ExtractResourcesThreadClass'

    ClassStarter &= NEW c25_ClassStarter()
    Self.ProgramHandlerClass &= (ClassStarter.Start(Self.ClassTypeName))
    Dispose(ClassStarter)
       
    Self.St1                   &= NEW StringTheory
    !Self.StLog                 &= NEW StringTheory
    !Self.StLogFileName          = 'm:\ExtractResources.txt'
    Self.CRLF                   = Chr(13) & Chr(10)
    Self.Zero                   = Chr(0)
    Self.Zero2                  = Chr(0) & Chr(0)
    Self.ResourcesQ            &= NEW Resources_TYPE()
    Self.Js1                   &= New JSONClass()
    Self.WinApiClass           &= Self.ProgramHandlerClass.WinApiClass
    Self.BitConverterClass     &= New c25_BitConverterClass()
    
    !Self.StLog.SetValue('start ' & SElf.CRLF)
    !Remove(!Self.StLogFileName)
    !Self.StLog.SaveFile(!Self.StLogFileName)
    

c25_ExtractResourcesThreadClass.Destruct                    Procedure()

    CODE

c25_ExtractResourcesThreadClass.Start                       Procedure(<byte _isInstalledParam>)

ThreadInfoSourceAddress                                     LONG
ThreadInfoTargetAddress                                     LONG
ThreadInfo                                                  Group(ThreadInfo_TYPE)
                                                            End
SizeThreadInfo                                              LONG
GetKnownFolders                                             Byte
GettingKnownFolders                                         Byte
GotKnownFolders                                             Byte
ToExtract                                                   Byte
Extracting                                                  Byte
Extracted                                                   Byte
ToUnRar                                                     Byte
UnRarring                                                       byte
UnRarred                                                        Byte
StLog                                                           &StringTheory
StLogFileName                                                   cstring(128)
LineFeed                                                        string('<13><10>')


    CODE


!        StLogFileName = 'm:\extresStart.txt'
!        Remove(StLogFileName)
!        StLog &= NEW StringTheory()
!        StLog.SetValue(LineFeed)
!        StLog.SaveFile(StLogFileName)
        
        
        Self.IsInstalledParam       = _isInstalledParam
        
        
        
!        Self.KnownFolders           &= NEW KnownFolders_TYPE()
!
!        GettingKnownFolders = True
        
        
        !Self.KnownFolders = Self.WinApiClass.GetKnownFolders()
        
        
!        StLog.SetValue(Self.KnownFolders.DataStoreAppFullPathUtf16 & LineFeed)
!        StLog.SaveFile(StLogFileName, true)
        
        !Self.WinApiClass.FindOrCreateFolderUtf16(Self.KnownFolders.DataStoreAppFullPathUtf16)
        
        
        
!        Self.WinApiClass.FindOrCreateFolderUtf16(Self.KnownFolders.DataStoreFullPathUtf16)
!        Self.WinApiClass.FindOrCreateFolderUtf16(Self.KnownFolders.ApplicationFullPathUtf16)
!        Self.WinApiClass.FindOrCreateFolderUtf16(Self.KnownFolders.ProgramDataFolderUtf16)
!        Self.WinApiClass.FindOrCreateFolderUtf16(Self.KnownFolders.DataStoreUserFullPathUtf16)
!        GettingKnownFolders = FALSE
!        GotKnownFolders = TRUE
!        GetKnownFolders = FALSE
!        ToExtract = TRUE
!        Extracting = 0
!        Extracted = 0
!
        Self.ExtractResources()
!
!        ToExtract = 0
!        Extracting = 0
!        Extracted = TRUE
!
!        If not Self.SystemClassesQ &= NULL
!            I# = 0
!            LOOP
!                I# = I# + 1
!                Get(Self.SystemClassesQ,I#)
!                If Errorcode() <> 0
!                    Break
!                End
!                Self.WinApiClass.GlobalMem.SystemClassesQ = Self.SystemClassesQ
!                Add(Self.WinApiClass.GlobalMem.SystemClassesQ)
!            End
!            If Records(Self.WinApiClass.GlobalMem.SystemClassesQ) = 0
!                Message('error Self.WinApiClass.GlobalMem.SystemClassesQ')
!            End
!        End
!        If not Self.DevicePropDefQ &= NULL
!            I# = 0
!            LOOP
!                I# = I# + 1
!                Get(Self.DevicePropDefQ,I#)
!                If Errorcode() <> 0
!                    Break
!                End
!                Self.WinApiClass.GlobalMem.DevicePropDefQ = Self.DevicePropDefQ
!                Add(Self.WinApiClass.GlobalMem.DevicePropDefQ)
!            End
!            If Records(Self.WinApiClass.GlobalMem.DevicePropDefQ) = 0
!                Message('error Self.WinApiClass.GlobalMem.DevicePropDefQ')
!            End
!        End
!        Self.WinApiClass.GlobalMem.DataExtracted = True
        Return True

c25_ExtractResourcesThreadClass.ExtractResource                 Procedure(<string _resourceName>, <Resources_TYPE _resourcesQ>, <string _ouputPath>)

ResourceGrp                                                     Group(Resources_TYPE),pre(ResourceGrp)
                                                                End
ResourceName                                                    string(2048)
ResourceNameUpper                                               string(2048)
ExeFileName                                                     string(2048)
WriteHandle                                                     Long

    CODE

        
        
        If not Self.BufferString &= null
            Dispose(Self.BufferString)
        End
        
        
        If Self.ProcessHeapHandle = 0
            Self.ProcessHeapHandle = c25_GetProcessHeap()
        End
        Self.ResourceType = 'IMAGE' & Chr(0)
        Self.AppInstance = 0
        c25_GetModuleHandleExA(C25_GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT ,0,Address(Self.AppInstance))
        
        If Self.AppInstance = 0
            Message('error setup Self.AppInstance = 0')
        End
        
        If Omitted(_resourceName) = False
            ResourceName = Clip(_resourceName) & Chr(0)
        End
        
        If Omitted(_resourcesQ) = False
            ResourceGrp = _resourcesQ
            ResourceName = Clip(ResourceGrp.ResourceName) & Chr(0)
        End
        
        Self.ResourceHandle = 0
        
        Self.ResourceHandle = c25_FindResourceA(Self.AppInstance, Address(ResourceName), Address(Self.ResourceType))
        
        !Message('Self.ResourceHandle ' & Self.ResourceHandle)
        
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
            If Self.WinApiClass.FileOrFolderExistUtf16(_ouputPath) = False
                WriteHandle = c25_CreateFileW(Address(_ouputPath),C25_GENERIC_WRITE + C25_GENERIC_READ, C25_FILE_SHARE_WRITE,0,C25_CREATE_NEW,080h,0)
                If WriteHandle <> C25_INVALID_HANDLE_VALUE
                    X# = c25_WriteFile(WriteHandle,Self.HeapMemAddress,Self.SizeResource,0,0)
                    c25_CloseHandle(WriteHandle)
                End
            End
            c25_HeapFree(Self.ProcessHeapHandle,0,Self.HeapMemAddress)
        Else
            Self.BufferString &= NEW STRING(Self.SizeResource)
            c25_MemCpy(Address(Self.BufferString), Self.ResourceDataHandlePtr, Self.SizeResource)
            c25_HeapFree(Self.ProcessHeapHandle, 0, Self.HeapMemAddress)
            Return Self.BufferString
        End
        Return ''

c25_ExtractResourcesThreadClass.ExtractResources                    Procedure()

GenerateJsonFile                                                Byte
CurrentExeFullPathAnsi                                          string(4096)
TargetExeFullPathAnsi                                           &STRING
CurrentExeFullPathUtf16                                         string(4096)
TargetExeFullPathUtf16                                          &STRING
CloseAndRestart                                                 Byte
ShellExecuteInfoW                                               Group(ShellExecuteInfoW_TYPE),Pre(ShellExecuteInfoW)
                                                                End
InfoW_Verb                                                      &STRING
InfoW_File                                                      &STRING
InfoW_Parameters                                                &STRING
InfoW_Directory                                                 &STRING
GlobalMemDictionary                                             &Dictionary_TYPE

    CODE

        Free(Self.ResourcesQ)
        GenerateJsonFile = False
        If GenerateJsonFile = TRUE
            Self.GenerateJsonFile()
        End
        
        R# = Self.ImportResourcesQJson('RESOURCES\JSON\RESOURCESQ_JSON')
        If R# = 0
            Return ''
        End
        
!        if  Self.WinApiClass.GlobalMem.Dictionary &= NULL
!            Message(' Self.WinApiClass.GlobalMem.Dictionary is null')
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
                Break
            End
            
            
!            Message(Clip(Self.ResourcesQ.FileNameAnsi))
!            Message(Clip(Self.ResourcesQ.ResourceName))
            
            
!            If Self.IsInstalledParam = 1
!                If Self.ResourcesQ.OnInstallOnly = 1
!                    CYCLE
!                End
!                If Self.ResourcesQ.OnInstalledOnly = 0
!                    CYCLE
!                End
!            End
!            If Self.IsInstalledParam = 0
!                If Self.ResourcesQ.OnInstalledOnly = 1
!                    CYCLE
!                End
!            End
            
            !Message(Self.ResourcesQ.TargetFolderType)
            
            Case lower(Self.ResourcesQ.TargetFolderType)
            Of 'userdata'
!                Self.ResourcesQ.ExtractToFullPathAnsi &= Self.BitConverterClass.ConcatAnsi(true, '\', self.KnownFolders.DataStoreUserFullPathAnsi, Self.ResourcesQ.FileNameAnsi)
!                Self.ResourcesQ.FileNameUtf16 &= Self.BitConverterClass.AnsiToUtf16(Clip(Self.ResourcesQ.FileNameAnsi))
!                Self.ResourcesQ.ExtractToFullPathUtf16 &= Self.BitConverterClass.ConcatUtf16(false, , self.KnownFolders.DataStoreUserFullPathUtf16, '\' & Chr(0), Self.ResourcesQ.FileNameUtf16, Chr(0) & Chr(0))
!                Self.ExtractResource(,Self.ResourcesQ)
!                Dispose(Self.ResourcesQ.ExtractToFullPathAnsi)
!                Dispose(Self.ResourcesQ.FileNameUtf16)
!                Dispose(Self.ResourcesQ.ExtractToFullPathUtf16)
            Of 'programdata'
!                Self.ResourcesQ.ExtractToFullPathAnsi &= Self.BitConverterClass.ConcatAnsi(true, '\', self.KnownFolders.ProgramDataFolderAnsi, Self.ResourcesQ.FileNameAnsi)
!                Self.ResourcesQ.FileNameUtf16 &= Self.BitConverterClass.AnsiToUtf16(Clip(Self.ResourcesQ.FileNameAnsi))
!                Self.ResourcesQ.ExtractToFullPathUtf16 &= Self.BitConverterClass.ConcatUtf16(false, , self.KnownFolders.ProgramDataFolderUtf16, '\' & Chr(0), Self.ResourcesQ.FileNameUtf16, Chr(0) & Chr(0))
!                Self.ExtractResource(,Self.ResourcesQ)
!                Dispose(Self.ResourcesQ.ExtractToFullPathAnsi)
!                Dispose(Self.ResourcesQ.FileNameUtf16)
!                Dispose(Self.ResourcesQ.ExtractToFullPathUtf16)
            Of 'data'
!                Self.ResourcesQ.ExtractToFullPathAnsi &= Self.BitConverterClass.ConcatAnsi(true, '\', self.KnownFolders.DataStoreAppFullPathAnsi, Self.ResourcesQ.FileNameAnsi)
!                Self.ResourcesQ.FileNameUtf16 &= Self.BitConverterClass.AnsiToUtf16(Clip(Self.ResourcesQ.FileNameAnsi))
!                Self.ResourcesQ.ExtractToFullPathUtf16 &= Self.BitConverterClass.ConcatUtf16(false, , self.KnownFolders.DataStoreAppFullPathUtf16, '\' & Chr(0), Self.ResourcesQ.FileNameUtf16, Chr(0) & Chr(0))
!                Self.ExtractResource(,Self.ResourcesQ)
!                Dispose(Self.ResourcesQ.ExtractToFullPathAnsi)
!                Dispose(Self.ResourcesQ.FileNameUtf16)
!                Dispose(Self.ResourcesQ.ExtractToFullPathUtf16)
            Of 'application'
                !Message(Self.ProgramHandlerClass.ApplicationPathAnsi)
                
                If not Self.ExtractPath &= NULL
                    Dispose(Self.ExtractPath)
                End
                Self.ExtractPath &= Self.BitConverterClass.BinaryCopy(Self.ProgramHandlerClass.ApplicationPathUtf16 & '\' & Chr(0) & self.BitConverterClass.AnsiToUtf16(Clip(Self.ResourcesQ.FileNameAnsi)) & Chr(0) & Chr(0))
                
                !Message( self.BitConverterClass.Utf16ToAnsi (Self.ExtractPath))
                
                
                !Message(Self.ExtractPath)
                
!                Self.ResourcesQ.FileNameUtf16 &= Self.BitConverterClass.AnsiToUtf16(Clip(Self.ResourcesQ.FileNameAnsi))
!                Self.ResourcesQ.ExtractToFullPathUtf16 &= Self.BitConverterClass.ConcatUtf16(false, , self.KnownFolders.ApplicationFullPathUtf16, '\' & Chr(0), Self.ResourcesQ.FileNameUtf16, Chr(0) & Chr(0))
!
!                Message(Clip(Self.ResourcesQ.ResourceName))
                
                
                
                Self.ExtractResource( , Self.ResourcesQ, Self.ExtractPath)
                
                
                
                
!                Dispose(Self.ResourcesQ.ExtractToFullPathAnsi)
!                Dispose(Self.ResourcesQ.FileNameUtf16)
!                Dispose(Self.ResourcesQ.ExtractToFullPathUtf16)
!
!                Self.ResourcesQ.ExtractToFullPathAnsi &= Self.BitConverterClass.BinaryCopy('.\' & Self.ResourcesQ.FileNameAnsi)
!                Self.ResourcesQ.FileNameUtf16 &= Self.BitConverterClass.AnsiToUtf16(Clip(Self.ResourcesQ.FileNameAnsi))
!                Self.ResourcesQ.ExtractToFullPathUtf16 &= Self.BitConverterClass.BinaryCopy('.' & Chr(0) & '\' & Chr(0) & Self.ResourcesQ.FileNameUtf16 & Chr(0) & Chr(0))
!
!                Self.ExtractResource(,Self.ResourcesQ)
!
!                Dispose(Self.ResourcesQ.ExtractToFullPathAnsi)
!                Dispose(Self.ResourcesQ.FileNameUtf16)
!                Dispose(Self.ResourcesQ.ExtractToFullPathUtf16)

            Of 'memory'
!                If Self.Js1 &= null
!                    Self.Js1 &= New JSONClass()
!                End
                Self.Js1.Start()
                Self.Js1.SetTagCase(jF:CaseAny)
                Self.Js1.SetFreeQueueBeforeLoad(True)
                
                Self.st1.Start()
                Self.st1.SetValue(Self.ExtractResource(,Self.ResourcesQ))
                
                !Message(Self.st1.GetValue())
                
                Case Clip(Self.ResourcesQ.FileNameAnsi)
                Of 'DevicePropDef.json'
!                    Self.DevicePropDefQ &= NEW DevicePropDef_TYPE
!                    Self.Js1.Load(Self.DevicePropDefQ,Self.st1)
!                    Z# = 0
!                    LOOP
!                        Z# = Z# + 1
!                        Get(Self.DevicePropDefQ,Z#)
!                        If Errorcode() <> 0
!                            BREAK
!                        End
!                        Self.DevicePropDefQ.NameUtf16 &= Self.BitConverterClass.AnsiToUtf16(Clip(Self.DevicePropDefQ.NameAnsi))
!                        Self.DevicePropDefQ.CodeNameUpperUtf16 &= Self.BitConverterClass.AnsiToUtf16(Clip(Self.DevicePropDefQ.CodeNameUpperAnsi))
!                        Self.DevicePropDefQ.DescriptionUtf16 &= Self.BitConverterClass.AnsiToUtf16(Clip(Self.DevicePropDefQ.DescriptionAnsi))
!                        Put(Self.DevicePropDefQ)
!                    End

                Of 'SystemClasses.json'
                    
                    Self.SystemClassesFlat &= NEW SystemClassesFlat_TYPE
                    Self.ProgramHandlerClass.GlobalDataClass.SystemClasses &= NEW SystemClasses_TYPE
                    Self.SystemClasses &= Self.ProgramHandlerClass.GlobalDataClass.SystemClasses
                    Self.Js1.Load(Self.SystemClassesFlat,Self.st1)
                    
                    !Message('hier Self.SystemClassesQ ' & Records(Self.SystemClassesQ))
                    
                    I# = 0
                    LOOP
                        I# = I# + 1
                        Get(Self.SystemClassesFlat,I#)
                        If Errorcode() <> 0
                            BREAK
                        End
                        Self.SystemClasses.ROWID            = Self.SystemClassesFlat.ROWID
                        Self.SystemClasses.Id               = Self.SystemClassesFlat.Id
                        Self.SystemClasses.FsFilter         = Self.SystemClassesFlat.FsFilter
                        Self.SystemClasses.SystemUse        = Self.SystemClassesFlat.SystemUse
                        
                        Self.SystemClasses.Guid16           &= Self.BitConverterClass.Guid16FromGuid36(Clip(Self.SystemClassesFlat.Guid36Ansi))
                        Self.SystemClasses.Guid36Ansi       &= Self.BitConverterClass.BinaryCopy(Clip(Self.SystemClassesFlat.Guid36Ansi))
                        Self.SystemClasses.Guid36Utf16      &= Self.BitConverterClass.AnsiToUtf16(Clip(Self.SystemClassesFlat.Guid36Utf16))
                        Self.SystemClasses.NameAnsi         &= Self.BitConverterClass.BinaryCopy(Clip(Self.SystemClassesFlat.NameAnsi))
                        Self.SystemClasses.NameUtf16        &= Self.BitConverterClass.AnsiToUtf16(Clip(Self.SystemClassesFlat.NameUtf16))
                        Self.SystemClasses.ClassNameAnsi    &= Self.BitConverterClass.BinaryCopy(Clip(Self.SystemClassesFlat.ClassNameAnsi))
                        Self.SystemClasses.ClassNameUtf16   &= Self.BitConverterClass.AnsiToUtf16(Clip(Self.SystemClassesFlat.ClassNameUtf16))
                        Self.SystemClasses.DescriptionAnsi  &= Self.BitConverterClass.BinaryCopy(Clip(Self.SystemClassesFlat.DescriptionAnsi))
                        Self.SystemClasses.DescriptionUtf16 &= Self.BitConverterClass.AnsiToUtf16(Clip(Self.SystemClassesFlat.DescriptionUtf16))
                        
!                        Self.SystemClasses.Guid36Utf16 &= Self.BitConverterClass.AnsiToUtf16(Clip(Self.SystemClassesQ.Guid36Ansi))
!                        !Self.SystemClassesQ.Guid38FormattedUtf16 &= Self.BitConverterClass.AnsiToUtf16(Clip(Self.SystemClassesQ.Guid38FormattedAnsi))
!                        Self.SystemClassesQ.NameUtf16 &= Self.BitConverterClass.AnsiToUtf16(Clip(Self.SystemClassesQ.NameAnsi))
!                        Self.SystemClassesQ.ClassNameUtf16 &= Self.BitConverterClass.AnsiToUtf16(Clip(Self.SystemClassesQ.ClassNameAnsi))
!                        Self.SystemClassesQ.DescriptionUtf16 &= Self.BitConverterClass.AnsiToUtf16(Clip(Self.SystemClassesQ.DescriptionAnsi))
!                        !Self.SystemClassesQ.Guid32HexUtf16 &= Self.BitConverterClass.AnsiToUtf16(Clip(Self.SystemClassesQ.Guid32HexAnsi))
!                        !Self.SystemClassesQ.Guid47HexUtf16 &= Self.BitConverterClass.AnsiToUtf16(Clip(Self.SystemClassesQ.Guid47HexAnsi))
                        Add(Self.SystemClasses)
                    End
                    
                    Self.SystemClasses &= NULL
                    
!!!                Of 'Adapters.json'
!!!                    Self.WinApiClass.GlobalMem.SetGlobalDictionaryValue('Adapters.json', Self.st1.GetValue())
!!!                Of 'Databases.json'
!!!                    Self.WinApiClass.GlobalMem.SetGlobalDictionaryValue('Databases.json', Self.st1.GetValue())
!!!
!!!                Of 'Sources.json'
!!!                    Self.WinApiClass.GlobalMem.SetGlobalDictionaryValue('Sources.json', Self.st1.GetValue())
!!!                Of 'Tables.json'
!!!                    Self.WinApiClass.GlobalMem.SetGlobalDictionaryValue('Tables.json', Self.st1.GetValue())
                End
            End
        END

!        CurrentExeFullPathAnsi     = Self.WinApiClass.GetCurrentExeFullPathAnsi()
!        TargetExeFullPathAnsi     &= Self.BitConverterClass.ConcatAnsi(false, , self.KnownFolders.ApplicationFullPathAnsi, '\' , self.KnownFolders.ApplicationNameAnsi, '.exe' & Chr(0))
!        CurrentExeFullPathUtf16     = Self.WinApiClass.GetCurrentExeFullPathUtf16()
!        TargetExeFullPathUtf16     &= Self.BitConverterClass.ConcatUtf16(false, , self.KnownFolders.ApplicationFullPathUtf16, '\' & Chr(0), self.KnownFolders.ApplicationNameUtf16, '.' & Chr(0) & 'e' & Chr(0) & 'x' & Chr(0) & 'e' & Chr(0), Chr(0) & Chr(0))
!
!        If TargetExeFullPathUtf16 &= NULL
!            Message('error TargetExeFullPathUtf16 is null')
!        END
!
!        If lower(Clip(CurrentExeFullPathUtf16)) = lower(Clip(TargetExeFullPathUtf16)) !And 1 > 2 ! force to always copy
!        Else
!            Self.WinApiClass.CopyFileUtf16(Clip(CurrentExeFullPathUtf16), TargetExeFullPathUtf16)
!            CloseAndRestart = True
!        End
!        If CloseAndRestart = TRUE And 1 > 2
!            InfoW_Verb                       &= NEW STRING(1000)
!            InfoW_File                       &= NEW STRING(1000)
!            InfoW_Parameters                 &= NEW STRING(1000)
!            InfoW_Directory                  &= NEW STRING(1000)
!            InfoW_Verb                          = 'r' & Chr(0) & 'u' & Chr(0) & 'n' & Chr(0) & 'a' & Chr(0) & 's' & Chr(0) & Chr(0) & Chr(0)
!            InfoW_File                          = TargetExeFullPathUtf16
!            InfoW_Directory                     = Clip(Self.KnownFolders.ApplicationFullPathUtf16)     & Chr(0) & Chr(0)
!            Clear(SHELLEXECUTEINFOW)
!            SHELLEXECUTEINFOW.Size           = Size(SHELLEXECUTEINFOW)
!            SHELLEXECUTEINFOW.Mask           = 0
!            SHELLEXECUTEINFOW.hwnd           = 0
!            SHELLEXECUTEINFOW.Verb           = Address(InfoW_Verb)
!            SHELLEXECUTEINFOW.File           = Address(InfoW_File)
!            SHELLEXECUTEINFOW.Parameters     = 0
!            SHELLEXECUTEINFOW.Directory      = Address(InfoW_Directory)
!            SHELLEXECUTEINFOW.Show           = SW_SHOWNORMAL
!            SHELLEXECUTEINFOW.hInstApp       = 0
!            SHELLEXECUTEINFOW.IDList         = 0
!            SHELLEXECUTEINFOW.Class          = 0
!            SHELLEXECUTEINFOW.keyClass       = 0
!            SHELLEXECUTEINFOW.HotKey         = 0
!            SHELLEXECUTEINFOW.Icon           = 0
!            SHELLEXECUTEINFOW.Process        = 0
!
!            X# = c25_ShellExecuteExW(Address(SHELLEXECUTEINFOW))
!            Dispose(InfoW_Verb)
!            Dispose(InfoW_File)
!            Dispose(InfoW_Parameters)
!            Dispose(InfoW_Directory)
!        End
!        Dispose(TargetExeFullPathUtf16)
!
!        If CloseAndRestart = TRUE
!        End

        Return ''

c25_ExtractResourcesThreadClass.ImportResourcesQJson        Procedure(string _resourceName, <byte _fromDisk>)

FromFilePath                                            string(1024)

    CODE

        Free(Self.ResourcesQ)
        FromFilePath = _resourceName
        If FromFilePath[2] = Chr(0) And Len(Clip(FromFilePath)) > 5
        Else
            Self.St1.Start()
            If _fromDisk
                Self.st1.LoadFile(Clip(FromFilePath))
            Else
                !Message(': ' & _resourceName)
                
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

c25_ExtractResourcesThreadClass.GenerateJsonFile        Procedure()

FileEntryQ      QUEUE,PRE(FileEntryQ)
name              STRING(FILE:MAXFILENAME)
shortname         STRING(13)
date              LONG
time              LONG
size              LONG
attrib            BYTE
                end
    CODE

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
            END
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
        END

        self.Js1.DisableField(Self.ResourcesQ,'FileNameUtf8')
        self.Js1.DisableField(Self.ResourcesQ,'FileNameUtf16')
        self.Js1.DisableField(Self.ResourcesQ,'ExtractToFullPathAnsi')
        self.Js1.DisableField(Self.ResourcesQ,'ExtractToFullPathUtf8')
        self.Js1.DisableField(Self.ResourcesQ,'ExtractToFullPathUtf16')
        self.Js1.Save(Self.ResourcesQ,'.\Resources\json\ResourcesQ.Json','',json:Object)
        Return ''

c25_ExtractResourcesThreadClass.ExtractFontsAndInstall  Procedure()

    CODE

        RETURN ''


