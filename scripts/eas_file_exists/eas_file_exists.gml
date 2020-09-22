/// @description eas_file_exists(filename)
/// @param filename
function eas_file_exists(filename) {
	if (!global.EAS_needasync) return file_exists(filename);

	return ds_map_exists(global.EAS_map, eas_safe_path(filename));



}
