    INCLUDE('c25_BYTESHANDLERCLASS.INC'),ONCE
    INCLUDE('c25_DATATYPES.CLW'),ONCE
    INCLUDE('C25_DUMMY.CLW'),ONCE
    INCLUDE('c25_EQUATES_ITEMIZED.CLW'),ONCE
    INCLUDE('c25_EQUATES_SQLITE3.CLW'),ONCE
    INCLUDE('C25_DUMMY.CLW'),ONCE
    INCLUDE('C25_DUMMY.CLW'),ONCE
    INCLUDE('c25_HARDWARECLASS.INC'),ONCE
    INCLUDE('c25_LOGGERCLASS.INC'),ONCE
    INCLUDE('c25_MACHINECLASS.INC'),ONCE
    INCLUDE('c25_NANOSYNCCLASS.INC'),ONCE
    INCLUDE('c25_NETOBJECTCLASS.INC'),ONCE
    INCLUDE('c25_RENDERENGINECLASS.INC'),ONCE
    INCLUDE('c25_TRUEREFLECTIONCLASS.INC'),ONCE
    INCLUDE('c25_TYPES.CLW'),ONCE
    INCLUDE('c25_USERCLASS.INC'),ONCE
    INCLUDE('c25_WINAPI32CLASS.INC'),ONCE
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
    INCLUDE('REFLECTION.INC'),ONCE
    INCLUDE('STRINGTHEORY.INC'),ONCE

c25ClientServerClass        Class(),type, Module('c25_ClientServerClass.clw'), Link('c25_ClientServerClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
Construct                       Procedure()
Destruct                        Procedure()

ActivateCloseWindow             Byte
AppMainWinHandle                Long
BytesHandler                    &BytesHandlerClass
c25_GetFreeNetObject            Function(Long _wParam, Long _lParam),Long,proc
c25_OpenConnection              Function(Long _wParam, Long _lParam),Long,proc
c25_SendData                    Function(Long _wParam, Long _lParam),Long,proc
c25_QueryStatus                 Function(Long _wParam, Long _lParam),Long,proc
c25NetObject                    &c25NetObjectClass
c25NetObjectsPtrArray           Long,Dim(256)
CheckArmCloseWindowCount        Long
CloseWindow                     Procedure(<Long _level>),Long,PROC
CloseWindowCount                Long
CloseWindowThis                 Procedure(Long _wparam),Long,PROC
CRLF                            String(2)
GlobalNanoSync                  &NanoSyncClass()
Id                              Long
Index                           Long
LastAppAlive                    DECIMAL(20,0)
LastWndProc                     Long
Logger                          &LoggerClass
NanoSync                        &NanoSyncClass
c25NetObject001                    &c25NetObjectClass
c25NetObject002                    &c25NetObjectClass
c25NetObject003                    &c25NetObjectClass
c25NetObject004                    &c25NetObjectClass
c25NetObject005                    &c25NetObjectClass
c25NetObject006                    &c25NetObjectClass
c25NetObject007                    &c25NetObjectClass
c25NetObject008                    &c25NetObjectClass
NetObjectsPtrArray              Long,Dim(256)
PacketReceived                  Procedure(Long _simpleObjectId),Long,PROC
Process                         Procedure(Long _simpleObjectId),Long,PROC
St1                             &StringTheory
St2                             &StringTheory
ThreadHandle                    Long
TimeoutThisAlive                Byte
TrueReflection                  &TrueReflectionClass()
UseLoopback                     BOOL
WinApi                          &WinApi32Class
WindowHandle                    Long
NSCWId                          Long

NetSimpleObjectSettings         Group,Pre(NetSimpleObjectSettings),Dim(256)
Settings                            &NetSimpleObject_TYPE()
                                End
!InterPacket                         Group(InterPacket_TYPE)
!                                    End
!InterPacketStrOver                  String(256),OVER(InterPacket)
                            End

