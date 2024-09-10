    INCLUDE('c25_BYTESHANDLERCLASS.INC'),ONCE
    INCLUDE('c25_DATATYPES.CLW'),ONCE
    INCLUDE('C25_DUMMY.CLW'), ONCE
    INCLUDE('C25_DUMMY.CLW'), ONCE
    INCLUDE('c25_EQUATES_SQLITE3.CLW'),ONCE
    INCLUDE('C25_DUMMY.CLW'),ONCE
    INCLUDE('c25_GLOBALMEMCLASS.INC'),ONCE
    INCLUDE('c25_NANOSYNCCLASS.INC'),ONCE
    INCLUDE('c25_TYPES.CLW'),ONCE
    INCLUDE('c25_WINAPI32CLASS.INC'),ONCE
    INCLUDE('CWSYNCHC.INC'),ONCE
    INCLUDE('ERRORS.CLW'),ONCE
    INCLUDE('JFILES.INC'),ONCE
    INCLUDE('STRINGTHEORY.INC'),ONCE
!    INCLUDE('c25_TRUEREFLECTIONCLASS.INC'),ONCE
!    INCLUDE('MAXQUEUE.INC'),ONCE
!    INCLUDE('ODDJOB.INC'),ONCE
!    INCLUDE('REFLECTION.INC'),ONCE
!    INCLUDE('WINEVENT.INC'),ONCE

LogClass                            Class(),Type, Module('c25_LogClass.clw'), Link('c25_LogClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)

Construct                               Procedure()
Destruct                                Procedure()
Buffer2MB                               String(2000000)
Buffer65k                               String(65000)
BytesHandler                            &BytesHandlerClass
CRLF                                    String(2)
dataLen                                 Long
DisconnectAll                           Procedure(),String,proc
LogLines                                &LogLines_TYPE
LogPipeClient                           &PipeClient
LogPipeClientIsOpen                     Byte
LogServerWinHandle                      Long
!NanoSync                                &NanoSyncClass()
ReturnVal                               Long
st1                                     &StringTheory
stSend                                  &StringTheory
!WMC_LogLine                             Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam),Long,proc
WMC_LogLineQRec                         Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam),Long,proc
Status                                  cstring(1024)
LogLineQRef                             &LogLines_TYPE
Clear_LogLineQ                          Procedure(LogLines_TYPE _logLinesRecord),Long,proc
                                    End

