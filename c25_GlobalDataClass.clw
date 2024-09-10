                        Member

                        Include('c25_GlobalDataClass.inc'),Once
                        Map
                            Include('i64.inc')
                            Include('cwutil.inc')
                            Include('c25_WinApiPrototypes.inc')
                        End


c25_GlobalDataClass.Construct                                  Procedure()

ClassTypeName cstring(128)
ClassStarter   &c25_ClassStarter

Code

    ClassTypeName = 'c25_GlobalDataClass'

    ClassStarter &= NEW c25_ClassStarter()
    Self.ProgramHandlerClass &= (ClassStarter.Start(ClassTypeName))
    Dispose(ClassStarter)


    Self.SystemClassesFlat                                                       &= NEW SystemClassesFlat_TYPE()
    Self.SystemClasses                                                           &= NEW SystemClasses_TYPE()


c25_GlobalDataClass.Destruct                                  Procedure()

Code


