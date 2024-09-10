
    Include('c25_ProgramHandlerClass.inc'),Once

c25_ThemeManagerClass                                                       Class(),type, Module('c25_ThemeManagerClass.clw'), Link('c25_ThemeManagerClass.clw',1),DLL(0)
Construct                                                                       Procedure()
Destruct                                                                        Procedure()

ProgramHandlerClass                                                             &c25_ProgramHandlerClass

GdiPlusClass                                                                    &c25_GdiPlusClass
BitConverterClass                                                               &c25_BitConverterClass


ThemeParts                                                                      &ThemeParts_TYPE
ThemePartsItemsCount                                                            Long

GetThemeParts                                                                   Procedure(long _controlType, string _name),string
GetLineColor                                                                    Procedure(long _controlType, string _name, <long _state>),Long
GetBackgroundColor                                                              Procedure(long _controlType, string _name, <long _state>),Long
GetIconFileName                                                                 Procedure(long _controlType, string _name, <long _state>),String
GetWidth                                                                        Procedure(long _controlType, string _name, <long _state>),long
GetHeight                                                                       Procedure(long _controlType, string _name, <long _state>),long
GetText                                                                         Procedure(long _controlType, string _name, <long _state>),String
HasText                                                                         Procedure(long _controlType, string _name, <long _state>),bool

                                                                            End


