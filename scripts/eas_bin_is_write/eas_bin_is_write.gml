/// @description eas_bin_is_write(binfile)
/// @param binfile
function eas_bin_is_write(argument0) {
	gml_pragma("forceinline"); // it's recommended to inline one-line scripts for YYC.
	return (ds_map_find_value(argument0, "mode") > 0);



}
