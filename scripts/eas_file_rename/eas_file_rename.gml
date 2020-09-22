/// @description eas_file_rename(filename, new_filename)
/// @param filename
/// @param  new_filename
function eas_file_rename(filename, new_filename) {
	if (!global.EAS_needasync) return file_rename(filename, new_filename);

	if (!eas_file_exists(filename) || eas_file_exists(new_filename)) return false;
	else
	{
	    ds_map_replace(global.EAS_map, new_filename, ds_map_find_value(global.EAS_map, filename));
	    eas_file_delete(filename);
	    return true;
	}
}
