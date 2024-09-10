                        Member

                        Include('c25_ThemeManagerClass.inc'),Once
                        Map
                            Include('i64.inc')
                            Include('cwutil.inc')
                            Include('c25_WinApiPrototypes.inc')
                        End


c25_ThemeManagerClass.Construct                                  Procedure()

ClassTypeName cstring(128)
ClassStarter   &c25_ClassStarter

Code

    ClassTypeName = 'c25_ThemeManagerClass'

    ClassStarter &= NEW c25_ClassStarter()
    Self.ProgramHandlerClass &= (ClassStarter.Start(ClassTypeName))
    Dispose(ClassStarter)
    
    Self.ThemeParts                             &= NEW ThemeParts_TYPE()
    Self.GdiPlusClass                           &= NEW c25_GdiPlusClass()
    Self.BitConverterClass                      &= NEW c25_BitConverterClass()
    
    Clear(Self.ThemeParts)

!    Self.ThemeParts.Name                        &= Self.ProgramHandlerClass.BitConverterClass.BinaryCopy('TabRibbonButtonBack')
!    
!    Self.ThemeParts.IconFileName_Normal         &= Self.ProgramHandlerClass.BitConverterClass.AnsiToUtf16('BackButton_Normal.png',,true)
!    Self.ThemeParts.IconFileName_Hot            &= Self.ProgramHandlerClass.BitConverterClass.AnsiToUtf16('BackButton_Hot.png',,true)
!    Self.ThemeParts.IconFileName_HotDimmed      &= Self.ProgramHandlerClass.BitConverterClass.AnsiToUtf16('BackButton_HotDimmed.png',,true)
    
    
    Self.ThemeParts.Name                        &= Self.ProgramHandlerClass.BitConverterClass.BinaryCopy('TabRibbonButton')
    
    Self.ThemeParts.IconFileName_Normal         &= null
    Self.ThemeParts.IconFileName_Hot            &= null
    Self.ThemeParts.IconFileName_HotDimmed      &= null
    
    Self.ThemeParts.ControlType                 = ControlType:Button
    Self.ThemeParts.LineColor_A                 = 255
    Self.ThemeParts.LineColor_R                 = 0
    Self.ThemeParts.LineColor_G                 = 155
    Self.ThemeParts.LineColor_B                 = 255
    Self.ThemeParts.LineColor                   = (Self.ThemeParts.LineColor_A*256*256*256) + (Self.ThemeParts.LineColor_R*256*256) + (Self.ThemeParts.LineColor_G*256) + Self.ThemeParts.LineColor_B
    Self.ThemeParts.LineThickness               = 1

    Self.ThemeParts.BackgroundColor_Normal_A    = 0
    Self.ThemeParts.BackgroundColor_Normal_R    = 0
    Self.ThemeParts.BackgroundColor_Normal_G    = 0
    Self.ThemeParts.BackgroundColor_Normal_B    = 0
    Self.ThemeParts.BackgroundColor_Normal      = Self.GdiPlusClass.GetColorMacro(Self.ThemeParts.BackgroundColor_Normal_A, Self.ThemeParts.BackgroundColor_Normal_R, Self.ThemeParts.BackgroundColor_Normal_G, Self.ThemeParts.BackgroundColor_Normal_B)
    
    Self.ThemeParts.BackgroundColor_Hot_A       = 0
    Self.ThemeParts.BackgroundColor_Hot_R       = 0
    Self.ThemeParts.BackgroundColor_Hot_G       = 0
    Self.ThemeParts.BackgroundColor_Hot_B       = 0
    Self.ThemeParts.BackgroundColor_Hot         = Self.GdiPlusClass.GetColorMacro(Self.ThemeParts.BackgroundColor_Hot_A, Self.ThemeParts.BackgroundColor_Hot_R, Self.ThemeParts.BackgroundColor_Hot_G, Self.ThemeParts.BackgroundColor_Hot_B)
    
    Self.ThemeParts.Width                       = 32
    Self.ThemeParts.Height                      = 32
    
    Self.ThemeParts.Text                       &= NEW STRING(2)
    Self.ThemeParts.Text                        = Chr(0) & Chr(0)
    
    Self.ThemeParts.NoText                      = True
    
    Self.ThemeParts.LineThickness               = 1
    Add(Self.ThemeParts)
!    !-------------------------------------------------------------
    Clear(Self.ThemeParts)

    Self.ThemeParts.Name                        &= Self.ProgramHandlerClass.BitConverterClass.BinaryCopy('TabRibbonSeperatorV')
    Self.ThemeParts.ControlType                 = ControlType:Button ! todo seperator
    Self.ThemeParts.Width                       = 1
    Self.ThemeParts.Height                      = 32
    Self.ThemeParts.Text                       &= NEW STRING(2)
    Self.ThemeParts.Text                        = Chr(0) & Chr(0)
    Self.ThemeParts.NoText                      = True
    Self.ThemeParts.LineThickness               = 1
    Add(Self.ThemeParts)
