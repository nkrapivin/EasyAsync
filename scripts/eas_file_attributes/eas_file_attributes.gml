/// @description eas_file_attributes(fname, attr)
/// @param fname
/// @param  attr
function eas_file_attributes(fname, attr) {
	if (!global.EAS_needasync) return file_attributes(fname, attr);

	eas_log("file_attributes is not implemented in EasyAsync, returning false!");
	return false;
}
