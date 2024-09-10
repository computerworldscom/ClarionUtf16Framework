    Member

    Include('c25_MemLoggerClass.inc'),Once

    Map
        Include('i64.inc'),Once
        Include('cwutil.inc'),Once
        Include('c25_WinApiPrototypes.clw'),Once

                            Module('c25_MemLoggerClass.clw')
c25LogWindowThread                 Procedure(Long _paramA, Long _paramB),Long
                            End
    End

c25MemLoggerClass.Construct                             Procedure()

Code

    Self.MappedFileHdr                                       &= NEW MappedFileHdr_TYPE()
    Self.MappedLogSrvHdr                                     &= NEW MappedLogSrvHdr_TYPE()
    Self.MappedLogClientHdr                                  &= NEW MappedLogClientHdr_TYPE()

!    Clear(Self.MappedFile)
!    Self.MappedFile.FileNameA = 'Global\AllMyDrivesLogger' & Chr(0)

    Self.RegisterWM()
    Self.InitWindow('LogWindow')
    Self.OpenWindow()

c25MemLoggerClass.Destruct                              Procedure()

Code

c25MemLoggerClass.RegisterWM                            Procedure()

RegMesStringA   String(250)

Code

    RegMesStringA = 'WM_RequestLogServerWindowHandle' & Chr(0)
    Self.WM_RequestLogServerWindowHandle    = c25_RegisterWindowMessageA(Address(RegMesStringA))

    RegMesStringA = 'WM_LogServerWindowHandle' & Chr(0)
    Self.WM_LogServerWindowHandle           = c25_RegisterWindowMessageA(Address(RegMesStringA))

    RegMesStringA = 'WM_NewLogToServer' & Chr(0)
    Self.WM_NewLogToServer                  = c25_RegisterWindowMessageA(Address(RegMesStringA))

    Return 0

c25MemLoggerClass.OpenSharedMemory                      Procedure()

Code

!    Self.MappedFile.FileHandle = c25_OpenFileMappingA(c25_FILE_MAP_ALL_ACCESS, False, Address(Self.MappedFile.FileNameA))
!    If Self.MappedFile.FileHandle = 0
!        Self.MappedFile.FileOpenError = C25_GetLastError()
!        Return 0
!    End
    !Self.MappedFile.ClientHeaderSize = Size(

!    Self.MappedFileBufferHeaderHandle = c25_MapViewOfFile(Self.MappedFileHandle, c25_FILE_MAP_ALL_ACCESS, 0,0, 1024)
    Return 0
    
c25MemLoggerClass.CloseMappedFile                       Procedure()

Code

!    If Self.MappedFileBufferHandle <> 0
!       c25_UnmapViewOfFile(Self.MappedFileBufferHandle)
!    End
!    If Self.MappedFileHandle <> 0
!       c25_CloseHandle(Self.MappedFileHandle)
!    End
    Return 0
    