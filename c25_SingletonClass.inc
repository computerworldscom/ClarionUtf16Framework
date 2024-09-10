Include('c25_ProgramHandlerClass.inc'),Once

c25_SingletonClass                Class(),type, Module('c25_SingletonClass.clw'), Link('c25_SingletonClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)

Construct                               Procedure()
Destruct                                Procedure()

Name                                    cstring(512),Private
ParentSelf                              Long,Private
OldPtr                                  Long,Private
NewPtr                                  Long,Private
IsRootSingleton                         BOOL

NanoSync                                &c25_NanoSyncClass(),Private
SubKeyPathDefault                       &String,Private

AttachSingleton                         Procedure(String _name),Long,Proc,Private
GetOldRefPtr                            Procedure(String _name),Long,Private
GetPointer                              Procedure(<c25_ProgramHandlerClass _oldProgramHandlerClass>),Long
Init                                    Procedure(String _className, Long _parentPtr)
InitFirstTime                           Procedure(String _name),Long,Proc,Private
SetOldRefPtr                            Procedure(String _name),Private
                                    End


