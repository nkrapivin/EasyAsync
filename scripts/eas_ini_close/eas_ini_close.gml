/// @description eas_ini_close(fname)
/// @param fname
function eas_ini_close() {

	if (!global.EAS_needasync) return ini_close();

	if (!global.EAS_ini || global.EAS_ininame == "")
	{
	    eas_error("No INI was opened! Please do eas_ini_open(fname); first");
	}
	else
	{
	    var _inistring = ini_close();
		
		if (global.EAS_iniempty && string_length(_inistring) == 0)
		{
			eas_log("Empty INI, not writing to the map...");
		}
		else
		{
			ds_map_replace(global.EAS_map, global.EAS_ininame, _inistring);
		}
		
	    eas_log("Closed INI " + global.EAS_ininame);
    
	    global.EAS_ini = false;
		global.EAS_iniempty = false;
	    global.EAS_ininame = "";
	    global.EAS_inidata = "";
    
	    return _inistring;
	}



}
