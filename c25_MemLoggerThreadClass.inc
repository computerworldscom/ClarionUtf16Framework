Include('c25_ProgramHandlerClass.inc'),Once

c25MemLoggerThreadClass                Class(),type, Module('c25_MemLoggerThreadClass.clw'), Link('c25_MemLoggerThreadClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)

Construct                               Procedure()
Destruct                                Procedure()

BufferHandle                            Long
CursorPtr                               Long
LogLines                                &LogLines_TYPE()
MappedFileBufferHandle                  Long
MappedFileBufferHeaderHandle            Long
MappedFileHandle                        Long
MappedFileNameA                         &String
NanoSync                                &c25NanoSyncClass()
OpenSharedMemory                        Procedure(),Long,PROC
CloseMappedFile                         Procedure(),Long,PROC
AddLine                                 Procedure(String _line),Long,proc
WindowHandler                           &c25WindowHandlerClass()
                                    End

