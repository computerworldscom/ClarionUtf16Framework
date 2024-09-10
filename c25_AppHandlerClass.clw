    Member

    Include('c25_ProgramHandlerClass.inc'),Once

    Map
        Include('i64.inc'),Once
        Include('cwutil.inc'),Once
        !Include('c25_WinApiPrototypes.clw'),Once
    End

c25ProgramHandlerClass.Construct                             Procedure()

Code

    Message('c25ProgramHandlerClass.Construct')
    Self.SingletonClass &= NEW c25SingletonClass()
    Self.DllLoader &= NEW c25DllLoaderClass()
    !Message('hello from c25ProgramHandlerClass')
        
c25ProgramHandlerClass.Destruct                              Procedure()

Code


c25ProgramHandlerClass.CreateWindow                         Procedure()

WindowHandler &c25WindowHandlerClass

Code
        
    WindowHandler &= NEW c25WindowHandlerClass()
    WindowHandler.InitWindow()
    WindowHandler.OpenWindow()

!c25ProgramHandlerClass.SetGetSingleton                      Procedure()
!
!    Code
!
!        If Self.ProgramHandlerClassPtr = 0
!            Self.GlobalMemPtr = Self.GetGlobalMemPtrFromReg32()
!            If Self.GlobalMemPtr <> 0
!                Self.GlobalMem &= (Self.GlobalMemPtr)
!            End
!        End
!        Return Self.GlobalMemPtr
!    
    
    