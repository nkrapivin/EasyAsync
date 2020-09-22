/// @description eas_enum_to_string(enumval)
/// @param enumval
function eas_enum_to_string(enumval) {

	//Turns an enum value into a string, since you can't do that "natively" in GML.

	switch (enumval)
	{
	    case EASYASYNC_STATE.IDLE:
	        return "IDLE";
	    case EASYASYNC_STATE.SAVING:
	        return "SAVING";
	    case EASYASYNC_STATE.LOADING:
	        return "LOADING";
	    default:
	        return "UNKNOWN";
	}
}
