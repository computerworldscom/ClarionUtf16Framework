LoadSqlite3Dll          Function()

Sqlite3DllFilePathW 	string(1024)
Sqlite3DllFilePathA 	string(1024)
Sqlite3DllHandle 		LONG
ProcNameA 				cstring(128)

CODE


	Sqlite3DllFilePathA = 'sqlite3.dll' & Chr(0)
	Sqlite3DllHandle = C25_LoadLibraryA(Address(Sqlite3DllFilePathA))
    !Message('Sqlite3DllHandle ' & Sqlite3DllHandle)
        
	If Sqlite3DllHandle <> 0 And Sqlite3DllHandle <> -1 !and 1 > 2
		ProcNameA = 'sqlite3_open_v2'
        fp_sqlite3_open_v2                  = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA)) 
        !Message('fp_sqlite3_open_v2 ' & fp_sqlite3_open_v2)
		Clear(ProcNameA,-1)
		
		ProcNameA = 'sqlite3_hard_heap_limit64'
		fp_sqlite3_hard_heap_limit64        = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA)) 
		Clear(ProcNameA,-1)
		
		ProcNameA = 'sqlite3_soft_heap_limit64'
		fp_sqlite3_soft_heap_limit64        = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA)) 
		Clear(ProcNameA,-1)
		
		ProcNameA = 'sqlite3_bind_int'
		fp_sqlite3_bind_int                 = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
		Clear(ProcNameA,-1)

		ProcNameA = 'sqlite3_bind_int64'
		fp_sqlite3_bind_int64                 = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
		Clear(ProcNameA,-1)
		
		ProcNameA = 'sqlite3_bind_text'
		fp_sqlite3_bind_text                = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
		Clear(ProcNameA,-1)

		ProcNameA = 'sqlite3_bind_text16'
		fp_sqlite3_bind_text16                = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
		Clear(ProcNameA,-1)
        
		ProcNameA = 'sqlite3_clear_bindings'
		fp_sqlite3_clear_bindings           = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
		Clear(ProcNameA,-1)
		
		ProcNameA = 'sqlite3_close'
		fp_sqlite3_close                    = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
		Clear(ProcNameA,-1)

		ProcNameA = 'sqlite3_close_v2'
		fp_sqlite3_close_v2                 = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
		Clear(ProcNameA,-1)
				
		ProcNameA = 'sqlite3_column_bytes'
		fp_sqlite3_column_bytes             = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
		Clear(ProcNameA,-1)
		
		ProcNameA = 'sqlite3_column_count'
		fp_sqlite3_column_count             = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
		Clear(ProcNameA,-1)

		ProcNameA = 'sqlite3_column_name'
		fp_sqlite3_column_name              = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
        Clear(ProcNameA,-1)      
        
		ProcNameA = 'sqlite3_column_blob'
		fp_sqlite3_column_blob              = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
        Clear(ProcNameA,-1)
        
		ProcNameA = 'sqlite3_column_text'
		fp_sqlite3_column_text              = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
		Clear(ProcNameA,-1)
		
		ProcNameA = 'sqlite3_column_text16'
		fp_sqlite3_column_text16            = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
		Clear(ProcNameA,-1)
		
		ProcNameA = 'sqlite3_column_type'
		fp_sqlite3_column_type              = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
		Clear(ProcNameA,-1)
		
		ProcNameA = 'sqlite3_exec'
		fp_sqlite3_exec                     = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
		
		ProcNameA = 'sqlite3_finalize'
		fp_sqlite3_finalize                 = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
		Clear(ProcNameA,-1)
		
		ProcNameA = 'sqlite3_free'
		fp_sqlite3_free                     = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
		Clear(ProcNameA,-1)
		
		ProcNameA = 'sqlite3_prepare_v2'
		fp_sqlite3_prepare_v2               = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
		Clear(ProcNameA,-1)
		
		ProcNameA = 'sqlite3_reset'
		fp_sqlite3_reset                    = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
		Clear(ProcNameA,-1)
		
		ProcNameA = 'sqlite3_step'
		fp_sqlite3_step                     = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
		Clear(ProcNameA,-1)
		
		ProcNameA = 'sqlite3_bind_parameter_index'
		fp_sqlite3_bind_parameter_index     = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
		Clear(ProcNameA,-1)
		
		ProcNameA = 'sqlite3_bind_parameter_count'
		fp_sqlite3_bind_parameter_count     = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
		Clear(ProcNameA,-1)

		ProcNameA = 'sqlite3_bind_parameter_name'
		fp_sqlite3_bind_parameter_name     = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
		Clear(ProcNameA,-1)

		ProcNameA = 'sqlite3_column_int'
		fp_sqlite3_column_int               = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
		Clear(ProcNameA,-1)

		ProcNameA = 'sqlite3_column_int64'
		fp_sqlite3_column_int64             = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
		Clear(ProcNameA,-1)
		
		ProcNameA = 'sqlite3_bind_blob'
		fp_sqlite3_bind_blob                = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
		Clear(ProcNameA,-1)
		
		ProcNameA = 'sqlite3_bind_null'
		fp_sqlite3_bind_null                = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
		Clear(ProcNameA,-1)

		ProcNameA = 'sqlite3_last_insert_rowid'
		fp_sqlite3_last_insert_rowid        = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
		Clear(ProcNameA,-1)       

		ProcNameA = 'sqlite3_initialize'
		fp_sqlite3_initialize        = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
        Clear(ProcNameA,-1)       
        
 		ProcNameA = 'sqlite3_threadsafe'
		fp_sqlite3_threadsafe        = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
        Clear(ProcNameA,-1)    
        
  		ProcNameA = 'sqlite3_errcode'
		fp_sqlite3_errcode        = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
        Clear(ProcNameA,-1)   

  		ProcNameA = 'sqlite3_errmsg'
		fp_sqlite3_errmsg        = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
        Clear(ProcNameA,-1)   

  		ProcNameA = 'sqlite3_errmsg16'
		fp_sqlite3_errmsg16        = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
        Clear(ProcNameA,-1)   

  		ProcNameA = 'sqlite3_errstr'
		fp_sqlite3_errstr        = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
        Clear(ProcNameA,-1)   

  		ProcNameA = 'sqlite3_extended_errcode'
		fp_sqlite3_extended_errcode        = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
        Clear(ProcNameA,-1)   

  		ProcNameA = 'sqlite3_extended_result_codes'
		fp_sqlite3_extended_result_codes        = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
        Clear(ProcNameA,-1)   

  		ProcNameA = 'sqlite3_libversion'
		fp_sqlite3_libversion        = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
        Clear(ProcNameA,-1)   

  		ProcNameA = 'sqlite3_libversion_number'
		fp_sqlite3_libversion_number        = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
        Clear(ProcNameA,-1)   

  		ProcNameA = 'sqlite3_column_bytes16'
		fp_sqlite3_column_bytes16        = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
        Clear(ProcNameA,-1)  



  		ProcNameA = 'sqlite3_backup_finish'
		fp_sqlite3_backup_finish        = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
        Clear(ProcNameA,-1)  

  		ProcNameA = 'sqlite3_backup_init'
		fp_sqlite3_backup_init        = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
        Clear(ProcNameA,-1)  

  		ProcNameA = 'sqlite3_backup_pagecount'
		fp_sqlite3_backup_pagecount        = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
        Clear(ProcNameA,-1)  

  		ProcNameA = 'sqlite3_backup_remaining'
		fp_sqlite3_backup_remaining        = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
        Clear(ProcNameA,-1)  

  		ProcNameA = 'sqlite3_backup_step'
		fp_sqlite3_backup_step        = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
        Clear(ProcNameA,-1)  

  		ProcNameA = 'sqlite3_bind_zeroblob'
		fp_sqlite3_bind_zeroblob        = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
        Clear(ProcNameA,-1)  

  		ProcNameA = 'sqlite3_blob_bytes'
		fp_sqlite3_blob_bytes        = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
        Clear(ProcNameA,-1)  

  		ProcNameA = 'sqlite3_blob_close'
		fp_sqlite3_blob_close        = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
        Clear(ProcNameA,-1)  

  		ProcNameA = 'sqlite3_blob_open'
		fp_sqlite3_blob_open        = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
        Clear(ProcNameA,-1)  

  		ProcNameA = 'sqlite3_blob_read'
		fp_sqlite3_blob_read        = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
        Clear(ProcNameA,-1)  

  		ProcNameA = 'sqlite3_blob_reopen'
		fp_sqlite3_blob_reopen        = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
        Clear(ProcNameA,-1)  

  		ProcNameA = 'sqlite3_blob_write'
		fp_sqlite3_blob_write        = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
        Clear(ProcNameA,-1)  

  		ProcNameA = 'sqlite3_progress_handler'
		fp_sqlite3_progress_handler        = C25_GetProcAddress(Sqlite3DllHandle,Address(ProcNameA))
        Clear(ProcNameA,-1)          
        
	End

    
    
