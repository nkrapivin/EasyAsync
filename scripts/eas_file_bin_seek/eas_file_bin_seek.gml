/// @description eas_file_bin_seek(binfile, seek_pos)
/// @param binfile
/// @param  seek_pos
function eas_file_bin_seek(argument0, argument1) {
	if (!global.EAS_needasync) return file_bin_seek(argument0, argument1);

	var _buffer = ds_map_find_value(argument0, "buffer");
	buffer_seek(_buffer, buffer_seek_start, argument1);



}
