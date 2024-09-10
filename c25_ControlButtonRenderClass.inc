    Include('c25_ProgramHandlerClass.inc'),Once

c25_ControlButtonRenderClass                                                    Class(),type, Module('c25_ControlButtonRenderClass.clw'), Link('c25_ControlButtonRenderClass.clw',1),DLL(0)
Construct                                                                           Procedure()
Destruct                                                                            Procedure()
stLog                                                                               &StringTheory
stLogFileName                                                                       cstring(1024)

ProgramHandlerClass                                                                 &c25_ProgramHandlerClass
Init                                                                                Procedure(*c25_ControlButtonClass _controlButton),long,proc

BitConverterClass                                                                   &c25_BitConverterClass
ControlButtonClass                                                                  &c25_ControlButtonClass ! base
DrawStringRectCalcF                                                                 &RectF_TYPE
DrawStringRectF                                                                     &RectF_TYPE
GdiPlusClass                                                                        &c25_GdiPlusClass
Graphics                                                                            Long
IconFilenameW                                                                       String(512),dim(16)
IconHandle                                                                          Long,dim(16,16)
MeasureStringCodePointsFitted                                                       Long
Paint                                                                               Procedure(long _canvasState),long,PROC
SomeBrush                                                                           Long
SomeRectF                                                                           &RectF_TYPE
SomeRectI                                                                           &RectI_TYPE
TextFont                                                                            Long,dim(16)
TextFontBrush                                                                       Long,dim(16)
TextFontFamily                                                                      Long,dim(16)
TextFontFamilyNameW                                                                 String(1024),dim(16)
TextFontSize                                                                        Long,dim(16)
TextFontSizeF                                                                       SREAL,dim(16)
TextIcon                                                                            Long,dim(16)
TextIconFilenameW                                                                   String(1024),dim(16)
TextStringFormat                                                                    Long,dim(16)
TextStringFormatTest                                                                Long
TextTextTestW                                                                       &string
TextTextW                                                                           &string
TextTitleRectF                                                                      &RectF_TYPE
TextTitleWidth                                                                      Long
TextTitleWidthCalc                                                                  sreal
                                                                                End

