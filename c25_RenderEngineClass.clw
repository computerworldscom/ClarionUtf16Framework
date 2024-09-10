        Member

        Map
            Include('i64.inc'),Once
            Include('cwutil.inc'),Once
            Include('c25_WinApiPrototypes.inc'),Once
        End

        Include('c25_RenderEngineClass.inc'), once

c25_RenderEngineClass.Process_MouseEvent Procedure()

TabClass    &c25_TabClass

CODE
        

    T# = 0
    LOOP !Self.TabsCount Times
        T# = T# + 1
        Get(Self.ProgramHandlerClass.TabObject,T#)
        If Errorcode() <> 0
            BREAK
        End
        If Self.ProgramHandlerClass.TabObject.ClassPtr = 0
            CYCLE
        End
        TabClass &= (Self.ProgramHandlerClass.TabObject.ClassPtr)
        TabClass.ProcessMouseEvent()
        TabClass &= null
    End 
    
    Return 0


c25_RenderEngineClass.Process_WM_INPUT                          Procedure(ULong WParam,Long LParam)

    Code

        If LPARAM = 0
            Return 0
        End

        Clear(Self.RawMouse)
        Clear(Self.WMInputQ)

        Self.RawDataSize = 0
        Clear(Self.RawDataBuffer,-1)
        Self.GetRawInputDataReturn = c25_GetRawInputData(LPARAM, C25_RID_INPUT,0                             ,Address(Self.RawDataSize), Size(Self.RawInputHeader))
        If Self.GetRawInputDataReturn = -1 Or Self.RawDataSize < 1
            Return 0
        End
        Self.GetRawInputDataReturn = c25_GetRawInputData(LPARAM, C25_RID_INPUT,Address(Self.RawDataBuffer)   ,Address(Self.RawDataSize), Size(Self.RawInputHeader))

        Case Self.RawInputHeader.Type
        Of C25_RIM_TYPEMOUSE
            Clear(Self.RawMouse)

            Self.RawMouse.MouseX = Self.MousePoint.X
            Self.RawMouse.MouseY = Self.MousePoint.Y

            Self.ProgramHandlerClass.UpdateWindowRect()
            
            Self.MouseAppOriginePoint.X = Self.ProgramHandlerClass.WindowRect.Left
            Self.MouseAppOriginePoint.Y = Self.ProgramHandlerClass.WindowRect.Top

            Self.ProgramHandlerClass.MouseAppOriginePointX = Self.MouseAppOriginePoint.X
            Self.ProgramHandlerClass.MouseAppOriginePointY = Self.MouseAppOriginePoint.Y

            c25_GetCursorPos(Address(Self.MousePoint))

            Self.RawMouse.AppMouseX = Self.RawMouse.MouseX - Self.MouseAppOriginePoint.X - 7
            Self.RawMouse.AppMouseY = Self.RawMouse.MouseY - Self.MouseAppOriginePoint.Y + -5

            If Self.RawMouse.AppMouseX > 0 And Self.RawMouse.AppMouseX < Self.ProgramHandlerClass.WindowRect.Width
                If Self.RawMouse.AppMouseY > 0 And Self.RawMouse.AppMouseY < Self.ProgramHandlerClass.WindowRect.Height
                    Self.RawMouse.InApp = True
                End
            End
            
!typedef struct tagRAWMOUSE {
!  USHORT usFlags;
!  union {
!    ULONG ulButtons;
!    struct {
!      USHORT usButtonFlags;
!      USHORT usButtonData;
!    } DUMMYSTRUCTNAME;
!  } DUMMYUNIONNAME;
!  ULONG  ulRawButtons;
!  LONG   lLastX;
!  LONG   lLastY;
!  ULONG  ulExtraInformation;
!} RAWMOUSE, *PRAWMOUSE, *LPRAWMOUSE;            

            c25_MemCpy(Address(Self.RawMouse), Self.RawDataBufferAddress + 16, 22)
            
            Self.RawMouse.FullBits176 = Self.BitConverterClass.GetBits(Self.RawMouse,22)
            
!            If Self.RawMouse.RM_ButtonData <> 0
!                Message('ja Self.RawMouse.RM_ButtonData ' & Self.RawMouse.RM_ButtonData)
!            End

            If BAND(Self.RawMouse.RM_Flags, C25_MOUSE_MOVE_RELATIVE) <> 0
                Self.RawMouse.FlagMoveRelative          = True
            End
            If BAND(Self.RawMouse.RM_Flags, C25_MOUSE_MOVE_ABSOLUTE) <> 0
                Self.RawMouse.FlagMoveAbsolute          = True
            End
            If BAND(Self.RawMouse.RM_Flags, C25_MOUSE_VIRTUAL_DESKTOP) <> 0
                Self.RawMouse.FlagVirtualDesktop        = True
            End
            If BAND(Self.RawMouse.RM_Flags, C25_MOUSE_ATTRIBUTES_CHANGED) <> 0
                Self.RawMouse.FlagAttributesChanged     = True
            End
            If BAND(Self.RawMouse.RM_Flags, C25_MOUSE_MOVE_NOCOALESCE) <> 0
                Self.RawMouse.FlagMoveNoCoalesce        = True
            End

            Self.RawMouse.RM_ButtonFlagsBits = Self.BitConverterClass.GetBits16FromShort(Self.RawMouse.RM_ButtonFlags)

            If BAND(Self.RawMouse.RM_ButtonFlags, c25_Ri_Mouse_Left_Button_Down) <> 0
                Self.RawMouse.Button1LeftDown           = True
            End
            If BAND(Self.RawMouse.RM_ButtonFlags, c25_Ri_Mouse_Left_Button_Up) <> 0
                Self.RawMouse.Button1LeftUp             = True
            End
            If BAND(Self.RawMouse.RM_ButtonFlags, c25_Ri_Mouse_Right_Button_Down) <> 0
                Self.RawMouse.Button2RightDown          = True
            End
            If BAND(Self.RawMouse.RM_ButtonFlags, c25_Ri_Mouse_Right_Button_Up) <> 0
                Self.RawMouse.Button2RightUp            = True
            End
            If BAND(Self.RawMouse.RM_ButtonFlags, c25_Ri_Mouse_Middle_Button_Down) <> 0
                Self.RawMouse.Button3MiddleDown         = True
            End
            If BAND(Self.RawMouse.RM_ButtonFlags, c25_Ri_Mouse_Middle_Button_Up) <> 0
                Self.RawMouse.Button3MiddleUp           = True
            End
            If BAND(Self.RawMouse.RM_ButtonFlags, C25_RI_MOUSE_BUTTON_4_DOWN) <> 0
                Self.RawMouse.ButtonX1Down              = True
            End
            If BAND(Self.RawMouse.RM_ButtonFlags, C25_RI_MOUSE_BUTTON_4_UP) <> 0
                Self.RawMouse.ButtonX1Up                = True
            End
            If BAND(Self.RawMouse.RM_ButtonFlags, C25_RI_MOUSE_BUTTON_5_DOWN) <> 0
                Self.RawMouse.ButtonX2Down              = True
            End
            If BAND(Self.RawMouse.RM_ButtonFlags, C25_RI_MOUSE_BUTTON_5_UP) <> 0
                Self.RawMouse.ButtonX2Up                = True
            End
            
            If BAND(Self.RawMouse.RM_ButtonFlags, C25_RI_MOUSE_WHEEL) <> 0
                Self.RawMouse.IsWheelInput              = True
                Self.RawMouse.MouseDelta = Self.RawMouse.RM_ButtonData
            End
            If BAND(Self.RawMouse.RM_ButtonFlags, C25_RI_MOUSE_HWHEEL) <> 0
                Self.RawMouse.IsHWheelInput             = True
                Self.RawMouse.MouseDelta = Self.RawMouse.RM_ButtonData
            End
!            If Self.RawMouse.RM_ButtonData <> 0
!                Self.RawMouse.MouseDelta = Self.RawMouse.RM_ButtonData
!            END
            
            Self.RawMouse.SysTime = Self.NanoSync.GetSysTime()
            
        Of C25_RIM_TYPEKEYBOARD

            Self.RawDataBufferAddressOffset = Size(Self.RawInputHeader)
            Peek(Self.RawDataBufferAddress + Self.RawDataBufferAddressOffset, Self.WMInputQ.KBMakeCode)
            Self.RawDataBufferAddressOffset = Self.RawDataBufferAddressOffset + 2
            Peek(Self.RawDataBufferAddress + Self.RawDataBufferAddressOffset, Self.WMInputQ.KBFlags)

            Case Self.WMInputQ.KBFlags
            Of C25_RI_KEY_MAKE
                Self.WMInputQ.KBFlagsString = 'RI_KEY_MAKE'
            Of C25_RI_KEY_BREAK
                Self.WMInputQ.KBFlagsString = 'RI_KEY_BREAK'
            Of C25_RI_KEY_E0
                Self.WMInputQ.KBFlagsString = 'RI_KEY_E0'
            Of C25_RI_KEY_E1
                Self.WMInputQ.KBFlagsString = 'RI_KEY_E1'
            Of C25_RI_KEY_TERMSRV_SET_LED
                Self.WMInputQ.KBFlagsString = 'RI_KEY_TERMSRV_SET_LED'
            Of C25_RI_KEY_TERMSRV_SHADOW
                Self.WMInputQ.KBFlagsString = 'RI_KEY_TERMSRV_SHADOW'
            End
            Self.RawDataBufferAddressOffset = Self.RawDataBufferAddressOffset + 2
            Self.RawDataBufferAddressOffset = Self.RawDataBufferAddressOffset + 2

            Peek(Self.RawDataBufferAddress + Self.RawDataBufferAddressOffset, Self.WMInputQ.KBVKey)
            Case Self.WMInputQ.KBVKey
            Of C25_VK_LBUTTON
                Self.WMInputQ.KBVKeyString = 'LBUTTON'
            Of C25_VK_RBUTTON
                Self.WMInputQ.KBVKeyString = 'RBUTTON'
            Of C25_VK_CANCEL
                Self.WMInputQ.KBVKeyString = 'CANCEL'
            Of C25_VK_MBUTTON
                Self.WMInputQ.KBVKeyString = 'MBUTTON'
            Of C25_VK_XBUTTON1
                Self.WMInputQ.KBVKeyString = 'XBUTTON1'
            Of C25_VK_XBUTTON2
                Self.WMInputQ.KBVKeyString = 'XBUTTON2'
            Of C25_VK_BACK
                Self.WMInputQ.KBVKeyString = 'BACK'
            Of C25_VK_TAB
                Self.WMInputQ.KBVKeyString = 'TAB'
            Of C25_VK_CLEAR
                Self.WMInputQ.KBVKeyString = 'CLEAR'
            Of C25_VK_RETURN
                Self.WMInputQ.KBVKeyString = 'Return'
            Of C25_VK_SHIFT
                Self.WMInputQ.KBVKeyString = 'SHIFT'
            Of C25_VK_CONTROL
                Self.WMInputQ.KBVKeyString = 'CONTROL'
            Of C25_VK_MENU
                Self.WMInputQ.KBVKeyString = 'MENU'
            Of C25_VK_PAUSE
                Self.WMInputQ.KBVKeyString = 'PAUSE'
            Of C25_VK_CAPITAL
                Self.WMInputQ.KBVKeyString = 'CAPITAL'
            Of C25_VK_KANA
                Self.WMInputQ.KBVKeyString = 'KANA'
            Of C25_VK_HANGUEL
                Self.WMInputQ.KBVKeyString = 'HANGUEL'
            Of C25_VK_HANGUL
                Self.WMInputQ.KBVKeyString = 'HANGUL'
            Of C25_VK_JUNJA
                Self.WMInputQ.KBVKeyString = 'JUNJA'
            Of C25_VK_FINAL
                Self.WMInputQ.KBVKeyString = 'FINAL'
            Of C25_VK_HANJA
                Self.WMInputQ.KBVKeyString = 'HANJA'
            Of C25_VK_KANJI
                Self.WMInputQ.KBVKeyString = 'KANJI'
            Of C25_VK_ESCAPE
                Self.WMInputQ.KBVKeyString = 'ESCAPE'
            Of C25_VK_CONVERT
                Self.WMInputQ.KBVKeyString = 'CONVERT'
            Of C25_VK_NONCONVERT
                Self.WMInputQ.KBVKeyString = 'NONCONVERT'
            Of C25_VK_ACCEPT
                Self.WMInputQ.KBVKeyString = 'ACCEPT'
            Of C25_VK_MODECHANGE
                Self.WMInputQ.KBVKeyString = 'MODECHANGE'
            Of C25_VK_SPACE
                Self.WMInputQ.KBVKeyString = 'SPACE'
            Of C25_VK_PRIOR
                Self.WMInputQ.KBVKeyString = 'PRIOR'
            Of C25_VK_NEXT
                Self.WMInputQ.KBVKeyString = 'NEXT'
            Of C25_VK_END
                Self.WMInputQ.KBVKeyString = 'End'
            Of C25_VK_HOME
                Self.WMInputQ.KBVKeyString = 'HOME'
            Of C25_VK_LEFT
                Self.WMInputQ.KBVKeyString = 'LEFT'
            Of C25_VK_UP
                Self.WMInputQ.KBVKeyString = 'UP'
            Of C25_VK_RIGHT
                Self.WMInputQ.KBVKeyString = 'RIGHT'
            Of C25_VK_DOWN
                Self.WMInputQ.KBVKeyString = 'DOWN'
            Of C25_VK_SELECT
                Self.WMInputQ.KBVKeyString = 'SELECT'
            Of C25_VK_PRINT
                Self.WMInputQ.KBVKeyString = 'PRINT'
            Of C25_VK_EXECUTE
                Self.WMInputQ.KBVKeyString = 'EXECUTE'
            Of C25_VK_SNAPSHOT
                Self.WMInputQ.KBVKeyString = 'SNAPSHOT'
            Of C25_VK_INSERT
                Self.WMInputQ.KBVKeyString = 'INSERT'
            Of C25_VK_DELETE
                Self.WMInputQ.KBVKeyString = 'DELETE'
            Of C25_VK_HELP
                Self.WMInputQ.KBVKeyString = 'HELP'
            Of C25_VK_0
                Self.WMInputQ.KBVKeyString = '0'
            Of C25_VK_1
                Self.WMInputQ.KBVKeyString = '1'
            Of C25_VK_2
                Self.WMInputQ.KBVKeyString = '2'
            Of C25_VK_3
                Self.WMInputQ.KBVKeyString = '3'
            Of C25_VK_4
                Self.WMInputQ.KBVKeyString = '4'
            Of C25_VK_5
                Self.WMInputQ.KBVKeyString = '5'
            Of C25_VK_6
                Self.WMInputQ.KBVKeyString = '6'
            Of C25_VK_7
                Self.WMInputQ.KBVKeyString = '7'
            Of C25_VK_8
                Self.WMInputQ.KBVKeyString = '8'
            Of C25_VK_9
                Self.WMInputQ.KBVKeyString = '9'
            Of C25_VK_A
                Self.WMInputQ.KBVKeyString = 'a'
            Of C25_VK_B
                Self.WMInputQ.KBVKeyString = 'b'
            Of C25_VK_C
                Self.WMInputQ.KBVKeyString = 'c'
            Of C25_VK_D
                Self.WMInputQ.KBVKeyString = 'd'
            Of C25_VK_E
                Self.WMInputQ.KBVKeyString = 'e'
            Of C25_VK_F
                Self.WMInputQ.KBVKeyString = 'f'
            Of C25_VK_G
                Self.WMInputQ.KBVKeyString = 'g'
            Of C25_VK_H
                Self.WMInputQ.KBVKeyString = 'h'
            Of C25_VK_I
                Self.WMInputQ.KBVKeyString = 'i'
            Of C25_VK_J
                Self.WMInputQ.KBVKeyString = 'j'
            Of C25_VK_K
                Self.WMInputQ.KBVKeyString = 'k'
            Of C25_VK_L
                Self.WMInputQ.KBVKeyString = 'l'
            Of C25_VK_M
                Self.WMInputQ.KBVKeyString = 'm'
            Of C25_VK_N
                Self.WMInputQ.KBVKeyString = 'n'
            Of C25_VK_O
                Self.WMInputQ.KBVKeyString = 'o'
            Of C25_VK_P
                Self.WMInputQ.KBVKeyString = 'p'
            Of C25_VK_Q
                Self.WMInputQ.KBVKeyString = 'q'
            Of C25_VK_R
                Self.WMInputQ.KBVKeyString = 'r'
            Of C25_VK_S
                Self.WMInputQ.KBVKeyString = 's'
            Of C25_VK_T
                Self.WMInputQ.KBVKeyString = 't'
            Of C25_VK_U
                Self.WMInputQ.KBVKeyString = 'u'
            Of C25_VK_V
                Self.WMInputQ.KBVKeyString = 'v'
            Of C25_VK_W
                Self.WMInputQ.KBVKeyString = 'w'
            Of C25_VK_X
                Self.WMInputQ.KBVKeyString = 'x'
            Of C25_VK_Y
                Self.WMInputQ.KBVKeyString = 'y'
            Of C25_VK_Z
                Self.WMInputQ.KBVKeyString = 'z'
            Of C25_VK_LWIN
                Self.WMInputQ.KBVKeyString = 'LWIN'
            Of C25_VK_RWIN
                Self.WMInputQ.KBVKeyString = 'RWIN'
            Of C25_VK_APPS
                Self.WMInputQ.KBVKeyString = 'APPS'
            Of C25_VK_SLEEP
                Self.WMInputQ.KBVKeyString = 'SLEEP'
            Of C25_VK_NUMPAD0
                Self.WMInputQ.KBVKeyString = 'NUMPAD0'
            Of C25_VK_NUMPAD1
                Self.WMInputQ.KBVKeyString = 'NUMPAD1'
            Of C25_VK_NUMPAD2
                Self.WMInputQ.KBVKeyString = 'NUMPAD2'
            Of C25_VK_NUMPAD3
                Self.WMInputQ.KBVKeyString = 'NUMPAD3'
            Of C25_VK_NUMPAD4
                Self.WMInputQ.KBVKeyString = 'NUMPAD4'
            Of C25_VK_NUMPAD5
                Self.WMInputQ.KBVKeyString = 'NUMPAD5'
            Of C25_VK_NUMPAD6
                Self.WMInputQ.KBVKeyString = 'NUMPAD6'
            Of C25_VK_NUMPAD7
                Self.WMInputQ.KBVKeyString = 'NUMPAD7'
            Of C25_VK_NUMPAD8
                Self.WMInputQ.KBVKeyString = 'NUMPAD8'
            Of C25_VK_NUMPAD9
                Self.WMInputQ.KBVKeyString = 'NUMPAD9'
            Of C25_VK_MULTIPLY
                Self.WMInputQ.KBVKeyString = 'MULTIPLY'
            Of C25_VK_ADD
                Self.WMInputQ.KBVKeyString = 'ADD'
            Of C25_VK_SEPARATOR
                Self.WMInputQ.KBVKeyString = 'SEPARATOR'
            Of C25_VK_SUBTRACT
                Self.WMInputQ.KBVKeyString = 'SUBTRACT'
            Of C25_VK_DECIMAL
                Self.WMInputQ.KBVKeyString = 'DECIMAL'
            Of C25_VK_DIVIDE
                Self.WMInputQ.KBVKeyString = 'DIVIDE'
            Of C25_VK_F1
                Self.WMInputQ.KBVKeyString = 'F1'
            Of C25_VK_F2
                Self.WMInputQ.KBVKeyString = 'F2'
            Of C25_VK_F3
                Self.WMInputQ.KBVKeyString = 'F3'
            Of C25_VK_F4
                Self.WMInputQ.KBVKeyString = 'F4'
            Of C25_VK_F5
                Self.WMInputQ.KBVKeyString = 'F5'
            Of C25_VK_F6
                Self.WMInputQ.KBVKeyString = 'F6'
            Of C25_VK_F7
                Self.WMInputQ.KBVKeyString = 'F7'
            Of C25_VK_F8
                Self.WMInputQ.KBVKeyString = 'F8'
            Of C25_VK_F9
                Self.WMInputQ.KBVKeyString = 'F9'
            Of C25_VK_F10
                Self.WMInputQ.KBVKeyString = 'F10'
            Of C25_VK_F11
                Self.WMInputQ.KBVKeyString = 'F11'
            Of C25_VK_F12
                Self.WMInputQ.KBVKeyString = 'F12'
            Of C25_VK_F13
                Self.WMInputQ.KBVKeyString = 'F13'
            Of C25_VK_F14
                Self.WMInputQ.KBVKeyString = 'F14'
            Of C25_VK_F15
                Self.WMInputQ.KBVKeyString = 'F15'
            Of C25_VK_F16
                Self.WMInputQ.KBVKeyString = 'F16'
            Of C25_VK_F17
                Self.WMInputQ.KBVKeyString = 'F17'
            Of C25_VK_F18
                Self.WMInputQ.KBVKeyString = 'F18'
            Of C25_VK_F19
                Self.WMInputQ.KBVKeyString = 'F19'
            Of C25_VK_F20
                Self.WMInputQ.KBVKeyString = 'F20'
            Of C25_VK_F21
                Self.WMInputQ.KBVKeyString = 'F21'
            Of C25_VK_F22
                Self.WMInputQ.KBVKeyString = 'F22'
            Of C25_VK_F23
                Self.WMInputQ.KBVKeyString = 'F23'
            Of C25_VK_F24
                Self.WMInputQ.KBVKeyString = 'F24'
            Of C25_VK_NUMLOCK
                Self.WMInputQ.KBVKeyString = 'NUMLOCK'
            Of C25_VK_SCROLL
                Self.WMInputQ.KBVKeyString = 'SCROLL'
            Of C25_VK_LSHIFT
                Self.WMInputQ.KBVKeyString = 'LSHIFT'
            Of C25_VK_RSHIFT
                Self.WMInputQ.KBVKeyString = 'RSHIFT'
            Of C25_VK_LCONTROL
                Self.WMInputQ.KBVKeyString = 'LCONTROL'
            Of C25_VK_RCONTROL
                Self.WMInputQ.KBVKeyString = 'RCONTROL'
            Of C25_VK_LMENU
                Self.WMInputQ.KBVKeyString = 'LMENU'
            Of C25_VK_RMENU
                Self.WMInputQ.KBVKeyString = 'RMENU'
            Of C25_VK_BROWSER_BACK
                Self.WMInputQ.KBVKeyString = 'BROWSER_BACK'
            Of C25_VK_BROWSER_FORWARD
                Self.WMInputQ.KBVKeyString = 'BROWSER_FORWARD'
            Of C25_VK_BROWSER_REFRESH
                Self.WMInputQ.KBVKeyString = 'BROWSER_REFRESH'
            Of C25_VK_BROWSER_STOP
                Self.WMInputQ.KBVKeyString = 'BROWSER_STOP'
            Of C25_VK_BROWSER_SEARCH
                Self.WMInputQ.KBVKeyString = 'BROWSER_SEARCH'
            Of C25_VK_BROWSER_FAVORITES
                Self.WMInputQ.KBVKeyString = 'BROWSER_FAVORITES'
            Of C25_VK_BROWSER_HOME
                Self.WMInputQ.KBVKeyString = 'BROWSER_HOME'
            Of C25_VK_VOLUME_MUTE
                Self.WMInputQ.KBVKeyString = 'VOLUME_MUTE'
            Of C25_VK_VOLUME_DOWN
                Self.WMInputQ.KBVKeyString = 'VOLUME_DOWN'
            Of C25_VK_VOLUME_UP
                Self.WMInputQ.KBVKeyString = 'VOLUME_UP'
            Of C25_VK_MEDIA_NEXT_TRACK
                Self.WMInputQ.KBVKeyString = 'MEDIA_NEXT_TRACK'
            Of C25_VK_MEDIA_PREV_TRACK
                Self.WMInputQ.KBVKeyString = 'MEDIA_PREV_TRACK'
            Of C25_VK_MEDIA_STOP
                Self.WMInputQ.KBVKeyString = 'MEDIA_STOP'
            Of C25_VK_MEDIA_PLAY_PAUSE
                Self.WMInputQ.KBVKeyString = 'MEDIA_PLAY_PAUSE'
            Of C25_VK_LAUNCH_MAIL
                Self.WMInputQ.KBVKeyString = 'LAUNCH_MAIL'
            Of C25_VK_LAUNCH_MEDIA_SELECT
                Self.WMInputQ.KBVKeyString = 'LAUNCH_MEDIA_SELECT'
            Of C25_VK_LAUNCH_APP1
                Self.WMInputQ.KBVKeyString = 'LAUNCH_APP1'
            Of C25_VK_LAUNCH_APP2
                Self.WMInputQ.KBVKeyString = 'LAUNCH_APP2'
            Of C25_VK_OEM_1
                Self.WMInputQ.KBVKeyString = 'OEM_1'
            Of C25_VK_OEM_PLUS
                Self.WMInputQ.KBVKeyString = 'OEM_PLUS'
            Of C25_VK_OEM_COMMA
                Self.WMInputQ.KBVKeyString = 'OEM_COMMA'
            Of C25_VK_OEM_MINUS
                Self.WMInputQ.KBVKeyString = 'OEM_MINUS'
            Of C25_VK_OEM_PERIOD
                Self.WMInputQ.KBVKeyString = 'OEM_PERIOD'
            Of C25_VK_OEM_2
                Self.WMInputQ.KBVKeyString = 'OEM_2'
            Of C25_VK_OEM_3
                Self.WMInputQ.KBVKeyString = 'OEM_3'
            Of C25_VK_OEM_4
                Self.WMInputQ.KBVKeyString = 'OEM_4'
            Of C25_VK_OEM_5
                Self.WMInputQ.KBVKeyString = 'OEM_5'
            Of C25_VK_OEM_6
                Self.WMInputQ.KBVKeyString = 'OEM_6'
            Of C25_VK_OEM_7
                Self.WMInputQ.KBVKeyString = 'OEM_7'
            Of C25_VK_OEM_8
                Self.WMInputQ.KBVKeyString = 'OEM_8'
            Of C25_VK_OEM_102
                Self.WMInputQ.KBVKeyString = 'OEM_102'
            Of C25_VK_PROCESSKEY
                Self.WMInputQ.KBVKeyString = 'PROCESSKEY'
            Of C25_VK_PACKET
                Self.WMInputQ.KBVKeyString = 'PACKET'
            Of C25_VK_ATTN
                Self.WMInputQ.KBVKeyString = 'ATTN'
            Of C25_VK_CRSEL
                Self.WMInputQ.KBVKeyString = 'CRSEL'
            Of C25_VK_EXSEL
                Self.WMInputQ.KBVKeyString = 'EXSEL'
            Of C25_VK_EREOF
                Self.WMInputQ.KBVKeyString = 'EREOF'
            Of C25_VK_PLAY
                Self.WMInputQ.KBVKeyString = 'PLAY'
            Of C25_VK_ZOOM
                Self.WMInputQ.KBVKeyString = 'ZOOM'
            Of C25_VK_NONAME
                Self.WMInputQ.KBVKeyString = 'NONAME'
            Of C25_VK_PA1
                Self.WMInputQ.KBVKeyString = 'PA1'
            Of C25_VK_OEM_CLEAR
                Self.WMInputQ.KBVKeyString = 'OEM_CLEAR'
            ELSE
                Self.WMInputQ.KBVKeyString = 'UNKNOWN'
            End
            Self.RawDataBufferAddressOffset = Self.RawDataBufferAddressOffset + 2

            Peek(Self.RawDataBufferAddress + Self.RawDataBufferAddressOffset, Self.WMInputQ.KBMessage)
            Case Self.WMInputQ.KBMessage
            Of 06h
                Self.WMInputQ.KBMessageString = 'WM_ACTIVATE'
            Of 0319h
                Self.WMInputQ.KBMessageString = 'WM_APPCOMMAND'
            Of 0102h
                Self.WMInputQ.KBMessageString = 'WM_CHAR'
            Of 0103h
                Self.WMInputQ.KBMessageString = 'WM_DEADCHAR'
            Of 0312h
                Self.WMInputQ.KBMessageString = 'WM_HOTKEY'
            Of 0100h
                Self.WMInputQ.KBMessageString = 'WM_KEYDOWN'
            Of 0101h
                Self.WMInputQ.KBMessageString = 'WM_KEYUP'
            Of 08h
                Self.WMInputQ.KBMessageString = 'WM_KILLFOCUS'
            Of 07h
                Self.WMInputQ.KBMessageString = 'WM_SETFOCUS'
            Of 0107h
                Self.WMInputQ.KBMessageString = 'WM_SYSDEADCHAR'
            Of 0104h
                Self.WMInputQ.KBMessageString = 'WM_SYSKEYDOWN'
            Of 0105h
                Self.WMInputQ.KBMessageString = 'WM_SYSKEYUP'
            Of 0109h
                Self.WMInputQ.KBMessageString = 'WM_UNICHAR'
            End
            Self.RawDataBufferAddressOffset = Self.RawDataBufferAddressOffset + 4
            Peek(Self.RawDataBufferAddress + Self.RawDataBufferAddressOffset, Self.WMInputQ.KBExtraInformation)

        End
        Self.MousePos.MouseX = Self.RawMouse.MouseX
        Self.MousePos.MouseY = Self.RawMouse.MouseY
        

        Return 0

c25_RenderEngineClass.RegisterRawInputDevices                   Procedure(<Long _handle>)

Code

    Self.RawInputDevice.UsagePage = 1
    Self.RawInputDevice.Usage = 02h
    Self.RawInputDevice.Flags = C25_RIDEV_INPUTSINK
    Self.RawInputDevice.WindowHandleTarget = _handle
    c25_RegisterRawInputDevices(Address(Self.RawInputDevice),1, Size(Self.RawInputDevice))

    Self.RawInputDevice.UsagePage = 1
    Self.RawInputDevice.Usage = 06h
    Self.RawInputDevice.Flags = C25_RIDEV_INPUTSINK
    Self.RawInputDevice.WindowHandleTarget = _handle
    c25_RegisterRawInputDevices(Address(Self.RawInputDevice),1, Size(Self.RawInputDevice))

    Return 0

c25_RenderEngineClass.Construct                                 Procedure()

ClassStarter    &c25_ClassStarter

Code

    Self.ClassTypeName = 'c25_RenderEngineClass'

    ClassStarter &= NEW c25_ClassStarter()
    Self.ProgramHandlerClass &= (ClassStarter.Start(Self.ClassTypeName))
    Dispose(ClassStarter)

    !Self.GdiPlusClass &= Self.ProgramHandlerClass.GdiPlusClass
    Self.GdiPlusClass &= NEW c25_GdiPlusClass()
    
    If Self.GdiPlusClass &= NULL
        Message('error Self.GdiPlusClass is null')
    END
    
    Self.GlobalAlpha = 255

    Self.WMInputQ &= NEW WMInput_TYPE()
    Self.RawDataBufferAddress = Address(Self.RawDataBuffer)
    Self.NanoSync &= NEW c25_NanoSyncClass()
    
    Self.RawMouse &= NEW RawMouse_TYPE()
    Self.WMInputQ &= NEW WMInput_TYPE()

    !Self.StLog                  &= NEW StringTheory()
    Self.WinApiClass            &= New c25_WinApiClass()
    Self.BitConverterClass      &= New c25_BitConverterClass()

    !Self.StLogFileName = 'm:\c25_RenderEngineClass.txt'
    !Remove(!Self.StLogFileName)
    
    !!Self.StLog.Start()
    !!Self.StLog.SetValue('c25_RenderEngineClass.Construct' & '<13><10>' )
    !!Self.StLog.SaveFile(!!Self.StLogFileName)
    

c25_RenderEngineClass.CreateTabs                                Procedure()

TabClass    &c25_TabClass

CODE

    
    !!Self.StLog.SetValue('c25_RenderEngineClass.CreateTabs' & '<13><10>' )
    !!Self.StLog.SaveFile(!!Self.StLogFileName, true)
    
    Self.ProgramHandlerClass.RootLog.WriteLog('c25_RenderEngineClass.CreateTabs - START')
    
    I# = 0
    Loop
        I# = I# + 1
        Get(Self.ProgramHandlerClass.TabObject,I#)
        If Errorcode() > 0
            BREAK
        End
        TabClass &= NEW c25_TabClass()
        TabClass.Id = Self.ProgramHandlerClass.TabObject.Id

        If TabClass.Id = 1
            TabClass.Active = TRUE
        End

        Self.ProgramHandlerClass.TabObject.ClassPtr = Address(TabClass)
        Put(Self.ProgramHandlerClass.TabObject)
        TabClass.Init()

        Self.ProgramHandlerClass.TabObject.WinHandle = TabClass.MessageOnlyWindowClass.WindowHandle
        Self.ProgramHandlerClass.TabsWindowHandleArray[Self.ProgramHandlerClass.TabObject.Id] = TabClass.MessageOnlyWindowClass.WindowHandle
        
        If Self.ProgramHandlerClass.TabsArrayMax < TabClass.Id
            Self.ProgramHandlerClass.TabsArrayMax = TabClass.Id
        End
        
        BREAK
    End
    Self.ProgramHandlerClass.RootLog.WriteLog('c25_RenderEngineClass.CreateTabs - END')
    Return 0
    
    

c25_RenderEngineClass.Init                                      Procedure()

Code
        
    !!!Self.StLog.SetValue('c25_RenderEngineClass.Init' & '<13><10>' )
    !!!Self.StLog.SaveFile(!!Self.StLogFileName, true)        

    Self.ProgramHandlerClass.RootLog.WriteLog('c25_RenderEngineClass.Init - START')
    Self.BufferImageWidth = Self.ProgramHandlerClass.DisplayWidth
    Self.BufferImageHeight = Self.ProgramHandlerClass.DisplayHeight
    Self.GdiPlusClass.CreateCanvas(Self.ProgramHandlerClass.DisplayWidth, Self.ProgramHandlerClass.DisplayHeight, Self.BufferGraphics, Self.BufferImagePtr, Self.BufferScan0, Self.BufferAllocSize)
    Self.ProgramHandlerClass.RootLog.WriteLog('c25_RenderEngineClass.Init - END')
        
    !Self.InitDone = True
    Return 0

c25_RenderEngineClass.Destruct                                  Procedure()

Code

c25_RenderEngineClass.Draw                                      Procedure(long _whandle, long _activeState)

PaintAllControls        EQUATE(-1)
Tuple                   Like(Tuple2_TYPE)
TabClass                &c25_TabClass
DC                      LONG

Code

    If Self.ProgramHandlerClass &= NULL
        return 0
    End
    If Self.ProgramHandlerClass.Ready = 0
        return 0
    END
    
    
!    !!Self.StLog.SetValue('c25_RenderEngineClass.Draw' & '<13><10>' )
!    !!Self.StLog.SaveFile(!!Self.StLogFileName, true)
    
        
        
        !Self.ProgramHandlerClass.UpdateRenderEngineClassDraw()
        DC = c25_GetWindowDC(_whandle)

        c25_GdipCreateFromHDC(DC ,Address(Self.PaintGraphics))

!!        c25_GdipSetTextRenderingHint(Self.BufferGraphics, TextRenderingHintClearTypeGridFit)
!!        c25_GdipSetSmoothingMode(Self.BufferGraphics, SmoothingModeNone)
!!        c25_GdipSetCompositingQuality(Self.BufferGraphics,CompositingQualityHighQuality)
!!        c25_GdipSetInterpolationMode(Self.BufferGraphics,InterpolationModeBilinear )
!!        c25_GdipSetPixelOffsetMode(Self.BufferGraphics,PixelOffsetModeNone )

        Self.TempRect.Left          = 0
        Self.TempRect.Top           = 0
        Self.TempRect.Width         = Self.ProgramHandlerClass.WindowRect.Width
        Self.TempRect.Height        = 80
        Self.TempRect.Right         = Self.TempRect.Width - Self.TempRect.Left
        Self.TempRect.Bottom        = Self.TempRect.Top + Self.TempRect.Height

!        Case _activeState
!        Of WindowAppState:Active
!            Self.ProgramHandlerClass.BackdropColorHeader = Self.GdiPlusClass.GetColorMacroRGBA(232,232,232)
!            c25_DwmSetWindowAttribute(Self.ProgramHandlerClass.WindowHandle, C25_DWMWA_CAPTION_COLOR, Address(Self.ProgramHandlerClass.BackdropColorHeader), 4)
!            Self.ProgramHandlerClass.BorderColor = Self.GdiPlusClass.GetColorMacroRGBA(148, 170, 193)
!            c25_DwmSetWindowAttribute(Self.ProgramHandlerClass.WindowHandle, C25_DWMWA_BORDER_COLOR, Address(Self.ProgramHandlerClass.BorderColor), 4)
!            Self.LinearGradientBrush = Self.GdiPlusClass.GetSolidBrush( ,Self.GlobalAlpha,232,232,232)
!        Of WindowAppState:NotActive
!            Self.ProgramHandlerClass.BackdropColorHeaderActive = Self.GdiPlusClass.GetColorMacroRGBA(205, 221, 236)
!            c25_DwmSetWindowAttribute(Self.ProgramHandlerClass.WindowHandle, C25_DWMWA_CAPTION_COLOR, Address(Self.ProgramHandlerClass.BackdropColorHeaderActive), 4)
!            Self.ProgramHandlerClass.BorderColorActive = Self.GdiPlusClass.GetColorMacroRGBA(133,176, 218)
!            c25_DwmSetWindowAttribute(Self.ProgramHandlerClass.WindowHandle, C25_DWMWA_BORDER_COLOR, Address(Self.ProgramHandlerClass.BorderColorActive), 4)
!            Self.LinearGradientBrush = Self.GdiPlusClass.GetSolidBrush( ,Self.GlobalAlpha, 205, 221, 236)
!        End
!        c25_GdipFillRectangleI(Self.BufferGraphics, Self.LinearGradientBrush,Self.TempRect.Left,Self.TempRect.Top,Self.TempRect.Width,Self.TempRect.Height)
!        
        I# = 0
        LOOP Self.ProgramHandlerClass.TabsArrayMax TIMES
            I# = I# + 1
            If Self.ProgramHandlerClass.TabsClassPtrArray[I#] = 0
                BREAK
            End
            TabClass &= (Self.ProgramHandlerClass.TabsClassPtrArray[I#])
            If TabClass.Active = FALSE
                TabClass &= null
                CYCLE
            End
            !Self.ProgramHandlerClass.UpdateRenderEngineClassDraw()

            !C25_GdipGetDC(TabClass.TabRenderEngineClass.CanvasGraphics[CanvasState:Normal], Address(Self.DcTemp))
            !X# = TabClass.TabRenderEngineClass.Paint()
            X# = TabClass.Paint()
            If X# = 0
                !CYCLE
            END
            
            Clear(Self.BufferBitmapInfo)
            Self.BufferBitmapInfo.Size              = 40
            Self.BufferBitmapInfo.Width             = TabClass.TabRenderEngineClass.CanvasWidth[CanvasState:Normal]
            Self.BufferBitmapInfo.Height            = TabClass.TabRenderEngineClass.CanvasHeight[CanvasState:Normal] * -1
            Self.BufferBitmapInfo.Planes            = 1
            Self.BufferBitmapInfo.BitCount          = 32
            Self.BufferBitmapInfo.Compression       = 0
            Self.BufferBitmapInfo.SizeImage         = 0
            Self.BufferBitmapInfo.XpelsPerMeter     = 0
            Self.BufferBitmapInfo.YPelsPerMeter     = 0
            Self.BufferBitmapInfo.ClrUsed           = 0
            Self.BufferBitmapInfo.ClrImportant      = 0   
            Case Self.ProgramHandlerClass.WinAppState
            Of WindowAppState:Active
                C25_SetDIBitsToDevice(DC , 0, 0, TabClass.TabRenderEngineClass.CanvasWidth[CanvasState:Normal], TabClass.TabRenderEngineClass.CanvasHeight[CanvasState:Normal],0,0,0, TabClass.TabRenderEngineClass.CanvasHeight[CanvasState:Normal], TabClass.TabRenderEngineClass.CanvasScan0[CanvasState:Normal],Address(Self.BufferBitmapInfo), c25_DIB_RGB_COLORS)
            Of WindowAppState:NotActive
                C25_SetDIBitsToDevice(DC , 0, 0, TabClass.TabRenderEngineClass.CanvasWidth[CanvasState:NormalDimmed], TabClass.TabRenderEngineClass.CanvasHeight[CanvasState:NormalDimmed],0,0,0, TabClass.TabRenderEngineClass.CanvasHeight[CanvasState:NormalDimmed], TabClass.TabRenderEngineClass.CanvasScan0[CanvasState:NormalDimmed],Address(Self.BufferBitmapInfo), c25_DIB_RGB_COLORS)
            End
!            If Self.DcTemp <> 0
!                C25_GdipReleaseDC(TabClass.TabRenderEngineClass.CanvasGraphics[CanvasState:Normal], Self.DcTemp)
!                Self.DcTemp = 0
!            END   

            
            
            
            
            TabClass &= null
            
            Break
        End
        
!        Self.DrawSystemButtons(_activeState)
        !C25_GdipDrawImageRectI(Self.PaintGraphics, Self.BufferImagePtr, 0, 0, Self.BufferImageWidth, Self.BufferImageHeight)

        c25_GdipDeleteGraphics(Self.PaintGraphics)
        c25_ReleaseDC(_whandle, DC)

        Return 0

c25_RenderEngineClass.DrawSystemButtons                         Procedure(long _activeState)


Code

!    Self.ProgramHandlerClass.CloseButtonRect.Width      = 45
!    Self.ProgramHandlerClass.CloseButtonRect.Height     = 29
!
!    Self.ProgramHandlerClass.CloseButtonRect.Top        = 5
!    Self.ProgramHandlerClass.CloseButtonRect.Right      = Self.ProgramHandlerClass.WindowRect.Width - 2
!
!    Self.ProgramHandlerClass.CloseButtonRect.Left       = Self.ProgramHandlerClass.CloseButtonRect.Right - Self.ProgramHandlerClass.CloseButtonRect.Width
!    Self.ProgramHandlerClass.CloseButtonRect.Bottom     = Self.ProgramHandlerClass.CloseButtonRect.Top + Self.ProgramHandlerClass.CloseButtonRect.Height
!
!    Case Self.ProgramHandlerClass.CloseButtonState
!    Of C25_CLOSEBUTTONSTATES:CBS_DISABLED
!        c25_GdipFillRectangleI(Self.BufferGraphics, Self.GdiPlusClass.NewSolidBrush(, , 255,50,50,50),Self.ProgramHandlerClass.CloseButtonRect.Left,Self.ProgramHandlerClass.CloseButtonRect.Top,Self.ProgramHandlerClass.CloseButtonRect.Width,Self.ProgramHandlerClass.CloseButtonRect.Height)
!        Self.SomeColorARGB.A = 245
!        Self.SomeColorARGB.R = 23
!        Self.SomeColorARGB.G = 24
!        Self.SomeColorARGB.B = 25
!    Of C25_CLOSEBUTTONSTATES:CBS_HOT
!        c25_GdipFillRectangleI(Self.BufferGraphics, Self.GdiPlusClass.NewSolidBrush(, , 255,196,43,28),Self.ProgramHandlerClass.CloseButtonRect.Left,Self.ProgramHandlerClass.CloseButtonRect.Top,Self.ProgramHandlerClass.CloseButtonRect.Width,Self.ProgramHandlerClass.CloseButtonRect.Height)
!        Self.SomeColorARGB.A = 245
!        Self.SomeColorARGB.R = 255
!        Self.SomeColorARGB.G = 255
!        Self.SomeColorARGB.B = 255
!    Of C25_CLOSEBUTTONSTATES:CBS_NORMAL
!        Self.SomeColorARGB.A = 245
!        Self.SomeColorARGB.R = 23
!        Self.SomeColorARGB.G = 24
!        Self.SomeColorARGB.B = 25
!    Of C25_CLOSEBUTTONSTATES:CBS_PUSHED
!        c25_GdipFillRectangleI(Self.BufferGraphics, Self.GdiPlusClass.NewSolidBrush(, , 255,196,83,68),Self.ProgramHandlerClass.CloseButtonRect.Left,Self.ProgramHandlerClass.CloseButtonRect.Top,Self.ProgramHandlerClass.CloseButtonRect.Width,Self.ProgramHandlerClass.CloseButtonRect.Height)
!        Self.SomeColorARGB.A = 245
!        Self.SomeColorARGB.R = 255
!        Self.SomeColorARGB.G = 255
!        Self.SomeColorARGB.B = 255
!    End
!    Self.SomeSReal = 1
!    c25_GdipCreatePen1(Self.SomeColor,Self.SomeSReal, UnitPixel, Address(Self.SomePenHandle))
!    Self.ProgramHandlerClass.CloseButtonRect.Left      = Self.ProgramHandlerClass.CloseButtonRect.Left + 17
!    Self.ProgramHandlerClass.CloseButtonRect.Right     = Self.ProgramHandlerClass.CloseButtonRect.Left + 10
!    Self.ProgramHandlerClass.CloseButtonRect.Top       = 10
!    Self.ProgramHandlerClass.CloseButtonRect.Bottom    = Self.ProgramHandlerClass.CloseButtonRect.Top + 10
!    c25_GdipDrawLineI(Self.BufferGraphics, Self.SomePenHandle, Self.ProgramHandlerClass.CloseButtonRect.Left, Self.ProgramHandlerClass.CloseButtonRect.Top,  Self.ProgramHandlerClass.CloseButtonRect.Right, Self.ProgramHandlerClass.CloseButtonRect.Bottom)
!    c25_GdipDrawLineI(Self.BufferGraphics, Self.SomePenHandle, Self.ProgramHandlerClass.CloseButtonRect.Left, Self.ProgramHandlerClass.CloseButtonRect.Bottom,  Self.ProgramHandlerClass.CloseButtonRect.Right, Self.ProgramHandlerClass.CloseButtonRect.Top)

    Return 0

