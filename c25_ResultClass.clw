        Member

        Include('c25_ResultClass.inc'),Once

                    MAP
                        Include('CWUTIL.inc'),once
                        Include('i64.inc')
						Include('c25_WinApiPrototypes.inc')
                    End

c25_ResultClass.Destruct                                                    Procedure()

Code

    If not Self.ValueObject &= NULL
        Dispose(Self.ValueObject)
    End


c25_ResultClass.Construct                                                   Procedure()

Code

    Self.ValueObject &= NEW c25_ObjectClass()
    
    
c25_ResultClass.Reset                                                   Procedure()

Code

    If not Self.ValueObject &= NULL
        Dispose(Self.ValueObject)
    End
    Self.ValueObject &= NEW c25_ObjectClass()
    
    
    