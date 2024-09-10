    INCLUDE('c25_BYTESHANDLERCLASS.INC'),ONCE
    INCLUDE('c25_DATATYPES.CLW'),ONCE
    INCLUDE('C25_DUMMY.CLW'), ONCE
    INCLUDE('C25_DUMMY.CLW'), ONCE
    INCLUDE('C25_DUMMY.CLW'),ONCE
    INCLUDE('c25_NANOSYNCCLASS.INC'),ONCE
    INCLUDE('c25_TYPES.CLW'),ONCE
    INCLUDE('c25_WINAPI32CLASS.INC'),ONCE
    INCLUDE('CWSYNCHC.INC'),ONCE
    INCLUDE('ERRORS.CLW'),ONCE
    INCLUDE('JFILES.INC'),ONCE
    INCLUDE('ODDJOB.INC'),ONCE
!    Include('c25_TrueReflectionClass.inc'),Once


LoggerClass                         Class(),Type, Module('c25_LoggerClass.clw'), Link('c25_LoggerClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)

Construct                               Procedure()
Destruct                                Procedure()

!TrueReflection                          &TrueReflectionClass
BytesHandler                            &BytesHandlerClass
Clear_LogLineQ                          Procedure(LogLines_TYPE _logLinesRecord),Long,proc
Copy                                    Procedure(*LogLines_TYPE _logLinesRecordTarget, *LogLines_TYPE _logLinesRecordSource, <Long _pointer>),Long,proc
CRLF                                    String(2)
FlushBuffer                             Procedure(),Long,proc
LogClientWinHandle                      Long
LogLinesBuffer                          &LogLines_TYPE
LogPipeClientIsOpen                     Byte
LogRecord                               &LogLines_TYPE
LogServerWinHandle                      Long
NanoSync                                &NanoSyncClass
PostLogLine                             Procedure(String _line, <String _module>,<String _threadName>, <String _functionName>),Long,proc
AddLogLine                              Procedure(String _logLine, <String _value>, <String _module>,<String _className>, <String _methodName>,<String _lastPhase>, <String _phase>, <String _nextPhase>),Long,proc
!AddLogLine(Self.LogLine, _value' _module',' _className' ,'_methodName', '_lastPhase', '_phase',' _nextPhase')
PostLogRecord                           Procedure(),Long,proc
StackBuffer                             Byte
WinApi                                  &WinApi32Class
SetLogClientWinHandle                   Procedure(),Long,proc


LogLine                                 Cstring(128)
Value                                   Cstring(128)
Module                                  Cstring(128)
ClassName                               Cstring(128)
MethodName                              Cstring(128)
LastPhase                               Cstring(128)
Phase                                   Cstring(128)
NextPhase                               Cstring(128)
RemotePort                              Long


Empty                                   Cstring(128)

ClearVariables                          Procedure()

PacketTypeEnum                          Long
PacketType                              cstring(128)
FromIp                                  cstring(32)
ToIp                                    cstring(32)
RemoteIp                                cstring(32)
OnSocket                                Long
SocketId                                Long
DataLen                                 Long
                                    End

