                        Member

                        Include('c25_ControlRendererClass.inc'),Once
                        Map
                            Include('i64.inc')
                            Include('cwutil.inc')
                            Include('c25_WinApiPrototypes.inc')
                        End


c25_ControlRendererClass.Construct                                  Procedure()

ClassTypeName   cstring(128)
ClassStarter   &c25_ClassStarter

Code

    ClassTypeName = 'c25_ControlRendererClass'

    ClassStarter &= NEW c25_ClassStarter()
    Self.ProgramHandlerClass &= (ClassStarter.Start(ClassTypeName))
    Dispose(ClassStarter)
    
    Self.ProgramHandlerClass.RootLog.WriteLog('c25_ControlRendererClass.Construct - START')
    
    
    !Self.StLog &= NEW StringTheory()
    !Self.GdiPlusClass &= NEW c25_GdiPlusClass()
    !Self.GdiPlusClass &= Self.ProgramHandlerClass.GdiPlusClass
    Self.GdiPlusClass &= NEW c25_GdiPlusClass()
    !Self.ProgramHandlerClass.RootLog.WriteLog('c25_ControlRendererClass.Construct - END')

c25_ControlRendererClass.Destruct                                  Procedure()

Code


c25_ControlRendererClass.Init       Procedure(*c25_ControlClass _controlClass)

Code

    
    
    
    
    Self.ControlClass &= _controlClass
    
    Self.ProgramHandlerClass.RootLog.WriteLog('c25_ControlRendererClass.Init - START')

    !Self.StLogFileName = 'm:\c25_ControlRendererClass' & Self.ControlClass.Name & '.txt'
    !Remove(!Self.StLogFileName)
    !Self.StLog.SetValue('INIT' & '<13><10>')
    !Self.StLog.SaveFile(!Self.StLogFileName)
    
    Self.ProgramHandlerClass.RootLog.WriteLog('c25_ControlRendererClass.Init - Self.CreateCanvas()')
    Self.CreateCanvas()
    
     Self.ProgramHandlerClass.RootLog.WriteLog('c25_ControlRendererClass.Init - END')
    
    Return 0
    
    
c25_ControlRendererClass.CreateCanvas       Procedure()

Code

    Self.CanvasWidth            = Self.ControlClass.ControlRect.Width
    Self.CanvasHeight           = Self.ControlClass.ControlRect.Height
    Self.CanvasGraphics         = 0
    Self.CanvasImagePtr         = 0
    Self.CanvasScan0            = 0
    Self.CanvasBitmapAllocSize  = 0
    Self.CanvasStride           = 0
    Self.CanvasPixelFormat      = 0
    Self.GdiPlusClass.CreateCanvas(Self.CanvasWidth, Self.CanvasHeight, Self.CanvasGraphics, Self.CanvasImagePtr, Self.CanvasScan0, Self.CanvasBitmapAllocSize, Self.CanvasStride, Self.CanvasPixelFormat, DisplayStateMode:Buffer)

    !Self.StLog.Append('Self.CanvasWidth : '             & Self.CanvasWidth              & '<13><10>')
    !Self.StLog.Append('Self.CanvasHeight : '            & Self.CanvasHeight             & '<13><10>')
    !Self.StLog.Append('Self.CanvasGraphics : '          & Self.CanvasGraphics           & '<13><10>')
    !Self.StLog.Append('Self.CanvasImagePtr : '          & Self.CanvasImagePtr           & '<13><10>')
    !Self.StLog.Append('Self.CanvasScan0 : '             & Self.CanvasScan0              & '<13><10>')
    !Self.StLog.Append('Self.CanvasBitmapAllocSize : '   & Self.CanvasBitmapAllocSize    & '<13><10>')
    !Self.StLog.Append('Self.CanvasStride : '            & Self.CanvasStride             & '<13><10>')
    !Self.StLog.Append('Self.CanvasPixelFormat : '       & Self.CanvasPixelFormat        & '<13><10>')

    !Self.StLog.SaveFile(!Self.StLogFileName, true)
    
    Return 0
        