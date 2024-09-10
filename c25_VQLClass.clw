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
        Include('c25_VQLClass.inc'),ONCE

VQLClass.Construct  Procedure()

    Code

        Self.St1                     &= NEW StringTheory()
        Self.CRLF                    = Chr(13) & Chr(10)
        Self.NanoSync               &= NEW NanoSyncClass()

VQLClass.Destruct              Procedure()

    Code

