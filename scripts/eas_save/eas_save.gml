/// @description eas_save([callback])
/// @param [callback]
function eas_save() {
	//Set callback script.
	global.EAS_callbackfunc = argument_count > 0 ? argument[0] : undefined;
	
	if (!global.EAS_needasync && !is_undefined(global.EAS_callbackfunc)) return global.EAS_callbackfunc(-1, -1);

	//So we don't do two file operations at once...
	if (global.EAS_state != EASYASYNC_STATE.IDLE)
	{
	    eas_error("ASYNC EVENT IS IN PROGRESS!");
	    return 0;
	}

	//Do the saving itself...

	//Write the ds map into a buffer as a json string.
	eas_define_group();
	
	if (global.EAS_dontJSON)
	{
		global.EAS_buffer = buffer_create(1, buffer_grow, 1);
		eas_write_binaryfmt(global.EAS_buffer);
	}
	else
	{
		var _jstr = json_encode(global.EAS_map);
		var _jlen = string_byte_length(_jstr);
		global.EAS_buffer = buffer_create(_jlen + 1, buffer_fixed, 1);
		buffer_write(global.EAS_buffer, buffer_string, _jstr);
	}

	//Setting "saveslotsize" is recommended on PlayStation 4, but it's a good practice to set it anyway.
	buffer_async_group_option("saveslotsize", buffer_get_size(global.EAS_buffer));

	//Save the buffer and wait for an async event.
	buffer_save_async(global.EAS_buffer, global.EAS_filename, 0, buffer_get_size(global.EAS_buffer));
	global.EAS_state = EASYASYNC_STATE.SAVING;
	global.EAS_id = buffer_async_group_end();
}

#macro EAS_BINARY_HEADER $53534145
#macro EAS_BINARY_END $444E4545

function eas_write_binaryfmt(buffer)
{
	buffer_write(buffer, buffer_u32, EAS_BINARY_HEADER);
	buffer_write(buffer, buffer_u32, ds_map_size(global.EAS_map));
	for (var _i = 0, _k = ds_map_find_first(global.EAS_map); _i < ds_map_size(global.EAS_map); _i++) {
		
		buffer_write(buffer, buffer_u32, string_byte_length(global.EAS_map[? _k]));
		buffer_write(buffer, buffer_string, _k);
		buffer_write(buffer, buffer_text, global.EAS_map[? _k]);
		
		_k = ds_map_find_next(global.EAS_map, _k);
	}
	buffer_write(buffer, buffer_u32, EAS_BINARY_END);
}

function eas_read_binaryfmt(buffer)
{
	var _header = buffer_read(buffer, buffer_u32);
	if (_header != EAS_BINARY_HEADER)
	{
		eas_log("BINARY: Invalid header!");
		return false;
	}
	
	var _amount = buffer_read(buffer, buffer_u32);
	if (ds_exists(global.EAS_map, ds_type_map)) ds_map_destroy(global.EAS_map);
	global.EAS_map = ds_map_create();
	for (var i = 0; i < _amount; i++)
	{
		var _size = buffer_read(buffer, buffer_u32);
		var _name = buffer_read(buffer, buffer_string);
		var __innerbuff = buffer_create(_size, buffer_fixed, 1);
		buffer_copy(buffer, buffer_tell(buffer), _size, __innerbuff, 0);
		var _data = buffer_read(buffer, buffer_text);
		buffer_delete(__innerbuff);
		
		global.EAS_map[? _name] = _data;
		
	}
	
	var _end = buffer_read(buffer, buffer_u32);
	if (_end != EAS_BINARY_END)
	{
		eas_log("BINARY: Unexpected end of file!");
		return false;
	}
	
	return true;
}