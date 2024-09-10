    INCLUDE('c25_DATATYPES.CLW'),ONCE
    INCLUDE('C25_DUMMY.CLW'), ONCE
    INCLUDE('C25_DUMMY.CLW'),ONCE
!    INCLUDE('C25_DUMMY.CLW'),ONCE
!    INCLUDE('ERRORS.CLW'),ONCE
    INCLUDE('JFILES.INC'),ONCE
    Include('STRINGTHEORY.INC'),ONCE
    Include('c25_WinApiClass.inc'),Once
    Include('c25_WindowHandlerClass.inc'),Once
    Include('c25_DllLoaderClass.inc'),Once

c25AppHandlerClass                Class(),type, Module('c25_AppHandlerClass.clw'), Link('c25_AppHandlerClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)

Construct                               Procedure()
Destruct                                Procedure()
SingletonClass                          &c25SingletonClass()
DllLoader                               &c25DllLoaderClass()
MainWindowHandler                       &c25WindowHandler()
                                    End

