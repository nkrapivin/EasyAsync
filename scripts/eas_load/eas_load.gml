/// @description eas_load([callback])
/// @param [callback]
function eas_load() {
	//Set callback script.
	global.EAS_callbackfunc = argument_count > 0 ? argument[0] : undefined;
	
	if (!global.EAS_needasync && !is_undefined(global.EAS_callbackfunc)) return global.EAS_callbackfunc(-1, -1);

	// After data was loaded, the callback script will be executed.
	if (global.EAS_state != EASYASYNC_STATE.IDLE)
	{
	    eas_error("ASYNC EVENT IS IN PROGRESS!");
	    return false;
	}

	//Do the loading...
	eas_define_group();
	global.EAS_buffer = buffer_create(1, buffer_grow, 1);
	buffer_load_async(global.EAS_buffer, global.EAS_filename, 0, -1);
	global.EAS_state = EASYASYNC_STATE.LOADING;
	global.EAS_id = buffer_async_group_end();
	
	return true;
}
