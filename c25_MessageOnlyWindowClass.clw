					Member

    Include('c25_MessageOnlyWindowClass.inc'),Once
					Map

                            Include('i64.inc')
                            Include('cwutil.inc')
                            Include('c25_WinApiPrototypes.inc')
                            Module('c25_MessageOnlyWindowClass.clw')
WinMesOnlyHandlerThread             Procedure(Long _paramA, Long _paramB),Long
                            End
                        End

c25_MessageOnlyWindowClass.Construct                                                     Procedure()

ClassStarter  &c25_ClassStarter

Code

    ClassStarter &= NEW c25_ClassStarter()
    Self.ProgramHandlerClass &= (ClassStarter.Start(Self.ClassTypeName))
    Dispose(ClassStarter)
    


    Self.BitConverter 		&= NEW c25_BitConverterClass()
    Self.WindowMessage     	&= NEW WindowMessage_TYPE
    Self.WndClassExA 		&= NEW WndClassExA_TYPE()
    Self.ExtraWindowSpace 	&= NEW ExtraWindowSpace_TYPE()
    Self.NanoSync 			&= NEW c25_NanoSyncClass()


c25_MessageOnlyWindowClass.Destruct                                                      Procedure()

	Code

		Dispose(Self.BitConverter)



c25_MessageOnlyWindowClass.Proc_000016_WM_CLOSE                                          Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam)

	Code

		!c25_PostMessageA(Self.ProgramHandlerClass.WindowHandle,c25_WM_CLOSE,0,0)

c25_MessageOnlyWindowClass.Proc_000275_WM_TIMER                                      Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam)


	Code
		
		Self.ReturnWndProc.ReturnVal = 0
		Self.ReturnWndProc.Processed = True


c25_MessageOnlyWindowClass.InitWindow                            Procedure(<long _parentClassTypeEnum> , <long _parentClassPtr>)

	Code

		Self.ParentClassTypeEnum = _parentClassTypeEnum
		Self.ParentClassPtr = _parentClassPtr
		
		Case Self.ParentClassTypeEnum
        Of c25ClassTypes:DataTableClassType
            Self.DataTableClass &= (Self.ParentClassPtr)
        Of c25ClassTypes:ProgramHandlerClassType
            Self.ProgramHandlerClass &= (Self.ParentClassPtr)
        Of c25ClassTypes:QueueCreateClassType
            Self.QueueCreateClass &= (Self.ParentClassPtr)
        Of c25ClassTypes:TabRenderEngineClass
            Self.TabRenderEngineClass &= (Self.ParentClassPtr)       
        Of c25ClassTypes:TreeViewClass
            Self.TreeViewClass &= (Self.ParentClassPtr)              
        Of c25ClassTypes:TabClass
            Self.TabClass &= (Self.ParentClassPtr)   
        Of c25ClassTypes:ControlClass
			Self.ControlClass &= (Self.ParentClassPtr)               
		End
		
		Clear(Self.WndClassExA)
		Self.WndClassExA.Size                               = Size(Self.WndClassExA)
		Self.WndClassExA.Style                              = 0
		Self.WndClassExA.WndProcPtr                         = 0
		Self.WndClassExA.ClsExtra                           = 8
		Self.WndClassExA.WndExtra                           = Size(Self.ExtraWindowSpace)
		Self.WndClassExA.Instance                           = System{Prop:AppInstance}
		Self.WndClassExA.Icon                               = 0
		Self.WndClassExA.Cursor                             = 0
		Self.WndClassExA.Background                         = 0
		Self.WndClassExA.MenuName                           = 0
		Self.WndClassExA.ClassName                          = 0
		Self.WndClassExA.IconSm                             = 0
		Self.WndClassEx_ClassName                           = 'c25_MessageOnlyWindowClass' & Chr(0)
		Return 0

c25_MessageOnlyWindowClass.OpenWindow                            Procedure()


SECURITY_ATTRIBUTES             Group
nLength                             Long
lpSecurityDescriptor                Long
bInheritHandle                      BOOL
                                End
SECURITY_DESCRIPTOR             Group
Revision                            byte
Sbz1                                byte
Control                             long
Owner                               long
Group                               long
Sacl                                long
Dacl                                Long
                                End
