        Member

        Include('c25_ClassStarter.inc'),Once

                    MAP
                        Include('CWUTIL.inc'),once
                        Include('i64.inc')
						Include('c25_WinApiPrototypes.inc')
                    End

c25_ClassStarter.Construct                       Procedure()

Code

   
    Self.RegMesStringA = 'CWM_GetPHPtr' & Chr(0)
    Self.CWM_GetPHPtr = c25_RegisterWindowMessageA(Address(Self.RegMesStringA))
    !Self.NanoClockClass &= NEW c25_NanoSyncClass()
    
c25_ClassStarter.Destruct                        Procedure()

Code

    !Dispose(Self.NanoClockClass)
    
c25_ClassStarter.Start                        Procedure(<string _info>)

ReturnVal            LONG

Code
    
    !Self.NanoClockClass.SetTimeOut(, 1)
    Loop 10 Times
        !ReturnVal = 0
        If c25_SendMessageTimeoutA(C25_HWND_BROADCAST , Self.CWM_GetPHPtr, 0, Address(ReturnVal), c25_SMTO_ABORTIFHUNG, 5000, 0) = TRUE
            If ReturnVal <> 0
                Break
            End
        End
!        If Self.NanoClockClass.IsTimeOut
!            Message('error timeout c25_ClassStarter.Start ' & _info)
!            BREAK
!        End
        !C25_Sleepex(20,0)
    End
    If ReturnVal = 0
        Message('error Ptr = 0, c25_ClassStarter.Start ' & _info)
    End
    Return ReturnVal