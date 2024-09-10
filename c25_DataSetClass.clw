        Member

        Include('c25_DataSetClass.inc'),Once

                    MAP
                        Include('CWUTIL.inc'),once
                        Include('i64.inc')
						Include('c25_WinApiPrototypes.inc')
                        Module('c25DataManager.dll')
                            c25RegisterWM(long _messageName, long _messageNameLength),Long,C,Name('c25RegisterWM')
                        End
                    End

c25_DataSetClass.Destruct                        Procedure()

    Code


c25_DataSetClass.Construct                       Procedure()

ClassStarter &c25_ClassStarter
Code

    Self.ClassTypeName = 'c25_DataSetClass'

    ClassStarter &= NEW c25_ClassStarter()
    Self.ProgramHandlerClass &= (ClassStarter.Start(Self.ClassTypeName))
    Dispose(ClassStarter)
    