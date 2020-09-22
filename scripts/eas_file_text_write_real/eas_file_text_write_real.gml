/// @description eas_file_text_write_real(handle, str)
/// @param handle
/// @param  str
function eas_file_text_write_real(argument0, argument1) {
	if (!global.EAS_needasync) return file_text_write_real(argument0, argument1);

	if (eas_file_is_read(argument0)) eas_error("FILE IS NOT OPENED FOR WRITING.");
	else
	{
	    var _buffer = ds_map_find_value(argument0, "buffer");
	    buffer_write(_buffer, buffer_text, string(argument1));
	}



}
