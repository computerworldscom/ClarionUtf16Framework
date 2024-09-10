        Member
            Include('c25_ExtractResourcesClass.inc'),once
            Include('c25_ExtractResourcesThreadClass.inc'),once
            Map
                Include('c25_Prototypes_WinApi32.clw')
                Include('i64.inc')
                 ExtractResourcesThreadProcedure(Long _threadParamA,Long _threadParamB),Long,Pascal
            End

ExtractResourcesClass.Construct             Procedure()
    Code

ExtractResourcesClass.Destruct              Procedure()
    Code

ExtractResourcesClass.Start                 Procedure(<Byte _isInstalled>)
    Code

        Self.IsInstalledParam = _isInstalled
        Return Self.StartThread(1)

ExtractResourcesClass.StartThread            Procedure(<Long _threadQId>)

DataPumpThreadQId Long

    Code

        Self.ThreadInfoMem &= NEW String(Size(Self.ThreadInfo))
        Self.SizeThreadInfo = Size(Self.ThreadInfo)
        Self.ThreadInfoSourceAddress = Address(Self.ThreadInfoMem)
        Clear(Self.ThreadInfo,-1)
        Self.ThreadInfo.MessageLine                 = 'hello'
        Self.ThreadInfo.ParamC                     = Self.IsInstalledParam
        Self.ThreadInfoMem                         = Self.ThreadInfo
        Self.ThreadExtractHandle = c25_CreateThread(0, 010000h, Address(ExtractResourcesThreadProcedure),Self.ThreadInfoSourceAddress, 0 ,Address(Self.ThreadIdentity))
        Return Address(Self.ThreadInfo)

ExtractResourcesThreadProcedure         Procedure(Long _threadParamA, Long _threadParamB)

ExtractResourcesThread                      &ExtractResourcesThreadClass
ThreadInfoSourceAddress                     Long
ThreadInfoTargetAddress                     Long
ThreadInfo                                  Group(ThreadInfo_TYPE)
                                            End
SizeThreadInfo                              Long
NanoClock                                   &NanoSyncClass
GetKnownFolders                             Byte
GettingKnownFolders                         Byte
GotKnownFolders                             Byte
ToExtract                                   Byte
Extracting                                  Byte
Extracted                                   Byte
Installed                                   Byte
AppRootClassPtr                                Long

    Code

        c25_AttachThreadToClarion(True)

        ThreadInfoSourceAddress                     = _threadParamA
        ThreadInfoTargetAddress                     = Address(ThreadInfo)
        SizeThreadInfo                              = Size(ThreadInfo)

        c25_MemCpy(ThreadInfoTargetAddress,ThreadInfoSourceAddress,SizeThreadInfo)

        ExtractResourcesThread                       &= NEW ExtractResourcesThreadClass()
        ExtractResourcesThread.Installed             = ExtractResourcesThread.Start(ThreadInfo.ParamC)

        Installed = ExtractResourcesThread.Installed

        ThreadInfo.MessageLine = 'Installed'

        c25_MemCpy(ThreadInfoSourceAddress,ThreadInfoTargetAddress,SizeThreadInfo)
        c25_SleepEx(10,0)
        LOOP
            c25_SleepEx(400,0)
        End
        Dispose(ExtractResourcesThread)
        If ThreadInfo.ParamC = 0
            Return Installed
        End

        Return 0

