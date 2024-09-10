                        Member

                        Include('c25_DataControlStyleClass.inc'),Once
                        Map
                            Include('i64.inc')
                            Include('cwutil.inc')
                            Include('c25_WinApiPrototypes.inc')
                        End


c25_DataControlStyleClass.Construct                                     Procedure()

Code
   
    Self.BitConverterClass &= NEW c25_BitConverterClass()
    Self.GdiPlusClass &= NEW c25_GdiPlusClass()

!    Self.DataReflectionClass &= NEW c25_DataReflectionClass()
!    Self.ClarionFieldsQ &= NEW ClarionFields_TYPE()
!    !Self.TreeViewNodeMapping &= NEW TreeViewNodeMapping_TYPE()
!    Self.SourceDataColumns &= NEW c25_DataColumnsCollectionClass()


c25_DataControlStyleClass.Destruct                                      Procedure()

Code


   
c25_DataControlStyleClass.Init                                          Procedure(*c25_ControlClass _controlClass)

Code
        
    Self.BaseControlClass   &= _controlClass

    Case Self.BaseControlClass.TypeEnum
    Of ControlType:TreeView
        Self.AlternateEven_BackgroundColorARGB.A = 255
        Self.AlternateEven_BackgroundColorARGB.R = 255
        Self.AlternateEven_BackgroundColorARGB.G = 155
        Self.AlternateEven_BackgroundColorARGB.B = 155
        Self.GdiPlusClass.NewSolidBrush(Self.AlternateEven_BackgroundSolidBrush, Self.AlternateEven_BackgroundColor)
        
        Self.AlternateOdd_BackgroundColorARGB.A = 255
        Self.AlternateOdd_BackgroundColorARGB.R = 155
        Self.AlternateOdd_BackgroundColorARGB.G = 155
        Self.AlternateOdd_BackgroundColorARGB.B = 255
        Self.GdiPlusClass.NewSolidBrush(Self.AlternateOdd_BackgroundSolidBrush, Self.AlternateOdd_BackgroundColor)        
    End
    
    
    
    
!!    Self.BindingSourceClass &= _bindingSourceClass
!!    Self.ProgramHandlerClass &= Self.BindingSourceClass.ProgramHandlerClass
!!    Self.SourceDataColumns.Init(Self)
!    Return 0
!    
!sdfsdfsf.SetControlType     Procedure(long _controlType)
