/// @description eas_file_text_read_string(handle)
/// @param handle
function eas_file_text_read_string(argument0) {
	if (!global.EAS_needasync) return file_text_read_string(argument0);

	if (!eas_file_is_read(argument0)) eas_error("FILE IS NOT OPENED FOR READING.");
	else
	{
	    var _handle = ds_map_find_value(argument0, "handle");
	    return file_text_read_string(_handle);
	}



}
