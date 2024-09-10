Include('c25_ProgramHandlerClass.inc'),Once

c25MemLogClass                                  Class(),type, Module('c25_MemLogClass.clw'), Link('c25_MemLogClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)

Construct                                           Procedure()
Destruct                                            Procedure()


LogLinesDefault                                     &LogLines_TYPE
Add_LogLine                                         Procedure(string _line)
BitConverter                                        &c25BitConverterClass()
BytesQ                                              &BytesQ_Type
CurrentCursor                                       decimal(20,0)
CurrentCursorHi                                     Long
CurrentCursorInt64                                  Like(INT64)
CurrentCursorLo                                     Long
CurrentPointerChanged                               BOOL
DecToHiAndLo                                        Procedure(string _dec, *long _hi, *long _lo)
EnumStMappedToQueue                                 Procedure(<*StringTheory _stMappedData>, <*BytesQ_TYPE _bytesQ>, <long _extraOffset>, <string _addressStart>, <string _startPos>),Long,Proc
Init                                                Procedure(<bool _isServer>, <string _globalFilenameA>, <long _windowHandle>),Long,Proc
IsServer                                            Bool
LastNewLogReadPosition                              Decimal(20,0)
LocalMappedClientHdr                                &MappedClientHdr_TYPE()
LocalMappedFileHdr                                  &MappedFileHdr_TYPE()
LogLines                                            &LogLines_TYPE
LogLinesDisplay                                     &LogLines_TYPE
LogLinesTemp                                        &LogLines_TYPE
MappedClientHdr                                     &MappedClientHdr_TYPE()
MappedFile_StartingAddress                          LONG
MappedFileHdr                                       &MappedFileHdr_TYPE()
MyDecimal                                           decimal(20,0)
MyHi                                                Long
MyInt64                                             Like(INT64)
MyLo                                                Long
NanoSync                                            &c25NanoSyncClass()
ParseMappedClientHdr                                Procedure(),String
ParseMappedFileHdr                                  Procedure(),String
Process_WM_NewLogEntry                              Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam),string,proc
ProgramHandler                                      &c25ProgramHandlerClass()
Read_NewLogEntries                                  Procedure(<string _startReadPtr>, <string _offsetDataAddress>),long,proc
ReadMappedClientHdr                                 Procedure(<bool _isClient>, <byte _show>),Long,Proc
ReadMappedData                                      Procedure(long _address, long _len, <*StringTheory _stMappedData>, <string _saveFileNameA>),string,Proc
ReadMappedDataInt                                   Procedure(<INT64 _ptr64>, <long _ptr>, <*long _int>, <byte _show>),Long,Proc
ReadMappedDataPage                                  Procedure(long _fromPageNo, <long _untilPageNo>, <*StringTheory _stMappedData>, <string _saveFileNameA>),Long,Proc
ReadMappedFileHdr                                   Procedure(<bool _isClient>, <byte _show>),Long,Proc
Refresh_LogLinesDisplay                             Procedure(),Long,Proc
RegisterWMs                                         Procedure(),Long,proc
ReRead                                              Procedure(),Long,proc
SetMappedFileHdr                                    Procedure(),Long,proc
SetMappedClientHdr                                  Procedure(),Long,proc
SharedMemory                                        &c25SharedMemoryClass()
SignalServer                                        Procedure(<long _startPtr>)
StMappedData                                        &StringTheory()
StMappedDataReturn                                  &StringTheory()
ValInt                                              long
WM_LogServerWindowHandle                            Long
WM_NewLogEntry                                      LONG
WM_NewLogToServer                                   Long
WM_RequestLogServerWindowHandle                     Long
WriteMappedClientHdr                                Procedure(),Long,Proc
WriteMappedData                                     Procedure(<long _targetAddress>, <*StringTheory _stMappedData>, <string _data>, <long _sourceOffset>, <long _targetOffset>, <long _len>),Long,Proc
WriteMappedDataInt                                  Procedure(INT64 _ptr, Long _int),Long,Proc
WriteMappedDataLogLines                             Procedure(<*StringTheory _stMappedData>, <string _logLine>, <*LogLines_TYPE _logLines>),Long,Proc
WriteMappedDataPage                                 Procedure(long _fromPageNo, <long _untilPageNo>, <*StringTheory _stMappedData>, <string _saveFileNameA>),Long,Proc
WriteMappedFileHdr                                  Procedure(),Long,Proc
                                                End

