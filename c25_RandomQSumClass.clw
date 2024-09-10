                    Member()

            Include('c25_Sqlite3Class.inc'),once
            Include('c25_NanoSyncClass.inc'),once
            Include('c25_GdiPlusClass.inc'),once
            Include('c25_TrueReflectionClass.inc'),once
            Include('c25_WinApi32Class.inc'),once
            Include('c25_Equates_Graphics.clw'),once
            Include('windows.inc'),once
        Map
        End
        Include('c25_RandomQSumClass.inc'),ONCE

RandomQSumClass.Construct  Procedure()

    Code

        Self.Init()

RandomQSumClass.Destruct              Procedure()

    Code

RandomQSumClass.Init        Procedure()

    Code

        Self.CRLF                    = Chr(13) & Chr(10)
        Self.Clock                  &= NEW NanoSyncClass()
        Self.St1                     &= NEW StringTheory()
        Self.St1Log                 &= NEW StringTheory()

        Return 0

RandomQSumClass.Start       Procedure()

    Code

    Return 0

RandomQSumClass.Reset       Procedure()

    Code

    Return 0

RandomQSumClass.SetDefaults Procedure()

    Code

    Return 0