NewestToken        long
UserName           cstring(255)
DomainName           cstring(255)
Pw           cstring(255)
dupToken         Long

processId                                                               Long
process                                                                 Long
TokenInfoOut                                                            long
TokenInfoOutString                                                      string(10000)
TokenInfoOutRequired                                                    long

SID                                                                     Group,Pre(SID)
Revision                                                                    Byte
SubAuthorityCount                                                           Byte
Buffer                                                                      String(65000)
                                                                        End
SID_IDENTIFIER_AUTHORITY                                                String(6)

	Code

        
    
        !processId = c25_GetCurrentProcessId()
        !Message(processId)
        !process = C25_Openprocess(PROCESS_ALL_ACCESS , false, processId)
        !Message(process)
        
        !C25_SetLastError(0)
        !X# = c25_OpenProcessToken(process, TOKEN_ALL_ACCESS, Address(NewestToken))
        !X# = c25_OpenProcessToken(process, TOKEN_QUERY + TOKEN_IMPERSONATE, Address(NewestToken))
        !Message(NewestToken)
        !c25_ImpersonateSelf(SecurityAnonymous)
        
        
!!!        TokenInfoOutRequired = 0; 
!!!        X# = c25_GetTokenInformation(NewestToken, TOKEN_INFORMATION_CLASS:TokenUser , 0 , 0, Address(TokenInfoOutRequired))!;Message(' TOKEN_INFORMATION_CLASS:TokenUserTokenInfoOutRequired ' & TokenInfoOutRequired)
!!!        X# = c25_GetTokenInformation(NewestToken, TOKEN_INFORMATION_CLASS:TokenUser , Address(TokenInfoOutString) , TokenInfoOutRequired * -1, Address(TokenInfoOutRequired))!;Message(' TOKEN_INFORMATION_CLASS:TokenUserTokenInfoOutRequired ' & TokenInfoOutRequired)
!!!        
!!!!        
!!!!        TokenInfoOutRequired = 0; X# = c25_GetTokenInformation(NewestToken, TOKEN_INFORMATION_CLASS:TokenGroups , 0 , 0, Address(TokenInfoOutRequired));Message(' TokenGroups ' & TokenInfoOutRequired)
!!!!        TokenInfoOutRequired = 0; X# = c25_GetTokenInformation(NewestToken, TOKEN_INFORMATION_CLASS:TokenPrivileges , 0 , 0, Address(TokenInfoOutRequired));Message(' TokenPrivileges ' & TokenInfoOutRequired)
!!!        TokenInfoOutRequired = 0; X# = c25_GetTokenInformation(NewestToken, TOKEN_INFORMATION_CLASS:TokenOwner , 0 , 0, Address(TokenInfoOutRequired))!;Message(' TokenOwner ' & TokenInfoOutRequired)
!!!        X# = c25_GetTokenInformation(NewestToken, TOKEN_INFORMATION_CLASS:TokenOwner , Address(TokenInfoOut) , TokenInfoOutRequired * -1, Address(TokenInfoOutRequired));Message(' TOKEN_INFORMATION_CLASS:TokenOwner ' & TokenInfoOutRequired)
!!!!        Message('TokenInfoOut ' & TokenInfoOut)
!!!!        If TokenInfoOut <> 0
!!!!            C25_Memcpy(address(SID),TokenInfoOut, 1)
!!!!            Message(SID.Revision)
!!!!            Message(SID.SubAuthorityCount)
!!!!        End
!!!        Message('go self')
!        TokenInfoOutRequired = 0; X# = c25_GetTokenInformation(NewestToken, TOKEN_INFORMATION_CLASS:TokenPrimaryGroup , 0 , 0, Address(TokenInfoOutRequired));Message(' TokenPrimaryGroup ' & TokenInfoOutRequired)
!        TokenInfoOutRequired = 0; X# = c25_GetTokenInformation(NewestToken, TOKEN_INFORMATION_CLASS:TokenDefaultDacl , 0 , 0, Address(TokenInfoOutRequired));Message(' TokenDefaultDacl ' & TokenInfoOutRequired)
!        TokenInfoOutRequired = 0; X# = c25_GetTokenInformation(NewestToken, TOKEN_INFORMATION_CLASS:TokenSource , 0 , 0, Address(TokenInfoOutRequired));Message(' TokenSource ' & TokenInfoOutRequired)
!        TokenInfoOutRequired = 0; X# = c25_GetTokenInformation(NewestToken, TOKEN_INFORMATION_CLASS:TokenType , 0 , 0, Address(TokenInfoOutRequired));Message(' TokenType ' & TokenInfoOutRequired)
!        TokenInfoOutRequired = 0; X# = c25_GetTokenInformation(NewestToken, TOKEN_INFORMATION_CLASS:TokenImpersonationLevel , 0 , 0, Address(TokenInfoOutRequired));Message(' TokenImpersonationLevel ' & TokenInfoOutRequired)
!        TokenInfoOutRequired = 0; X# = c25_GetTokenInformation(NewestToken, TOKEN_INFORMATION_CLASS:TokenStatistics , 0 , 0, Address(TokenInfoOutRequired));Message(' TokenStatistics ' & TokenInfoOutRequired)
        
