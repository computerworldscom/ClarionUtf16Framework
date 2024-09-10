    Include('c25_ProgramHandlerClass.inc'),Once

c25_ControlTreeViewRenderClass                                                  Class(),type, Module('c25_ControlTreeViewRenderClass.clw'), Link('c25_ControlTreeViewRenderClass.clw',1),DLL(0)
Construct                                                                           Procedure()
Destruct                                                                            Procedure()
stLog                                                                               &StringTheory
stLogFileName                                                                       cstring(1024)

ProgramHandlerClass                                                                 &c25_ProgramHandlerClass

CurrentPageBufferGuidId                                                             string(36)

Init                                                                                Procedure(*c25_ControlTreeViewClass _controlTreeViewClass),proc,String

TabClass                                                                            &c25_TabClass
TabRenderEngineClass                                                                &c25_TabRenderEngineClass
BindingSourceClass                                                                  &c25_BindingSourceClass
DataSourceClass                                                                     &c25_DataSourceClass

BitConverterClass                                                                   &c25_BitConverterClass
ControlTreeViewClass                                                                &c25_ControlTreeViewClass ! base
DrawStringRectCalcF                                                                 &RectF_TYPE
DrawStringRectF                                                                     &RectF_TYPE
GdiPlusClass                                                                        &c25_GdiPlusClass
Graphics                                                                            Long,dim(16)
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

BufferBitmapInfo                                                            Group,Pre(BufferBitmapInfo)
Size                                                                            Long
Width                                                                           Long
Height                                                                          Long
Planes                                                                          Short
BitCount                                                                        Short
Compression                                                                     Long
SizeImage                                                                       Long
XpelsPerMeter                                                                   Long
YPelsPerMeter                                                                   Long
ClrUsed                                                                         Long
ClrImportant                                                                    Long
                                                                            End
                                                                                End

