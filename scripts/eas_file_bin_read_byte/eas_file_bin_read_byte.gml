/// @description eas_file_bin_read_byte(binfile)
/// @param binfile
function eas_file_bin_read_byte(argument0) {
	if (!global.EAS_needasync) return file_bin_read_byte(argument0);

	var _buffer = ds_map_find_value(argument0, "buffer");
	return buffer_read(_buffer, buffer_u8);



}
