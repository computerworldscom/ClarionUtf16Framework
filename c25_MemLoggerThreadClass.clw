    Member

    Include('c25_MemLoggerThreadClass.inc'),Once

    Map
        Include('i64.inc'),Once
        Include('cwutil.inc'),Once
        Include('c25_WinApiPrototypes.clw'),Once
    End

c25MemLoggerThreadClass.Construct                             Procedure()

Code

    !Message('c25MemLoggerThreadClass.Construct')

    Self.MappedFileNameA &= NEW String('Global\ClarionLogger' & Chr(0))
    Self.MappedFileNameA = 'Global\ClarionLogger' & Chr(0)

    Self.NanoSync   &= NEW c25NanoSyncClass()
    Self.LogLines   &= NEW LogLines_TYPE()


!!    Self.WindowHandler &= NEW c25WindowHandlerClass()
!!    Self.WindowHandler.InitWindow('MemLogger')
!!    Self.WindowHandler.OpenWindow()

!    Self.OpenSharedMemory()

c25MemLoggerThreadClass.Destruct                              Procedure()

Code

    Self.CloseMappedFile()

c25MemLoggerThreadClass.CloseMappedFile                       Procedure()

Code

    If Self.MappedFileBufferHandle <> 0
       c25_UnmapViewOfFile(Self.MappedFileBufferHandle)
    End
    If Self.MappedFileHandle <> 0
       c25_CloseHandle(Self.MappedFileHandle)
    End
    Return 0

c25MemLoggerThreadClass.AddLine                               Procedure(String _line)

Code


    If Self.MappedFileHandle = 0
        Self.OpenSharedMemory()
    End
    If Self.MappedFileHandle = 0
        Return ''
    End
    L# = Len(Clip(_line))
    If L# = 0
        L# = 1
    End
    Return 0



    !Self.LogLines.Line &= NEW String(L#)
    !Self.LogLines.Line = _line
    !Add(Self.LogLines)

!   pBuf = (LPTSTR) MapViewOfFile(hMapFile, // handle to map object
!               FILE_MAP_ALL_ACCESS,  // read/write permission
!               0,
!               0,
!               BUF_SIZE);


!       pBuf = (LPTSTR) MapViewOfFile(hMapFile, // handle to map object
!                   FILE_MAP_ALL_ACCESS,  // read/write permission
!                   0,
!                   0,
!                   BUF_SIZE);

c25MemLoggerThreadClass.OpenSharedMemory                      Procedure()

Code


    Self.MappedFileHandle = c25_OpenFileMappingA(c25_FILE_MAP_ALL_ACCESS, False, Address(Self.MappedFileNameA))
    If Self.MappedFileHandle = 0
        Return 0
    End
    Self.MappedFileBufferHeaderHandle = c25_MapViewOfFile(Self.MappedFileHandle, c25_FILE_MAP_ALL_ACCESS, 0,0, 1024)
    Return 0