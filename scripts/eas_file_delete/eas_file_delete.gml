/// @description eas_file_delete(filename)
/// @param filename
function eas_file_delete(filename) {
	if (!global.EAS_needasync) return file_delete(filename);

	ds_map_delete(global.EAS_map, eas_safe_path(filename));
}
