/// @description eas_perform_async()
function eas_perform_async() {

	// If you're using this extension in GMS2, please don't forget to uncomment the line-
	// in switch-case EASYASYNC_STATE.SAVING below!

	var _ident = ds_map_find_value(async_load, "id");
	if (is_undefined(_ident)) return false;
	var _status = ds_map_find_value(async_load, "status");
	var _error = ds_map_find_value(async_load, "error");
	var _err = ((!_status) && (_error != 0)); //if status is false, and error does not equal to 0.

	if (_err) //oh no.
	{
	    eas_error("Error in Async Save / Load event has occured. Status: " + string(_status) + " Error code: " + string(_error));
	    exit;
	}

	if (_ident == global.EAS_id)
	{
	    switch (global.EAS_state)
	    {
	        case EASYASYNC_STATE.LOADING:
	        {
	            eas_log("Got load async event...");
	            //buffer_seek(global.EAS_buffer, buffer_seek_start, 0);
				if (global.EAS_dontJSON)
				{
					if (!eas_read_binaryfmt(global.EAS_buffer))
					{
						eas_log("BINARY: errors occured when reading data.");
					}
				}
				else
				{
		            var _string = buffer_read(global.EAS_buffer, buffer_string);
		            var _newmap = json_decode(_string);
					
		            if (_newmap != -1)
		            {
		                ds_map_destroy(global.EAS_map);
		                global.EAS_map = _newmap;
		            }
		            else
		            {
		                eas_log("WARNING: Invalid data OR the file does not exist.");
		            }
				}
            
	            buffer_delete(global.EAS_buffer);
	            if (!is_undefined(global.EAS_callbackfunc)) global.EAS_callbackret = global.EAS_callbackfunc(_ident, _err);
	            else eas_log("MSG: Invalid script or it was not passed to eas_load() (it's not an error or a warning!)");
            
	            global.EAS_state = EASYASYNC_STATE.IDLE;
	            eas_log("Load event OK");
            
	            break;
	        }
        
	        case EASYASYNC_STATE.SAVING:
	        {
	            eas_log("Got save async event...");
	            buffer_delete(global.EAS_buffer);
	            if (os_type == os_switch) switch_save_data_commit();
	            if (!is_undefined(global.EAS_callbackfunc)) global.EAS_callbackret = global.EAS_callbackfunc(_ident, _err);
	            else eas_log("MSG: Invalid function or it was not passed to eas_save() (it's not an error or a warning!)");
            
	            global.EAS_state = EASYASYNC_STATE.IDLE;
	            eas_log("Save event OK");
            
	            break;
	        }
        
	        default:
	        {
	            eas_log("Invalid EasyAsync state.");
	            break;
	        }
	    }
		
		return true;
	}
	
	return false;
}
