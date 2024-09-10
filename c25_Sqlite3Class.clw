        Member()

    Include('c25_Sqlite3Class.inc'),once

            Map
                Include('c25_Prototypes_Sqlite3.clw')
                Include('i64.inc')
            End

Sqlite3Class.Construct                      Procedure()

    Code

Sqlite3Class.Destruct                       Procedure()

    Code

Sqlite3Class.Connect        Procedure(String _connString, <String _sqlOpenFlags>)
ConnHandle          Long

    Code

        Self.ConnectionString = 'm:\memapp.sqlite3' & Chr(0)

        Return ConnHandle

