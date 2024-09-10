    INCLUDE('c25_BYTESHANDLERCLASS.INC'),ONCE
    INCLUDE('c25_DATATYPES.CLW'),ONCE
    INCLUDE('C25_DUMMY.CLW'), ONCE
    INCLUDE('c25_EQUATES_ITEMIZED.CLW'), ONCE
    INCLUDE('c25_EQUATES_SQLITE3.CLW'),ONCE
    INCLUDE('C25_DUMMY.CLW'),ONCE
    INCLUDE('C25_DUMMY.CLW'),ONCE
    INCLUDE('c25_HARDWARECLASS.INC'),ONCE
    INCLUDE('c25_LOGGERCLASS.INC'),ONCE
    INCLUDE('c25_MACHINECLASS.INC'),ONCE
    INCLUDE('c25_NANOSYNCCLASS.INC'), ONCE
    INCLUDE('c25_RENDERENGINECLASS.INC'), ONCE
    INCLUDE('c25_TRUEREFLECTIONCLASS.INC'),ONCE
    INCLUDE('c25_TYPES.CLW'),ONCE
    INCLUDE('c25_USERCLASS.INC'),ONCE
    INCLUDE('c25_WINAPI32CLASS.INC'), ONCE
    INCLUDE('CWSYNCHC.INC'),ONCE
    INCLUDE('ERRORS.CLW'),ONCE
    INCLUDE('JFILES.INC'),ONCE
    INCLUDE('NETALL.INC'),ONCE
    INCLUDE('NETDRIVE.INC'),ONCE
    INCLUDE('NETEMAIL.INC'),ONCE
    INCLUDE('NETFILE.INC'),ONCE
    INCLUDE('NETFTP.INC'),ONCE
    INCLUDE('NETHTTP.INC'),ONCE
    INCLUDE('NETLDAP.INC'),ONCE
    INCLUDE('NETMAP.INC'),ONCE
    INCLUDE('NETMAPS.INC'),ONCE
    INCLUDE('NETOAUTH.INC'),ONCE
    INCLUDE('NETSIMP.INC'),ONCE
    INCLUDE('NETSMS.INC'),ONCE
    INCLUDE('NETSYNC.INC'),ONCE
    INCLUDE('NETTALK.INC'),ONCE
    INCLUDE('NETWEB.INC'),ONCE
    INCLUDE('NETWEBM.INC'),ONCE
    INCLUDE('NETWEBSESSIONS.INC'),ONCE
    INCLUDE('NETWEBSMS.INC'),ONCE
    INCLUDE('NETWEBSOCKETCLIENT.INC'),ONCE
    INCLUDE('NETWEBSOCKETSERVER.INC'),ONCE
    INCLUDE('NETWSDL.INC'),ONCE
    INCLUDE('NETWWW.INC'),ONCE
    INCLUDE('STRINGTHEORY.INC'),ONCE


c25NetObjectClass           Class(),type, Module('c25_NetObjectClass.clw'), Link('c25_NetObjectClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
Construct                       Procedure()
Destruct                        Procedure()

Machine                         &MachineClass
GetEnumNamePacketType           Procedure(Long _packetType),String
BytesHandler                    &BytesHandlerClass
c25_OpenConnection              Function(Long _lParam, <Byte _debug>),Long,proc
c25_SendData                    Function(<*StringTheory _st>, <Long _lParam>, <String _fromIp>, <String _toIp>, <Long _onSocket>, <Long _toPort>, <Byte _debug>),Long,proc
c25_StartListener               Function(Long _lParam, <Byte _debug>),Long,proc
QueryStatus                     Function(Long _lParam, <Byte _debug>),Long,proc
CRLF                            String(2)
GlobalNanoSync                  &NanoSyncClass()
Id                              Long
IsFree                          BOOL
Logger                          &LoggerClass
NanoSync                        &NanoSyncClass
NetObject                       &NetWholePacket
NetObjectPtr                    Long
Phase                           Long
NetObjectSettings               &NetSimpleObject_TYPE()
PacketReceived                  Procedure(<Byte _debug>),Long,proc
Process                         Procedure(<Byte _debug>),Long,proc
SimpleAsyncOpenSuccessful       bool
StSend                          &StringTheory
St1                             &StringTheory
St2                             &StringTheory
TrueReflection                  &TrueReflectionClass()
UseLoopback                     BOOL
WinApi                          &WinApi32Class
LParam                          Long
GetPhaseEnumName                Procedure(Long _enumPhaseId),String
StatusCode                      Long

MachineObject                   &MachineClass
MachineQ                        &MachineQ_TYPE
                            End

