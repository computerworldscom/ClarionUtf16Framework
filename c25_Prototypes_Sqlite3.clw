    module('sqlite3.dll')

        sqlite3_value_encoding(Long p1),Long,c,raw,dll(1),proc

        sqlite3_aggregate_context(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_aggregate_context(),void

        sqlite3_aggregate_count(Long p1),Long,c,raw,dll(1),proc ! sqlite3_aggregate_count(),SQLITE_DEPRECATED int

        sqlite3_auto_extension(Long p1),Long,c,raw,dll(1),proc ! sqlite3_auto_extension(),int

        sqlite3_autovacuum_pages(Long p1,Long p2,Long p3,Long p4,Long p5,Long p6,Long p7,Long p8),Long,c,raw,dll(1),proc ! sqlite3_autovacuum_pages(),int

        sqlite3_backup_finish(Long p1),Long,c,raw,dll(1),proc ! sqlite3_backup_finish(),int

        sqlite3_backup_init(Long p1,Long p2,Long p3,Long p4),Long,c,raw,dll(1),proc ! sqlite3_backup_init(),sqlite3_backup

        sqlite3_backup_pagecount(Long p1),Long,c,raw,dll(1),proc ! sqlite3_backup_pagecount(),int

        sqlite3_backup_remaining(Long p1),Long,c,raw,dll(1),proc ! sqlite3_backup_remaining(),int

        sqlite3_backup_step(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_backup_step(),int

        sqlite3_bind_blob(Long p1,Long p2,Long p3,Long p4,Long p5),Long,c,raw,dll(1),proc ! sqlite3_bind_blob(),int

        sqlite3_bind_blob64(Long p1,Long p2,Long p3,Long p4,Long p5),Long,c,raw,dll(1),proc ! sqlite3_bind_blob64(),int

        sqlite3_bind_double(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3_bind_double(),int

        sqlite3_bind_int(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3_bind_int(),int

        sqlite3_bind_int64(Long p1,Long p2,Long p3),String,c,raw,dll(1),proc ! sqlite3_bind_int64(),int

        sqlite3_bind_null(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_bind_null(),int

        sqlite3_bind_parameter_count(Long p1),Long,c,raw,dll(1),proc ! sqlite3_bind_parameter_count(),int

        sqlite3_bind_parameter_index(Long p1,String p2),Long,c,raw,dll(1),proc ! sqlite3_bind_parameter_index(),int

        sqlite3_bind_parameter_name(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_bind_parameter_name(),const char

        sqlite3_bind_pointer(Long p1,Long p2,Long p3,Long p4,Long p5),Long,c,raw,dll(1),proc ! sqlite3_bind_pointer(),int

        sqlite3_bind_text(Long p1,Long p2,Long p3,Long p4,Long p5),Long,c,raw,dll(1),proc ! sqlite3_bind_text(),int

        sqlite3_bind_text16(Long p1,Long p2,Long p3,Long p4,Long p5),Long,c,raw,dll(1),proc ! sqlite3_bind_text16(),int

        sqlite3_bind_text64(Long p1,Long p2,Long p3,REAL p4,Long p5,Long p6),Long,c,raw,dll(1),proc ! sqlite3_bind_text64(),int

        sqlite3_bind_value(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3_bind_value(),int

        sqlite3_bind_zeroblob(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3_bind_zeroblob(),int

        sqlite3_bind_zeroblob64(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3_bind_zeroblob64(),int

        sqlite3_blob_bytes(Long p1),Long,c,raw,dll(1),proc ! sqlite3_blob_bytes(),int

        sqlite3_blob_close(Long p1),Long,c,raw,dll(1),proc ! sqlite3_blob_close(),int

        sqlite3_blob_open(Long p1,Long p2,Long p3,Long p4,Long p5,Long p6,Long p7),Long,c,raw,dll(1),proc ! sqlite3_blob_open(),int

        sqlite3_blob_read(Long p1,Long p2,Long p3,Long p4),Long,c,raw,dll(1),proc ! sqlite3_blob_read(),int

        sqlite3_blob_reopen(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_blob_reopen(),int

        sqlite3_blob_write(Long p1,Long p2,Long p3,Long p4),Long,c,raw,dll(1),proc ! sqlite3_blob_write(),int

        sqlite3_busy_handler(Long p1,Long p2,Long p3,Long p4),Long,c,raw,dll(1),proc ! sqlite3_busy_handler(),int

        sqlite3_busy_timeout(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_busy_timeout(),int

        sqlite3_cancel_auto_extension(Long p1),Long,c,raw,dll(1),proc ! sqlite3_cancel_auto_extension(),int

        sqlite3changegroup_add(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3changegroup_add(),int

        sqlite3changegroup_add_strm(Long p1,Long p2,Long p3,Long p4,Long p5),Long,c,raw,dll(1),proc ! sqlite3changegroup_add_strm(),int

        sqlite3changegroup_delete(Long p1),Long,c,raw,dll(1),proc ! sqlite3changegroup_delete(),void

        sqlite3changegroup_new(Long p1),Long,c,raw,dll(1),proc ! sqlite3changegroup_new(),int

        sqlite3changegroup_output(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3changegroup_output(),int

        sqlite3changegroup_output_strm(Long p1,Long p2,Long p3,Long p4,Long p5),Long,c,raw,dll(1),proc ! sqlite3changegroup_output_strm(),int

        sqlite3_changes(Long p1),Long,c,raw,dll(1),proc ! sqlite3_changes(),int

        sqlite3_changes64(Long p1),REAL,c,raw,dll(1),proc ! sqlite3_changes64(),sqlite3_int64

        sqlite3changeset_apply(Long p1,Long p2,Long p3,Long p4,Long p5,Long p6,Long p7,Long p8,Long p9),Long,c,raw,dll(1),proc ! sqlite3changeset_apply(),int

        sqlite3changeset_apply_strm(Long p1,Long p2,Long p3,Long p4,Long p5,Long p6,Long p7,Long p8,Long p9,Long p10,Long p11),Long,c,raw,dll(1),proc ! sqlite3changeset_apply_strm(),int

        sqlite3changeset_apply_v2(Long p1,Long p2,Long p3,Long p4,Long p5,Long p6,Long p7,Long p8,Long p9,Long p10,Long p11,Long p12),Long,c,raw,dll(1),proc ! sqlite3changeset_apply_v2(),int

        sqlite3changeset_apply_v2_strm(Long p1,Long p2,Long p3,Long p4,Long p5,Long p6,Long p7,Long p8,Long p9,Long p10,Long p11,Long p12,Long p13,Long p14),Long,c,raw,dll(1),proc ! sqlite3changeset_apply_v2_strm(),int

        sqlite3changeset_concat(Long p1,Long p2,Long p3,Long p4,Long p5,Long p6),Long,c,raw,dll(1),proc ! sqlite3changeset_concat(),int

        sqlite3changeset_concat_strm(Long p1,Long p2,Long p3,Long p4,Long p5,Long p6,Long p7,Long p8,Long p9,Long p10,Long p11,Long p12),Long,c,raw,dll(1),proc ! sqlite3changeset_concat_strm(),int

        sqlite3changeset_conflict(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3changeset_conflict(),int

        sqlite3changeset_finalize(Long p1),Long,c,raw,dll(1),proc ! sqlite3changeset_finalize(),int

        sqlite3changeset_fk_conflicts(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3changeset_fk_conflicts(),int

        sqlite3changeset_invert(Long p1,Long p2,Long p3,Long p4),Long,c,raw,dll(1),proc ! sqlite3changeset_invert(),int

        sqlite3changeset_invert_strm(Long p1,Long p2,Long p3,Long p4,Long p5,Long p6,Long p7,Long p8),Long,c,raw,dll(1),proc ! sqlite3changeset_invert_strm(),int

        sqlite3changeset_new(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3changeset_new(),int

        sqlite3changeset_next(Long p1),Long,c,raw,dll(1),proc ! sqlite3changeset_next(),int

        sqlite3changeset_old(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3changeset_old(),int

        sqlite3changeset_op(Long p1,Long p2,Long p3,Long p4,Long p5),Long,c,raw,dll(1),proc ! sqlite3changeset_op(),int

        sqlite3changeset_pk(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3changeset_pk(),int

        sqlite3changeset_start(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3changeset_start(),int

        sqlite3changeset_start_strm(Long p1,Long p2,Long p3,Long p4,Long p5),Long,c,raw,dll(1),proc ! sqlite3changeset_start_strm(),int

        sqlite3changeset_start_v2(Long p1,Long p2,Long p3,Long p4),Long,c,raw,dll(1),proc ! sqlite3changeset_start_v2(),int

        sqlite3changeset_start_v2_strm(Long p1,Long p2,Long p3,Long p4,Long p5,Long p6),Long,c,raw,dll(1),proc ! sqlite3changeset_start_v2_strm(),int

        sqlite3_clear_bindings(Long p1),Long,c,raw,dll(1),proc ! sqlite3_clear_bindings(),int

        sqlite3_close(Long p1),Long,c,raw,dll(1),proc ! sqlite3_close(),int

        sqlite3_close_v2(Long p1),Long,c,raw,dll(1),proc ! sqlite3_close_v2(),int

        sqlite3_collation_needed(Long p1,Long p2,Long p3,Long p4,Long p5,Long p6),Long,c,raw,dll(1),proc ! sqlite3_collation_needed(),int

        sqlite3_collation_needed16(Long p1,Long p2,Long p3,Long p4,Long p5,Long p6),Long,c,raw,dll(1),proc ! sqlite3_collation_needed16(),int

        sqlite3_column_blob(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_column_blob(),const void

        sqlite3_column_bytes(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_column_bytes(),int

        sqlite3_column_bytes16(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_column_bytes16(),int

        sqlite3_column_count(Long p1),Long,c,raw,dll(1),proc ! sqlite3_column_count(),int

        sqlite3_column_database_name(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_column_database_name(),const char

        sqlite3_column_database_name16(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_column_database_name16(),const void

        sqlite3_column_decltype(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_column_decltype(),const char

        sqlite3_column_decltype16(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_column_decltype16(),const void

        sqlite3_column_double(Long p1,Long p2),REAL,c,raw,dll(1),proc ! sqlite3_column_double(),double

        sqlite3_column_int(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_column_int(),int

        sqlite3_column_int64(Long p1,Long p2),REAL,c,raw,dll(1),proc ! sqlite3_column_int64(),sqlite3_int64

        sqlite3_column_name(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_column_name(),const char

        sqlite3_column_name16(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_column_name16(),const void

        sqlite3_column_origin_name(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_column_origin_name(),const char

        sqlite3_column_origin_name16(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_column_origin_name16(),const void

        sqlite3_column_table_name(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_column_table_name(),const char

        sqlite3_column_table_name16(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_column_table_name16(),const void

        sqlite3_column_text(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_column_text(),const unsigned char

        sqlite3_column_text16(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_column_text16(),const void

        sqlite3_column_type(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_column_type(),int

        sqlite3_column_value(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_column_value(),sqlite3_value

        sqlite3_commit_hook(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3_commit_hook(),void

        sqlite3_compileoption_get(Long p1),Long,c,raw,dll(1),proc ! sqlite3_compileoption_get(),const char

        sqlite3_compileoption_used(Long p1),Long,c,raw,dll(1),proc ! sqlite3_compileoption_used(),int

        sqlite3_complete(Long p1),Long,c,raw,dll(1),proc ! sqlite3_complete(),int

        sqlite3_complete16(Long p1),Long,c,raw,dll(1),proc ! sqlite3_complete16(),int

        sqlite3_config(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_config(),int

        sqlite3_context_db_handle(Long p1),Long,c,raw,dll(1),proc ! sqlite3_context_db_handle(),sqlite3

        sqlite3_create_collation(Long p1,Long p2,Long p3,Long p4,Long p5,Long p6,Long p7,Long p8,Long p9),Long,c,raw,dll(1),proc ! sqlite3_create_collation(),int

        sqlite3_create_collation16(Long p1,Long p2,Long p3,Long p4,Long p5,Long p6,Long p7,Long p8,Long p9),Long,c,raw,dll(1),proc ! sqlite3_create_collation16(),int

        sqlite3_create_collation_v2(Long p1,Long p2,Long p3,Long p4,Long p5,Long p6,Long p7,Long p8,Long p9,Long p10),Long,c,raw,dll(1),proc ! sqlite3_create_collation_v2(),int

        sqlite3_create_filename(Long p1,Long p2,Long p3,Long p4,Long p5),Long,c,raw,dll(1),proc ! sqlite3_create_filename(),char

        sqlite3_create_function(Long p1,Long p2,Long p3,Long p4,Long p5,Long p6,Long p7,Long p8,Long p9,Long p10,Long p11,Long p12),Long,c,raw,dll(1),proc ! sqlite3_create_function(),int

        sqlite3_create_function16(Long p1,Long p2,Long p3,Long p4,Long p5,Long p6,Long p7,Long p8,Long p9,Long p10,Long p11,Long p12),Long,c,raw,dll(1),proc ! sqlite3_create_function16(),int

        sqlite3_create_function_v2(Long p1,Long p2,Long p3,Long p4,Long p5,Long p6,Long p7,Long p8,Long p9,Long p10,Long p11,Long p12,Long p13),Long,c,raw,dll(1),proc ! sqlite3_create_function_v2(),int

        sqlite3_create_module(Long p1,Long p2,Long p3,Long p4),Long,c,raw,dll(1),proc ! sqlite3_create_module(),int

        sqlite3_create_module_v2(Long p1,Long p2,Long p3,Long p4,Long p5),Long,c,raw,dll(1),proc ! sqlite3_create_module_v2(),int

        sqlite3_create_window_function(Long p1,Long p2,Long p3,Long p4,Long p5,Long p6,Long p7,Long p8,Long p9,Long p10,Long p11,Long p12,Long p13,Long p14),Long,c,raw,dll(1),proc ! sqlite3_create_window_function(),int

        sqlite3_database_file_object(Long p1),Long,c,raw,dll(1),proc ! sqlite3_database_file_object(),sqlite3_file

        sqlite3_data_count(Long p1),Long,c,raw,dll(1),proc ! sqlite3_data_count(),int

        sqlite3_db_cacheflush(Long p1),Long,c,raw,dll(1),proc ! sqlite3_db_cacheflush(),int

        sqlite3_db_config(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3_db_config(),int

        sqlite3_db_filename(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_db_filename(),const char

        sqlite3_db_handle(Long p1),Long,c,raw,dll(1),proc ! sqlite3_db_handle(),sqlite3

        sqlite3_db_mutex(Long p1),Long,c,raw,dll(1),proc ! sqlite3_db_mutex(),sqlite3_mutex

        sqlite3_db_name(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_db_name(),const char

        sqlite3_db_readonly(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_db_readonly(),int

        sqlite3_db_release_memory(Long p1),Long,c,raw,dll(1),proc ! sqlite3_db_release_memory(),int

        sqlite3_db_status(Long p1,Long p2,Long p3,Long p4,Long p5),Long,c,raw,dll(1),proc ! sqlite3_db_status(),int

        sqlite3_declare_vtab(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_declare_vtab(),int

        sqlite3_deserialize(Long p1,Long p2,Long p3,Long p4,Long p5,Long p6),Long,c,raw,dll(1),proc ! sqlite3_deserialize(),int

        sqlite3_drop_modules(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_drop_modules(),int

        sqlite3_enable_load_extension(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_enable_load_extension(),int

        sqlite3_enable_shared_cache(Long p1),Long,c,raw,dll(1),proc ! sqlite3_enable_shared_cache(),int

        sqlite3_errcode(Long p1),Long,c,raw,dll(1),proc ! sqlite3_errcode(),int

        sqlite3_errmsg(Long p1),Long,c,raw,dll(1),proc ! sqlite3_errmsg(),const char

        sqlite3_errmsg16(Long p1),Long,c,raw,dll(1),proc ! sqlite3_errmsg16(),const void

        sqlite3_error_offset(Long p1),Long,c,raw,dll(1),proc ! sqlite3_error_offset(),int

        sqlite3_errstr(Long p1),Long,c,raw,dll(1),proc ! sqlite3_errstr(),const char

        sqlite3_exec(Long p1,Long p2,Long p3,Long p4,Long p5),Long,c,raw,dll(1),proc ! sqlite3_exec(sqlite3*, const char *sql, int (*callback)(void*-int-char**-char**), void *, char **errmsg),int

        sqlite3_expanded_sql(Long p1),Long,c,raw,dll(1),proc ! sqlite3_expanded_sql(),char

        sqlite3_expired(Long p1),Long,c,raw,dll(1),proc ! sqlite3_expired(),SQLITE_DEPRECATED int

        sqlite3_extended_errcode(Long p1),Long,c,raw,dll(1),proc ! sqlite3_extended_errcode(),int

        sqlite3_extended_result_codes(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_extended_result_codes(),int

        sqlite3_file_control(Long p1,Long p2,Long p3,Long p4),Long,c,raw,dll(1),proc ! sqlite3_file_control(),int

        sqlite3_filename_database(Long p1),Long,c,raw,dll(1),proc ! sqlite3_filename_database(),const char

        sqlite3_filename_journal(Long p1),Long,c,raw,dll(1),proc ! sqlite3_filename_journal(),const char

        sqlite3_filename_wal(Long p1),Long,c,raw,dll(1),proc ! sqlite3_filename_wal(),const char

        sqlite3_finalize(Long p1),Long,c,raw,dll(1),proc ! sqlite3_finalize(),int

        sqlite3_free(Long p1),Long,c,raw,dll(1),proc ! sqlite3_free(),void

        sqlite3_free_filename(Long p1),Long,c,raw,dll(1),proc ! sqlite3_free_filename(),void

        sqlite3_free_table(Long p1),Long,c,raw,dll(1),proc ! sqlite3_free_table(),void

        sqlite3_get_autocommit(Long p1),Long,c,raw,dll(1),proc ! sqlite3_get_autocommit(),int

        sqlite3_get_auxdata(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_get_auxdata(),void

        sqlite3_get_table(Long p1,Long p2,Long p3,Long p4,Long p5,Long p6),Long,c,raw,dll(1),proc ! sqlite3_get_table(),int

        sqlite3_global_recover(),Long,c,raw,dll(1),proc ! sqlite3_global_recover(),SQLITE_DEPRECATED int

        sqlite3_hard_heap_limit64(Long p1),REAL,c,raw,dll(1),proc ! sqlite3_hard_heap_limit64(),sqlite3_int64

        sqlite3_initialize(),Long,c,raw,dll(1),proc ! sqlite3_initialize(),int

        sqlite3_interrupt(Long p1),Long,c,raw,dll(1),proc ! sqlite3_interrupt(),void

        sqlite3_keyword_check(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_keyword_check(),int

        sqlite3_keyword_count(),Long,c,raw,dll(1),proc ! sqlite3_keyword_count(),int

        sqlite3_keyword_name(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3_keyword_name(),int

        sqlite3_last_insert_rowid(Long p1),Long,c,raw,dll(1),proc ! sqlite3_last_insert_rowid(),sqlite3_int64

        sqlite3_libversion(),Long,c,raw,dll(1),proc ! sqlite3_libversion(),const char

        sqlite3_libversion_number(),Long,c,raw,dll(1),proc ! sqlite3_libversion_number(),int

        sqlite3_limit(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3_limit(),int

        sqlite3_load_extension(Long p1,Long p2,Long p3,Long p4),Long,c,raw,dll(1),proc ! sqlite3_load_extension(),int

        sqlite3_log(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3_log(),void

        sqlite3_malloc(Long p1),Long,c,raw,dll(1),proc ! sqlite3_malloc(),void

        sqlite3_malloc64(Long p1),Long,c,raw,dll(1),proc ! sqlite3_malloc64(),void

        sqlite3_memory_alarm(Long p1,Long p2,Long p3,Long p4,Long p5),Long,c,raw,dll(1),proc ! sqlite3_memory_alarm(),SQLITE_DEPRECATED int

        sqlite3_memory_highwater(Long p1),REAL,c,raw,dll(1),proc ! sqlite3_memory_highwater(),sqlite3_int64

        sqlite3_memory_used(),REAL,c,raw,dll(1),proc ! sqlite3_memory_used(),sqlite3_int64

        sqlite3_mprintf(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_mprintf(),char

        sqlite3_msize(Long p1),Long,c,raw,dll(1),proc ! sqlite3_msize(),sqlite3_uint64

        sqlite3_mutex_alloc(Long p1),Long,c,raw,dll(1),proc ! sqlite3_mutex_alloc(),sqlite3_mutex

        sqlite3_mutex_enter(Long p1),Long,c,raw,dll(1),proc ! sqlite3_mutex_enter(),void

        sqlite3_mutex_free(Long p1),Long,c,raw,dll(1),proc ! sqlite3_mutex_free(),void

        sqlite3_mutex_leave(Long p1),Long,c,raw,dll(1),proc ! sqlite3_mutex_leave(),void

        sqlite3_mutex_try(Long p1),Long,c,raw,dll(1),proc ! sqlite3_mutex_try(),int

        sqlite3_next_stmt(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_next_stmt(),sqlite3_stmt

        sqlite3_open(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_open(),int

        sqlite3_open16(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_open16(),int

        sqlite3_open_v2(Long p1,Long p2,Long p3,Long p4),Long,c,raw,dll(1),proc ! sqlite3_open_v2(),int

        sqlite3_os_end(),Long,c,raw,dll(1),proc ! sqlite3_os_end(),int

        sqlite3_os_init(),Long,c,raw,dll(1),proc ! sqlite3_os_init(),int

        sqlite3_overload_function(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3_overload_function(),int

        sqlite3_prepare(Long p1,Long p2,Long p3,Long p4,Long p5),Long,c,raw,dll(1),proc ! sqlite3_prepare(),int

        sqlite3_prepare16(Long p1,Long p2,Long p3,Long p4,Long p5),Long,c,raw,dll(1),proc ! sqlite3_prepare16(),int

        sqlite3_prepare16_v2(Long p1,Long p2,Long p3,Long p4,Long p5),Long,c,raw,dll(1),proc ! sqlite3_prepare16_v2(),int

        sqlite3_prepare16_v3(Long p1,Long p2,Long p3,Long p4,Long p5,Long p6),Long,c,raw,dll(1),proc ! sqlite3_prepare16_v3(),int

        sqlite3_prepare_v2(Long p1,Long p2,Long p3,Long p4,Long p5),Long,c,raw,dll(1),proc ! sqlite3_prepare_v2(),int

        sqlite3_prepare_v3(Long p1,Long p2,Long p3,Long p4,Long p5,Long p6),Long,c,raw,dll(1),proc ! sqlite3_prepare_v3(),int

        sqlite3_preupdate_blobwrite(Long p1),Long,c,raw,dll(1),proc ! sqlite3_preupdate_blobwrite(),int

        sqlite3_preupdate_count(Long p1),Long,c,raw,dll(1),proc ! sqlite3_preupdate_count(),int

        sqlite3_preupdate_depth(Long p1),Long,c,raw,dll(1),proc ! sqlite3_preupdate_depth(),int

        sqlite3_preupdate_hook(Long p1,Long p2,Long p3,Long p4,Long p5,Long p6,Long p7,Long p8,Long p9),Long,c,raw,dll(1),proc ! sqlite3_preupdate_hook(),void

        sqlite3_preupdate_new(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3_preupdate_new(),int

        sqlite3_preupdate_old(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3_preupdate_old(),int

        sqlite3_profile(Long p1,Long p2,Long p3,Long p4,Long p5),Long,c,raw,dll(1),proc ! sqlite3_profile(),SQLITE_DEPRECATED void

        sqlite3_progress_handler(Long p1,Long p2,Long p3,Long p4),Long,c,raw,dll(1),proc ! sqlite3_progress_handler(),void

        sqlite3_randomness(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_randomness(),void

        sqlite3_realloc(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_realloc(),void

        sqlite3_realloc64(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_realloc64(),void

        sqlite3rebaser_configure(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3rebaser_configure(),int

        sqlite3rebaser_create(Long p1),Long,c,raw,dll(1),proc ! sqlite3rebaser_create(),int

        sqlite3rebaser_delete(Long p1),Long,c,raw,dll(1),proc ! sqlite3rebaser_delete(),void

        sqlite3rebaser_rebase(Long p1,Long p2,Long p3,Long p4,Long p5),Long,c,raw,dll(1),proc ! sqlite3rebaser_rebase(),int

        sqlite3rebaser_rebase_strm(Long p1,Long p2,Long p3,Long p4,Long p5,Long p6,Long p7,Long p8,Long p9),Long,c,raw,dll(1),proc ! sqlite3rebaser_rebase_strm(),int

        sqlite3_release_memory(Long p1),Long,c,raw,dll(1),proc ! sqlite3_release_memory(),int

        sqlite3_reset(Long p1),Long,c,raw,dll(1),proc ! sqlite3_reset(),int

        sqlite3_reset_auto_extension(),Long,c,raw,dll(1),proc ! sqlite3_reset_auto_extension(),void

        sqlite3_result_blob(Long p1,Long p2,Long p3,Long p4),Long,c,raw,dll(1),proc ! sqlite3_result_blob(),void

        sqlite3_result_blob64(Long p1,Long p2,Long p3,Long p4),Long,c,raw,dll(1),proc ! sqlite3_result_blob64(),void

        sqlite3_result_double(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_result_double(),void

        sqlite3_result_error(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3_result_error(),void

        sqlite3_result_error16(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3_result_error16(),void

        sqlite3_result_error_code(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_result_error_code(),void

        sqlite3_result_error_nomem(Long p1),Long,c,raw,dll(1),proc ! sqlite3_result_error_nomem(),void

        sqlite3_result_error_toobig(Long p1),Long,c,raw,dll(1),proc ! sqlite3_result_error_toobig(),void

        sqlite3_result_int(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_result_int(),void

        sqlite3_result_int64(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_result_int64(),void

        sqlite3_result_null(Long p1),Long,c,raw,dll(1),proc ! sqlite3_result_null(),void

        sqlite3_result_pointer(Long p1,Long p2,Long p3,Long p4),Long,c,raw,dll(1),proc ! sqlite3_result_pointer(),void

        sqlite3_result_subtype(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_result_subtype(),void

        sqlite3_result_text(Long p1,Long p2,Long p3,Long p4),Long,c,raw,dll(1),proc ! sqlite3_result_text(),void

        sqlite3_result_text16(Long p1,Long p2,Long p3,Long p4),Long,c,raw,dll(1),proc ! sqlite3_result_text16(),void

        sqlite3_result_text16be(Long p1,Long p2,Long p3,Long p4),Long,c,raw,dll(1),proc ! sqlite3_result_text16be(),void

        sqlite3_result_text16le(Long p1,Long p2,Long p3,Long p4),Long,c,raw,dll(1),proc ! sqlite3_result_text16le(),void

        sqlite3_result_text64(Long p1,Long p2,Long p3,Long p4,Long p5),Long,c,raw,dll(1),proc ! sqlite3_result_text64(),void

        sqlite3_result_value(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_result_value(),void

        sqlite3_result_zeroblob(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_result_zeroblob(),void

        sqlite3_result_zeroblob64(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_result_zeroblob64(),int

        sqlite3_rollback_hook(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3_rollback_hook(),void

        sqlite3_rtree_geometry_callback(Long p1,Long p2,Long p3,Long p4,Long p5,Long p6,Long p7),Long,c,raw,dll(1),proc ! sqlite3_rtree_geometry_callback(),int

        sqlite3_rtree_query_callback(Long p1,Long p2,Long p3,Long p4,Long p5),Long,c,raw,dll(1),proc ! sqlite3_rtree_query_callback(),int

        sqlite3_serialize(Long p1,Long p2,Long p3,Long p4),Long,c,raw,dll(1),proc ! sqlite3_serialize(),unsigned char

        sqlite3session_attach(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3session_attach(),int

        sqlite3session_changeset(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3session_changeset(),int

        sqlite3session_changeset_size(Long p1),REAL,c,raw,dll(1),proc ! sqlite3session_changeset_size(),sqlite3_int64

        sqlite3session_changeset_strm(Long p1,Long p2,Long p3,Long p4,Long p5),Long,c,raw,dll(1),proc ! sqlite3session_changeset_strm(),int

        sqlite3session_config(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3session_config(),int

        sqlite3session_create(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3session_create(),int

        sqlite3session_delete(Long p1),Long,c,raw,dll(1),proc ! sqlite3session_delete(),void

        sqlite3session_diff(Long p1,Long p2,Long p3,Long p4),Long,c,raw,dll(1),proc ! sqlite3session_diff(),int

        sqlite3session_enable(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3session_enable(),int

        sqlite3session_indirect(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3session_indirect(),int

        sqlite3session_isempty(Long p1),Long,c,raw,dll(1),proc ! sqlite3session_isempty(),int

        sqlite3session_memory_used(Long p1),REAL,c,raw,dll(1),proc ! sqlite3session_memory_used(),sqlite3_int64

        sqlite3session_object_config(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3session_object_config(),int

        sqlite3session_patchset(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3session_patchset(),int

        sqlite3session_patchset_strm(Long p1,Long p2,Long p3,Long p4,Long p5),Long,c,raw,dll(1),proc ! sqlite3session_patchset_strm(),int

        sqlite3session_table_filter(Long p1,Long p2,Long p3,Long p4),Long,c,raw,dll(1),proc ! sqlite3session_table_filter(),void

        sqlite3_set_authorizer(Long p1,Long p2,Long p3,Long p4,Long p5,Long p6,Long p7,Long p8),Long,c,raw,dll(1),proc ! sqlite3_set_authorizer(),int

        sqlite3_set_auxdata(Long p1,Long p2,Long p3,Long p4),Long,c,raw,dll(1),proc ! sqlite3_set_auxdata(),void

        sqlite3_set_last_insert_rowid(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_set_last_insert_rowid(),void

        sqlite3_shutdown(),Long,c,raw,dll(1),proc ! sqlite3_shutdown(),int

        sqlite3_sleep(Long p1),Long,c,raw,dll(1),proc ! sqlite3_sleep(),int

        sqlite3_snprintf(Long p1,Long p2,Long p3,Long p4),Long,c,raw,dll(1),proc ! sqlite3_snprintf(),char

        sqlite3_soft_heap_limit(Long p1),Long,c,raw,dll(1),proc ! sqlite3_soft_heap_limit(),SQLITE_DEPRECATED void

        sqlite3_soft_heap_limit64(Long p1),REAL,c,raw,dll(1),proc ! sqlite3_soft_heap_limit64(),sqlite3_int64

        sqlite3_sourceid(),Long,c,raw,dll(1),proc ! sqlite3_sourceid(),const char

        sqlite3_sql(Long p1),Long,c,raw,dll(1),proc ! sqlite3_sql(),const char

        sqlite3_status(Long p1,Long p2,Long p3,Long p4),Long,c,raw,dll(1),proc ! sqlite3_status(),int

        sqlite3_status64(Long p1,Long p2,Long p3,Long p4),Long,c,raw,dll(1),proc ! sqlite3_status64(),int

        sqlite3_step(Long p1),Long,c,raw,dll(1),proc ! sqlite3_step(),int

        sqlite3_stmt_busy(Long p1),Long,c,raw,dll(1),proc ! sqlite3_stmt_busy(),int

        sqlite3_stmt_isexplain(Long p1),Long,c,raw,dll(1),proc ! sqlite3_stmt_isexplain(),int

        sqlite3_stmt_readonly(Long p1),Long,c,raw,dll(1),proc ! sqlite3_stmt_readonly(),int

        sqlite3_stmt_status(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3_stmt_status(),int

        sqlite3_str_append(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3_str_append(),void

        sqlite3_str_appendall(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_str_appendall(),void

        sqlite3_str_appendchar(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3_str_appendchar(),void

        sqlite3_str_appendf(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3_str_appendf(),void

        sqlite3_str_errcode(Long p1),Long,c,raw,dll(1),proc ! sqlite3_str_errcode(),int

        sqlite3_str_finish(Long p1),Long,c,raw,dll(1),proc ! sqlite3_str_finish(),char

        sqlite3_strglob(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_strglob(),int

        sqlite3_stricmp(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_stricmp(),int

        sqlite3_str_length(Long p1),Long,c,raw,dll(1),proc ! sqlite3_str_length(),int

        sqlite3_strlike(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3_strlike(),int

        sqlite3_str_new(Long p1),Long,c,raw,dll(1),proc ! sqlite3_str_new(),sqlite3_str

        sqlite3_strnicmp(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3_strnicmp(),int

        sqlite3_str_reset(Long p1),Long,c,raw,dll(1),proc ! sqlite3_str_reset(),void

        sqlite3_str_value(Long p1),Long,c,raw,dll(1),proc ! sqlite3_str_value(),char

        sqlite3_str_vappendf(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3_str_vappendf(),void

        sqlite3_system_errno(Long p1),Long,c,raw,dll(1),proc ! sqlite3_system_errno(),int

        sqlite3_table_column_metadata(Long p1,Long p2,Long p3,Long p4,Long p5,Long p6,Long p7,Long p8,Long p9),Long,c,raw,dll(1),proc ! sqlite3_table_column_metadata(),int

        sqlite3_test_control(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_test_control(),int

        sqlite3_thread_cleanup(),Long,c,raw,dll(1),proc ! sqlite3_thread_cleanup(),SQLITE_DEPRECATED void

        sqlite3_threadsafe(),Long,c,raw,dll(1),proc ! sqlite3_threadsafe(),int

        sqlite3_total_changes(Long p1),Long,c,raw,dll(1),proc ! sqlite3_total_changes(),int

        sqlite3_total_changes64(Long p1),REAL,c,raw,dll(1),proc ! sqlite3_total_changes64(),sqlite3_int64

        sqlite3_trace(Long p1,Long p2,Long p3,Long p4),Long,c,raw,dll(1),proc ! sqlite3_trace(),SQLITE_DEPRECATED void

        sqlite3_trace_v2(Long p1,Long p2,Long p3,Long p4,Long p5,Long p6,Long p7),Long,c,raw,dll(1),proc ! sqlite3_trace_v2(),int

        sqlite3_transfer_bindings(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_transfer_bindings(),SQLITE_DEPRECATED int

        sqlite3_txn_state(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_txn_state(),int

        sqlite3_update_hook(Long p1,Long p2,Long p3,Long p4,Long p5,Long p6,Long p7),Long,c,raw,dll(1),proc ! sqlite3_update_hook(),void

        sqlite3_uri_boolean(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3_uri_boolean(),int

        sqlite3_uri_int64(Long p1,Long p2,Long p3),REAL,c,raw,dll(1),proc ! sqlite3_uri_int64(),sqlite3_int64

        sqlite3_uri_key(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_uri_key(),const char

        sqlite3_uri_parameter(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_uri_parameter(),const char

        sqlite3_user_data(Long p1),Long,c,raw,dll(1),proc ! sqlite3_user_data(),void

        sqlite3_value_blob(Long p1),Long,c,raw,dll(1),proc ! sqlite3_value_blob(),const void

        sqlite3_value_bytes(Long p1),Long,c,raw,dll(1),proc ! sqlite3_value_bytes(),int

        sqlite3_value_bytes16(Long p1),Long,c,raw,dll(1),proc ! sqlite3_value_bytes16(),int

        sqlite3_value_double(Long p1),REAL,c,raw,dll(1),proc ! sqlite3_value_double(),double

        sqlite3_value_dup(Long p1),Long,c,raw,dll(1),proc ! sqlite3_value_dup(),sqlite3_value

        sqlite3_value_free(Long p1),Long,c,raw,dll(1),proc ! sqlite3_value_free(),void

        sqlite3_value_frombind(Long p1),Long,c,raw,dll(1),proc ! sqlite3_value_frombind(),int

        sqlite3_value_int(Long p1),Long,c,raw,dll(1),proc ! sqlite3_value_int(),int

        sqlite3_value_int64(Long p1),REAL,c,raw,dll(1),proc ! sqlite3_value_int64(),sqlite3_int64

        sqlite3_value_nochange(Long p1),Long,c,raw,dll(1),proc ! sqlite3_value_nochange(),int

        sqlite3_value_numeric_type(Long p1),Long,c,raw,dll(1),proc ! sqlite3_value_numeric_type(),int

        sqlite3_value_pointer(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_value_pointer(),void

        sqlite3_value_subtype(Long p1),Long,c,raw,dll(1),proc ! sqlite3_value_subtype(),unsigned int

        sqlite3_value_text(Long p1),Long,c,raw,dll(1),proc ! sqlite3_value_text(),const unsigned char

        sqlite3_value_text16(Long p1),Long,c,raw,dll(1),proc ! sqlite3_value_text16(),const void

        sqlite3_value_text16be(Long p1),Long,c,raw,dll(1),proc ! sqlite3_value_text16be(),const void

        sqlite3_value_text16le(Long p1),Long,c,raw,dll(1),proc ! sqlite3_value_text16le(),const void

        sqlite3_value_type(Long p1),Long,c,raw,dll(1),proc ! sqlite3_value_type(),int

        sqlite3_vfs_find(Long p1),Long,c,raw,dll(1),proc ! sqlite3_vfs_find(),sqlite3_vfs

        sqlite3_vfs_register(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_vfs_register(),int

        sqlite3_vfs_unregister(Long p1),Long,c,raw,dll(1),proc ! sqlite3_vfs_unregister(),int

        sqlite3_vmprintf(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_vmprintf(),char

        sqlite3_vsnprintf(Long p1,Long p2,Long p3,Long p4),Long,c,raw,dll(1),proc ! sqlite3_vsnprintf(),char

        sqlite3_vtab_collation(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_vtab_collation(),SQLITE_EXPERIMENTAL const char

        sqlite3_vtab_config(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3_vtab_config(),int

        sqlite3_vtab_distinct(Long p1),Long,c,raw,dll(1),proc ! sqlite3_vtab_distinct(),int

        sqlite3_vtab_in(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3_vtab_in(),int

        sqlite3_vtab_in_first(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_vtab_in_first(),int

        sqlite3_vtab_in_next(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_vtab_in_next(),int

        sqlite3_vtab_nochange(Long p1),Long,c,raw,dll(1),proc ! sqlite3_vtab_nochange(),int

        sqlite3_vtab_on_conflict(Long p1),Long,c,raw,dll(1),proc ! sqlite3_vtab_on_conflict(),int

        sqlite3_vtab_rhs_value(Long p1,Long p2,Long p3),Long,c,raw,dll(1),proc ! sqlite3_vtab_rhs_value(),int

        sqlite3_wal_autocheckpoint(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_wal_autocheckpoint(),int

        sqlite3_wal_checkpoint(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_wal_checkpoint(),int

        sqlite3_wal_checkpoint_v2(Long p1,Long p2,Long p3,Long p4,Long p5),Long,c,raw,dll(1),proc ! sqlite3_wal_checkpoint_v2(),int

        sqlite3_wal_hook(Long p1,Long p2,Long p3,Long p4,Long p5,Long p6),Long,c,raw,dll(1),proc ! sqlite3_wal_hook(),void

        sqlite3_win32_is_nt(),Long,c,raw,dll(1),proc ! sqlite3_win32_is_nt()

        sqlite3_win32_mbcs_to_utf8(),Long,c,raw,dll(1),proc ! sqlite3_win32_mbcs_to_utf8()

        sqlite3_win32_mbcs_to_utf8_v2(),Long,c,raw,dll(1),proc ! sqlite3_win32_mbcs_to_utf8_v2()

        sqlite3_win32_set_directory(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_win32_set_directory(),int

        sqlite3_win32_set_directory16(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_win32_set_directory16(),int

        sqlite3_win32_set_directory8(Long p1,Long p2),Long,c,raw,dll(1),proc ! sqlite3_win32_set_directory8(),int

        sqlite3_win32_sleep(),Long,c,raw,dll(1),proc ! sqlite3_win32_sleep()

        sqlite3_win32_unicode_to_utf8(),Long,c,raw,dll(1),proc ! sqlite3_win32_unicode_to_utf8()

        sqlite3_win32_utf8_to_mbcs(),Long,c,raw,dll(1),proc ! sqlite3_win32_utf8_to_mbcs()

        sqlite3_win32_utf8_to_mbcs_v2(),Long,c,raw,dll(1),proc ! sqlite3_win32_utf8_to_mbcs_v2()

        sqlite3_win32_utf8_to_unicode(),Long,c,raw,dll(1),proc ! sqlite3_win32_utf8_to_unicode()

        sqlite3_win32_write_debug(),Long,c,raw,dll(1),proc ! sqlite3_win32_write_debug()

    End