!        
!    
    
    
    
    
    

    Self.ThemePartsItemsCount = Records(Self.ThemeParts)


c25_ThemeManagerClass.Destruct                                  Procedure()

Code


    
c25_ThemeManagerClass.GetThemeParts                             Procedure(long _controlType, string _name)

Code

    I# = 0
    Loop Self.ThemePartsItemsCount Times
        I# = I# + 1
        Get(Self.ThemeParts,I#)
        If Self.ThemeParts.ControlType <> _controlType
            Cycle
        End
        If Self.ThemeParts.Name <> _name
            Cycle
        End        
        Return Self.ThemeParts
    End
    Clear(Self.ThemeParts)
    Return Self.ThemeParts
    
c25_ThemeManagerClass.HasText                             Procedure(long _controlType, string _name, <long _state>)

Code

    I# = 0
    Loop Self.ThemePartsItemsCount Times
        I# = I# + 1
        Get(Self.ThemeParts,I#)
        If Self.ThemeParts.ControlType <> _controlType
            Cycle
        End
        If Self.ThemeParts.Name <> _name
            Cycle
        End        
        If Self.ThemeParts.NoText
            Return False
        ELSE
            Return True
        End
    End
    Return False
    
c25_ThemeManagerClass.GetLineColor                              Procedure(long _controlType, string _name, <long _state>)

Code

    I# = 0
    Loop Self.ThemePartsItemsCount Times
        I# = I# + 1
        Get(Self.ThemeParts,I#)
        If Self.ThemeParts.ControlType <> _controlType
            Cycle
        End
        If Self.ThemeParts.Name <> _name
            Cycle
        End        
        Return Self.ThemeParts.LineColor
    End
    Return 0
    
c25_ThemeManagerClass.GetWidth                              Procedure(long _controlType, string _name, <long _state>)

Code

    I# = 0
    Loop Self.ThemePartsItemsCount Times
        I# = I# + 1
        Get(Self.ThemeParts,I#)
        If Self.ThemeParts.ControlType <> _controlType
            Cycle
        End
        If Self.ThemeParts.Name <> _name
            Cycle
        End        
        Return Self.ThemeParts.Width
    End
    Return 0    
    
c25_ThemeManagerClass.GetHeight                              Procedure(long _controlType, string _name, <long _state>)

Code

    I# = 0
    Loop Self.ThemePartsItemsCount Times
        I# = I# + 1
        Get(Self.ThemeParts,I#)
        If Self.ThemeParts.ControlType <> _controlType
            Cycle
        End
        If Self.ThemeParts.Name <> _name
            Cycle
        End        
        Return Self.ThemeParts.Height
    End
    Return 0        

c25_ThemeManagerClass.GetBackgroundColor                        Procedure(long _controlType, string _name, <long _state>)

Code

    I# = 0
    Loop Self.ThemePartsItemsCount Times
        I# = I# + 1
        Get(Self.ThemeParts,I#)
        If Self.ThemeParts.ControlType <> _controlType
            Cycle
        End
        If Self.ThemeParts.Name <> _name
            Cycle
        End        
        If omitted(_state) = FALSE
            Case _state
            Of ButtonState:Normal
                Return Self.ThemeParts.BackgroundColor_Normal
            Of ButtonState:Hot
                Return Self.ThemeParts.BackgroundColor_Hot
            End
        End
    End
    Return 0
    
    
    
c25_ThemeManagerClass.GetIconFileName                        Procedure(long _controlType, string _name, <long _state>)

Code

    I# = 0
    Loop Self.ThemePartsItemsCount Times
        I# = I# + 1
        Get(Self.ThemeParts,I#)
        If Self.ThemeParts.ControlType <> _controlType
            Cycle
        End
        If Self.ThemeParts.Name <> _name
            Cycle
        End        
        If omitted(_state) = FALSE
            Case _state
            Of ButtonState:Normal
                Return Self.ThemeParts.IconFileName_Normal
            Of ButtonState:Hot
                Return Self.ThemeParts.IconFileName_Hot
            Of ButtonState:HotDimmed
                Return Self.ThemeParts.IconFileName_HotDimmed
            End
        End
        Message('error GetIconFileName')
    End
    Return Chr(0) & Chr(0)
    
    
c25_ThemeManagerClass.GetText                        Procedure(long _controlType, string _name, <long _state>)

Code

    I# = 0
    Loop Self.ThemePartsItemsCount Times
        I# = I# + 1
        Get(Self.ThemeParts,I#)
        If Self.ThemeParts.ControlType <> _controlType
            Cycle
        End
        If Self.ThemeParts.Name <> _name
            Cycle
        End        
        If omitted(_state) = FALSE
            Case _state
            Of ButtonState:Normal
                Return Self.ThemeParts.Text
            Of ButtonState:Hot
                Return Self.ThemeParts.Text
            End
        End
    End
    Return Self.ThemeParts.Text
    
    