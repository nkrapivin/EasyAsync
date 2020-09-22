/// @description eas_safe_path(string)
/// @param string
function eas_safe_path(path) {
	gml_pragma("forceinline"); // it's recommended to inline one-line scripts for YYC.

	//Returns a sanitized path. (replaces working_directory and game_save_id with "")
	return string_lower(string_replace(string_replace(path, working_directory, ""), game_save_id, ""));



}
