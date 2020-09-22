/// @description eas_file_bin_position(binfile)
/// @param binfile
function eas_file_bin_position(argument0) {
	if (!global.EAS_needasync) return file_bin_position(argument0);

	return buffer_tell(ds_map_find_value(argument0, "buffer"));



}
