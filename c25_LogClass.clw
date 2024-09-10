        Member

            Include('c25_LogClass.inc'),once

                        MAP
                            Include('c25_Prototypes_WinApi32.clw')
                            Include('i64.inc')

                            Module('c25_LogClass.clw')
                            End
                        End

LogClass.Construct                     Procedure()

    Code

        Self.CRLF               = Chr(13) & Chr(10)
        Self.LogLines           &= NEW LogLines_TYPE()
        Self.BytesHandler       &= NEW BytesHandlerClass()
        Self.st1                &= NEW StringTheory()
        Self.st1.Start()
        Self.stSend             &= NEW StringTheory()
        Self.stSend.Start()
        Self.LogPipeClient      &= Null
        Self.BytesHandler       &= NEW BytesHandlerClass()
        Self.LogLineQRef        &= NEW LogLines_TYPE()
        Self.LogPipeClient      &= NEW PipeClient()
        Self.LogPipeClient.debug = 0
        Self.LogPipeClient.displayErrors = 0
        Self.LogPipeClient.logErrors = 0

LogClass.Destruct                      Procedure()

    Code

LogClass.DisconnectAll      Procedure()

    Code

        Return ''

LogClass.WMC_LogLineQRec        Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam)

DATALEN                         Long
inData                              String(1024)
CRLF                                equate('<13><10>')

    Code

        If Self.LogPipeClient &= Null
        End
        If Self.LogPipeClientIsOpen = 0

            If Self.LogPipeClient.OpenPipe('\\.\pipe\AllMyDrivesLogServer',0)
                Self.LogPipeClient.SetPipeState(2)
                Self.LogPipeClientIsOpen = TRUE
                Self.Status = 'open success'
            Else
                Self.Status = 'failed open'
            End
        End
        If Self.LogPipeClientIsOpen

            If _lParam <> 0
                If Self.LogLineQRef &= NULL
                    Message('error Self.LogLineQRef is null')
                End
                Self.Clear_LogLineQ(Self.LogLineQRef)

                Self.stSend.Start()
                If Self.LogLineQRef &= NULL
                    Message('error Self.LogLineQRef is null')
                End
                Clear(Self.LogLineQRef)

                Self.BytesHandler.StringRefPtrToQueue(_lParam, Self.LogLineQRef, True)
                Get(Self.LogLineQRef,1)
                If Errorcode() <> 0
                    Return 0
                End

                Self.BytesHandler.QueueToJsonStringTheory(Self.stSend, Self.LogLineQRef)

                Clear(Self.Buffer65k)
                Self.Buffer65k = Self.stSend.GetValue()
                DATALEN = Self.stSend.Length()

                If Self.LogPipeClient.Write(Self.Buffer65k, DATALEN)

                    Self.LogPipeClient.ClosePipe()
                    Self.LogPipeClientIsOpen = 0
                Else
                End
            End
        End

        Return 0

LogClass.Clear_LogLineQ    Procedure(LogLines_TYPE _logLinesRecord)

    Code

        If _logLinesRecord &= NULL
            Return ''
        End

!        I# = 0
!        R# = Records(_logLinesRecord)
!        Loop R# Times
!            I# = I# + 1
!            Get(_logLinesRecord,I#)
!            If Errorcode() <> 0
!                BREAK
!            End
!            If not _logLinesRecord.Line &= null
!                Dispose(_logLinesRecord.Line)
!            End
!            Clear(_logLinesRecord)
!            Put(_logLinesRecord)
!        End
        Free(_logLinesRecord)

        Return ''

