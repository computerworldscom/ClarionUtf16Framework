    Member

    Include('c25_SharedMemoryClass.inc'),Once

    Map
        Include('i64.inc'),Once
        Include('cwutil.inc'),Once
        Include('c25_WinApiPrototypes.clw'),Once
    End

c25SharedMemoryClass.Construct                             Procedure()

Code

    
    Self.ProgramHandler &= NEW c25ProgramHandlerClass()
    Self.ProgramHandler &= Self.ProgramHandler.Singleton.GetPointer()
    Self.ProgramHandler.Singleton.Start()

    If Self.NanoSync &= null
        Self.NanoSync &= NEW c25NanoSyncClass()
    End
    If Self.BitConverter &= null
        Self.BitConverter &= NEW c25BitConverterClass()
    End

    
c25SharedMemoryClass.Destruct                              Procedure()

    Code
        
c25SharedMemoryClass.CreateMemoryMappedFile                 Procedure(string _globalFileNameA, long _sizeHi, long _sizeLo, <INT64 _sizeInt64>)

FileNameA       String(1024)
SizeLo          Long
SizeHi          Long
FileHandle      Long
FileOpenError   Long


Code
    

    FileNameA = Clip(Left(_globalFileNameA))
    
    SizeLo = _sizeLo
    !SizeLo = 1000000
    SizeHi = _sizeHi
    If UPPER(FileNameA[1 : 7]) <> 'GLOBAL\'
        FileNameA = 'Global\' & Clip(Left(FileNameA))
    End
    FileNameA = Clip(FileNameA) & Chr(0)

    FileHandle = c25_CreateFileMappingA(C25_INVALID_HANDLE_VALUE, 0, C25_PAGE_READWRITE, SizeHi, SizeLo, Address(FileNameA))
    If FileHandle = 0
        FileOpenError = C25_GetLastError()
        Message('error c25_CreateFileMappingA: ' & FileOpenError)
        Return 0
    End
    Return FileHandle