!        X# = c25_GetTokenInformation(NewestToken, TOKEN_INFORMATION_CLASS:TokenUser , 0 , 0, Address(TokenInfoOutRequired));Message(' TOKEN_INFORMATION_CLASS:TokenUserTokenInfoOutRequired ' & TokenInfoOutRequired)
!        X# = c25_GetTokenInformation(NewestToken, TOKEN_INFORMATION_CLASS:TokenUser , 0 , 0, Address(TokenInfoOutRequired));Message(' TOKEN_INFORMATION_CLASS:TokenUserTokenInfoOutRequired ' & TokenInfoOutRequired)
!        X# = c25_GetTokenInformation(NewestToken, TOKEN_INFORMATION_CLASS:TokenUser , 0 , 0, Address(TokenInfoOutRequired));Message(' TOKEN_INFORMATION_CLASS:TokenUserTokenInfoOutRequired ' & TokenInfoOutRequired)
!        X# = c25_GetTokenInformation(NewestToken, TOKEN_INFORMATION_CLASS:TokenUser , 0 , 0, Address(TokenInfoOutRequired));Message(' TOKEN_INFORMATION_CLASS:TokenUserTokenInfoOutRequired ' & TokenInfoOutRequired)
!        X# = c25_GetTokenInformation(NewestToken, TOKEN_INFORMATION_CLASS:TokenUser , 0 , 0, Address(TokenInfoOutRequired));Message(' TOKEN_INFORMATION_CLASS:TokenUserTokenInfoOutRequired ' & TokenInfoOutRequired)
!        X# = c25_GetTokenInformation(NewestToken, TOKEN_INFORMATION_CLASS:TokenUser , 0 , 0, Address(TokenInfoOutRequired));Message(' TOKEN_INFORMATION_CLASS:TokenUserTokenInfoOutRequired ' & TokenInfoOutRequired)
!        X# = c25_GetTokenInformation(NewestToken, TOKEN_INFORMATION_CLASS:TokenUser , 0 , 0, Address(TokenInfoOutRequired));Message(' TOKEN_INFORMATION_CLASS:TokenUserTokenInfoOutRequired ' & TokenInfoOutRequired)
        
        
        
        !X# = c25_GetTokenInformation(NewestToken, TOKEN_INFORMATION_CLASS:TokenUser , Address(TokenInfoOutString), Size(TokenInfoOutString), Address(TokenInfoOutRequired))
        !Message(X#)
        !Message('TokenInfoOutRequired ' & TokenInfoOutRequired)
        
        
        !c25_RevertToSelf()
        
        !Message(NewestToken & ', C25_GetLastError c25_OpenProcessToken ' & C25_GetLastError())  
!        c25_CloseHandle(NewestToken)
!        c25_CloseHandle(process)
!        SECURITY_ATTRIBUTES.nLength = 9
!        SECURITY_ATTRIBUTES.lpSecurityDescriptor = Address(SECURITY_DESCRIPTOR)
!        
        !Self.ThreadHandle = c25_CreateThread(Address(SECURITY_ATTRIBUTES), 010000h, Address(WinMesOnlyHandlerThread), Address(Self), 0, Address(Self.ThreadId))
        !Self.ThreadHandle = c25_CreateThread(THREAD_ALL_ACCESS, 010000h, Address(WinMesOnlyHandlerThread), Address(Self), 0, Address(Self.ThreadId))
        
        
        
        
        
        Self.ThreadHandle = c25_CreateThread(0, 010000h, Address(WinMesOnlyHandlerThread), Address(Self), 0, Address(Self.ThreadId))
        If Self.ThreadHandle = 0
            Message('error c25_CreateThread')
        End
!        
!!        Message('Self.ThreadHandle ' & Self.ThreadHandle)
!!        
!        !Message(c25_GetCurrentThreadId() & ', ' & c25_GetThreadId(Self.ThreadHandle))
!!    
!        !HT# = c25_OpenThread(THREAD_ALL_ACCESS , False, c25_GetThreadId(Self.ThreadHandle))
!    
!        !Message(C25_GetLastError() & ',real thread handle : ' & HT#)
!            
!!        X# = c25_OpenThreadToken(Self.ThreadHandle, TOKEN_QUERY + TOKEN_IMPERSONATE, false , Address(NewestToken))
!!        Message(X#)
!!        Message('C25_GetLastError c25_OpenThreadToken ' & C25_GetLastError())
!!        
!!        Message('ThisToken ' & NewestToken)       
!!        
!        
!        UserName = 'Menno' & Chr(0) & Chr(0)
!        !Pw = 'PepperMint123!!!' & Chr(0) & Chr(0)
!        Pw = 'SuperMan777!!!' & Chr(0) & Chr(0)
!        DomainName = 'PC1' & Chr(0) & Chr(0)
!        
!
!    !    B# = c25_LogonUserA(Address(UserName), Address(DomainName), Address(Pw), LOGON32_LOGON_NEW_CREDENTIALS, LOGON32_PROVIDER_WINNT50, Address(ThisToken))
!        
!        !B# = c25_LogonUserA(Address(UserName), Address(DomainName), Address(Pw), LOGON32_LOGON_NETWORK , LOGON32_PROVIDER_DEFAULT, Address(ThisToken))
!        B# = c25_LogonUserA(Address(UserName), Address(DomainName), Address(Pw), LOGON32_LOGON_INTERACTIVE , LOGON32_PROVIDER_DEFAULT, Address(NewestToken))
!        Message(B# & ',c25_LogonUserA ThisToken ' & NewestToken)    
!        
!        X# = c25_ImpersonateLoggedOnUser(NewestToken)
!        Message('c25_ImpersonateLoggedOnUser : ' & X#)
!        !Message('c25_ImpersonateLoggedOnUser ThisToken ' & NewestToken.hi & ', ' & NewestToken.lo)    
!        X# = c25_DuplicateTokenEx(NewestToken, TOKEN_QUERY + TOKEN_IMPERSONATE, 0, SecurityImpersonation, TokenImpersonation, Address(dupToken)) 
!        Message('c25_DuplicateTokenEx : ' & X#)
!        Message('dupToken : ' & dupToken)
!        
!        
        
		Loop
			c25_SleepEx(20,0)
			If Self.IsActive <> 0
				Break
			End
		End
		Return Self.WindowHandle

c25_MessageOnlyWindowClass.PreDestructWindow                     Procedure()

	Code

		Dispose(Self.BitConverter)
		Return 0

c25_MessageOnlyWindowClass.Proc_000000_CWM_CloseApp             Procedure(long _windowHandle,ulong _message, ulong _wParam, long _lParam)

	Code

		Self.PreDestructWindow()
		C25_PostMessageA(_windowHandle, c25_Wm_Close, 0, 0)

c25_MessageOnlyWindowClass.WndProc_Process                       Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam)

PostProcess bool

	Code

		Clear(Self.ReturnWndProc)

		Case Self.ParentClassTypeEnum
		Of c25ClassTypes:DataTableClassType
            Self.DataTableClass.WndProc_Process(        _windowHandle, _message, _wParam,_lParam, Self.ReturnWndProc.Processed, Self.ReturnWndProc.ReturnVal, PostProcess)
		Of c25ClassTypes:ProgramHandlerClassType
            Self.ProgramHandlerClass.WndProc_Process(   _windowHandle, _message, _wParam,_lParam, Self.ReturnWndProc.Processed, Self.ReturnWndProc.ReturnVal, PostProcess)
		Of c25ClassTypes:QueueCreateClassType
            Self.QueueCreateClass.WndProc_Process(      _windowHandle, _message, _wParam,_lParam, Self.ReturnWndProc.Processed, Self.ReturnWndProc.ReturnVal, PostProcess)
!		Of c25ClassTypes:TabRenderEngineClass
!            Self.TabRenderEngineClass.WndProc_Process(  _windowHandle, _message, _wParam,_lParam, Self.ReturnWndProc.Processed, Self.ReturnWndProc.ReturnVal, PostProcess)        
		Of c25ClassTypes:TreeViewClass
            Self.TreeViewClass.WndProc_Process(         _windowHandle, _message, _wParam,_lParam, Self.ReturnWndProc.Processed, Self.ReturnWndProc.ReturnVal, PostProcess)
		Of c25ClassTypes:TabClass
            Self.TabClass.WndProc_Process(         _windowHandle, _message, _wParam,_lParam, Self.ReturnWndProc.Processed, Self.ReturnWndProc.ReturnVal, PostProcess)
		Of c25ClassTypes:ControlClass
            Self.ControlClass.WndProc_Process(         _windowHandle, _message, _wParam,_lParam, Self.ReturnWndProc.Processed, Self.ReturnWndProc.ReturnVal, PostProcess)     
!		Of c25ClassTypes:ControlRenderClass
!            Self.ControlRenderClass.WndProc_Process(         _windowHandle, _message, _wParam,_lParam, Self.ReturnWndProc.Processed, Self.ReturnWndProc.ReturnVal, PostProcess)               
        End

		If Self.ParentClassTypeEnum = 0 Or PostProcess
			If _message > 1 And _message < 1024
				Case _message
				Of C25_Wm_Activate
				Of C25_Wm_Quit
					C25_PostMessageA(C25_Hwnd_Broadcast, Self.ProgramHandlerClass.WM_C25_CloseApp, 0 ,0)
				Of C25_WM_CLOSE
					C25_PostMessageA(C25_Hwnd_Broadcast,  Self.ProgramHandlerClass.WM_C25_CloseApp, 0 ,0)
					Self.Proc_000016_WM_CLOSE(_windowHandle, _message, _wParam, _lParam)
				Of C25_WM_TIMER
					Self.Proc_000275_WM_TIMER(_windowHandle, _message, _wParam, _lParam)
				End
            Else
			End
		End
		Return Self.ReturnWndProc

WinMesOnlyHandlerThread                                         Procedure(Long _paramA, Long _paramB)

    Map
        WndProcWorker(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam),Long ,Pascal
        GetMessageNameFromId(ULong _id),String
    End

WindowHandler                                       &c25_MessageOnlyWindowClass()
WindowHandle                                        Long
WindowNameA                                         String(255)
WndClassEx_ClassName                                String(245)
WndClassExA                                         Group(WndClassExA_TYPE),Pre(WndClassExA)
                                                    End
WindowMessage                                       Group(WindowMessage_TYPE),Pre(WindowMessage)
                                                    End
WindowMessageAddress                                Long
UserDataLongIn                                      Long
T                                                   Long
StLog                                               &StringTheory

	Code

		c25_AttachThreadToClarion(True)

		WindowHandler                              &= (_paramB)
		
		WindowHandler.WndClassExA.WndProcPtr        = Address(WndProcWorker)
		WndClassExA                                 = WindowHandler.WndClassExA
		WindowNameA                                 = WindowHandler.WindowNameA
		WndClassEx_ClassName                        = WindowHandler.WndClassEx_ClassName
		WndClassExA.ClassName                       = Address(WndClassEx_ClassName)
		WndClassExA.WndExtra                        = 60

		c25_UnregisterClassA(Address(WndClassEx_ClassName), 0)
		WindowHandler.AtomWindowClassExA         = c25_RegisterClassExA(Address(WndClassExA))
		WindowHandle = c25_CreateWindowExA(0, Address(WndClassEx_ClassName), Address(WindowNameA), WindowStyleNull#, 100, 100, 100, 100, c25_HWND_MESSAGE,0, System{Prop:AppInstance}, 0)
		WindowHandler.WindowHandle              = WindowHandle
		WindowHandler.TimerElapse				= 100
		WindowHandler.TimerIDEvent              = c25_SetTimer(WindowHandle, 0, WindowHandler.TimerElapse, 0)
		
		WindowHandler.ExtraWindowSpace.Size                         = Size(WindowHandler.ExtraWindowSpace)
		WindowHandler.ExtraWindowSpace.ExtraWindowSpaceGuid         = C25_ExtraWindowSpaceGuid
		WindowHandler.ExtraWindowSpace.WindowHandle                 = WindowHandle
		WindowHandler.ExtraWindowSpace.WindowHandlerClassPtr        = Address(WindowHandler)

		T = WindowHandler.ExtraWindowSpace.Size + 4

		Loop
			T = T - 4
			If T < 0
				Break
			End
			Peek(Address(WindowHandler.ExtraWindowSpace) + T, UserDataLongIn)
			c25_SetWindowLongA(WindowHandle, T, UserDataLongIn)
		End

		WindowMessageAddress                            = Address(WindowMessage)

		c25_ShowWindow(WindowHandle,True)

		WindowHandler.IsActive = True
		Loop
			Case c25_GetMessage(WindowMessageAddress, 0, 0, 0)
			Of 0
				Break
			Of -1
				Cycle
			End
			c25_TranslateMessage(WindowMessageAddress)
			c25_DispatchMessage(WindowMessageAddress)
		End
		Return 0

WndProcWorker                   Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam)

WindowHandlerWorker             &c25_MessageOnlyWindowClass
WndProc                         Group,Pre(WndProc)
WindowExtraSize                     Long
UserDataLongOut                     Long
T                                   Long
                                End
ReturnWndProc                   GROUP,Pre(ReturnWndProc)
Processed                           BOOL
ReturnVal                           Long
                                End
WinUserData                     Group(ExtraWindowSpace_TYPE),Pre(WinUserData)
                                End

	Code

		Clear(ReturnWndProc)

		WndProc.WindowExtraSize = c25_GetClassLongA(_windowHandle, C25_GCL_CBWNDEXTRA)

		If WndProc.WindowExtraSize > 0
			If c25_GetWindowLongA(_windowHandle, 0) = 60
				WndProc.T = WndProc.WindowExtraSize + 4
				Loop
					WndProc.T = WndProc.T - 4
					If WndProc.T < 0
						Break
					End
					WndProc.UserDataLongOut = c25_GetWindowLongA(_windowHandle, WndProc.T)
					Poke(Address(WinUserData)+ WndProc.T, WndProc.UserDataLongOut)
				End
				If WinUserData.ExtraWindowSpaceGuid = C25_ExtraWindowSpaceGuid
					If WinUserData.WindowHandlerClassPtr <> 0
						WindowHandlerWorker &= (WinUserData.WindowHandlerClassPtr)
					End
				End
			End
		End

		If WindowHandlerWorker &= NULL
			Return c25_DefWindowProcA(_windowHandle, _message, _wParam, _lParam)
		End
		Clear(WindowHandlerWorker.ReturnWndProc)
		Clear(ReturnWndProc)

		If _windowHandle = WindowHandlerWorker.WindowHandle
			WindowHandlerWorker.WndProc_Process(_windowHandle, _message, _wParam, _lParam)
			ReturnWndProc = WindowHandlerWorker.ReturnWndProc
		End
		WindowHandlerWorker &= Null
		If ReturnWndProc.Processed = 0
			Return c25_DefWindowProcA(_windowHandle, _message, _wParam, _lParam)
		Else
			Return ReturnWndProc.ReturnVal
		End

		Return c25_DefWindowProcA(_windowHandle, _message, _wParam, _lParam)


Include('c25_GetMessageNameFromId.clw')


