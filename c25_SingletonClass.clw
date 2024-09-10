    Member

    Include('c25_SingletonClass.inc'),Once

    Map
        Include('i64.inc'),Once
        Include('cwutil.inc'),Once
        Include('c25_WinApiPrototypes.inc'),Once
    End

c25_SingletonClass.Construct                             Procedure()

Code

    Self.NanoSync &= NEW c25_NanoSyncClass()
    L# = Len('Software\' & C25_RegistryCompanyName & '\' & C25_RegistryProductname & '\Instances')
    Self.SubKeyPathDefault &= NEW String(L#)
    Self.SubKeyPathDefault = 'Software\' & C25_RegistryCompanyName & '\' & C25_RegistryProductname & '\Instances'

c25_SingletonClass.Destruct                              Procedure()

Code

    Dispose(Self.SubKeyPathDefault)
    Dispose(Self.NanoSync)


c25_SingletonClass.Init                      Procedure(String _className, Long _parentPtr)

Code

    Self.Name = _className
    Self.ParentSelf = _parentPtr
    If Self.AttachSingleton(_className) = 0
        Self.InitFirstTime(_className)
    End


c25_SingletonClass.GetPointer Procedure(<c25_ProgramHandlerClass _oldProgramHandlerClass>)

OldProgramHandlerClass &c25_ProgramHandlerClass

Code

    If omitted(_oldProgramHandlerClass) = False
        If _oldProgramHandlerClass.IsRootProgramHandler = False
            OldProgramHandlerClass &= _oldProgramHandlerClass
            Dispose(OldProgramHandlerClass)
        Else
            If Self.IsRootSingleton = FALSE
                Message('severe error Self.IsRootSingleton = False, should be true')
            End
        End
    End
    Return Self.NewPtr


c25_SingletonClass.InitFirstTime                         Procedure(String _name)

SubKey          cstring(255)
phkResult       Long
ValueName       cstring(255)
DWordValue      Long
ValueValue      String(128)

    Code

    SubKey  = Self.SubKeyPathDefault & '\' & c25_GetProcessId(c25_GetCurrentProcess()) & '\Singletons\' & Clip(Left(_name))
    c25_RegCreateKeyExA(C25_HkeyLocalMachineEquate, Address(SubKey),0,0, C25_REG_OPTION_VOLATILE,  C25_KEY_ALL_ACCESS ,0, Address(phkResult), 0)
    If phkResult <> 0
        ValueName = 'ClassPointer'
        DWordValue = Self.ParentSelf
        R# = c25_RegSetValueExA(phkResult, Address(ValueName),0, C25_REG_DWORD, Address(DWordValue),4)

        ValueName = 'StartDateTimeUTC'
        ValueValue = Self.NanoSync.GetLDAPTime(False)
        ValueValue = Clip(ValueValue) & Chr(0) & Chr(0)
        R# = c25_RegSetValueExA(phkResult, Address(ValueName),0, C25_REG_SZ, Address(ValueValue),Len(Clip(ValueValue)))

        ValueName = 'LastSeenDateTimeUTC'
        ValueValue = Self.NanoSync.GetLDAPTime(False)
        ValueValue = Clip(ValueValue) & Chr(0) & Chr(0)
        R# = c25_RegSetValueExA(phkResult, Address(ValueName),0, C25_REG_SZ, Address(ValueValue),Len(Clip(ValueValue)))

        c25_RegCloseKey(phkResult)
    End
    Return 0


c25_SingletonClass.SetOldRefPtr                      Procedure(String _name)

SubKey          cstring(255)
phkResult       Long
ValueName       cstring(255)
DWordValue      Long
ValueValue      String(128)

    Code

    SubKey  = Self.SubKeyPathDefault & '\' & c25_GetProcessId(c25_GetCurrentProcess()) & '\Singletons\' & Clip(Left(_name))
    c25_RegCreateKeyExA(C25_HkeyLocalMachineEquate, Address(SubKey),0,0, C25_REG_OPTION_VOLATILE,  C25_KEY_ALL_ACCESS ,0, Address(phkResult), 0)
    If phkResult <> 0
        ValueName = 'OldClassPointer'
        DWordValue = Self.ParentSelf
        R# = c25_RegSetValueExA(phkResult, Address(ValueName),0, C25_REG_DWORD, Address(DWordValue),4)
        c25_RegCloseKey(phkResult)
    End


c25_SingletonClass.GetOldRefPtr                      Procedure(String _name)

SubKey                                          cstring(255)
phkResult                                       Long
ValueName                                       cstring(255)
ValReturnLen                                    Long
DWordValue                                      Long
OldPtr                                          Long

    Code

    SubKey  = Self.SubKeyPathDefault & '\' & c25_GetProcessId(c25_GetCurrentProcess()) & '\Singletons\' & Clip(Left(_name))
    R# = c25_RegOpenKeyExA(C25_HkeyLocalMachineEquate, Address(SubKey), 0, C25_KEY_ALL_ACCESS , Address(phkResult))
    If phkResult <> 0
        ValueName = 'OldClassPointer'
        ValReturnLen = 4
        R# = c25_RegQueryValueExA(phkResult, Address(ValueName), 0 , 0, Address(DWordValue), Address(ValReturnLen))
        c25_RegCloseKey(phkResult)
        If R# = 0
            Return DWordValue
        End
    End
    Return 0

c25_SingletonClass.AttachSingleton         Procedure(String _name)

SubKey                                          cstring(255)
phkResult                                       Long
ValueName                                       cstring(255)
ValReturnLen                                    Long
DWordValue                                      Long
OldPtr                                          Long

    Code

    SubKey  = Self.SubKeyPathDefault & '\' & c25_GetProcessId(c25_GetCurrentProcess()) & '\Singletons\' & Clip(Left(_name))
    R# = c25_RegOpenKeyExA(C25_HkeyLocalMachineEquate, Address(SubKey), 0, C25_KEY_ALL_ACCESS , Address(phkResult))
    If phkResult <> 0
        ValueName = 'ClassPointer'
        ValReturnLen = 4
        R# = c25_RegQueryValueExA(phkResult, Address(ValueName), 0 , 0, Address(DWordValue), Address(ValReturnLen))
        c25_RegCloseKey(phkResult)
        If R# = 0
            Self.SetOldRefPtr(_name)
            Self.NewPtr = DWordValue
            Return DWordValue
        ELSE
            Message('severe error c25ProgramHandlerClass.AttachSingleton ' & R#)
        End
    End
    Return 0

