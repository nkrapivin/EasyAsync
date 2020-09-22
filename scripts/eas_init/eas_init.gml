/// @description eas_init()
function eas_init() {

	enum EASYASYNC_STATE
	{
	    IDLE,
	    LOADING,
	    SAVING,
		_LENGTH
	}

	//Options (customize them to your liking)
	global.EAS_filename = "savedata.sav"; // Filename.
	global.EAS_slottitle = "EasyAsyncSavefile"; // Slot title. (CAN'T CONTAIN SPACES ON PLAYSTATION 4!)
	global.EAS_subtitle = "EasyAsync Savefile"; // Sub title in Console UI.
	global.EAS_showdialog = false; // Show slot selection dialog? (only valid for PlayStation?)
	global.EAS_savepadindex = 0; // Force writing to slot 0. (Although you can write to slot 1, 2, 3 just fine,
	//but it's recommended to enable EAS_showdialog if you want to write to a slot that's not 0)
	global.EAS_foldername = "EasyAsyncFolder";
	//(only valid for PC) name of the folder where files will be saved to. (example: %LOCALAPPDATA%\{project_name}\{EAS_foldername}\{EAS_filename})


	//Main initialization stuff.
	global.EAS_map = ds_map_create(); // DS Map where all your files are located.
	global.EAS_id = undefined; // Async id.
	global.EAS_buffer = undefined; // Buffer.
	global.EAS_callbackfunc = undefined; // A variable that is used for storing callback script.
	global.EAS_callbackret = undefined; // Callback result.
	global.EAS_state = EASYASYNC_STATE.IDLE; // EAS_state is not IDLE only in callback scripts.
	global.EAS_needasync =
	    (
	        //Regular consoles, nothing interesting.
	        (os_type == os_psvita)  ||
	        (os_type == os_ps4)     ||
	        (os_type == os_ps3)     ||
	        (os_type == os_xboxone) ||
			(os_type == os_switch)  ||
        
	        (os_type == os_uwp)     // surprisingly, https://help.yoyogames.com/hc/en-us/articles/360031122031-UWP-Saving-And-Loading-When-Targeting-Xbox
	    );
	//You can use this variable to check what file functions you should use, normal or EasyAsync ones.
	//(since 2.1 EasyAsync will automatically pick the best file functions for you)

	//INI stuff
	global.EAS_ini = false;  // do we have an ini open?
	global.EAS_iniempty = false; // fix for Sonic Time Twisted.
	global.EAS_ininame = ""; // current ini name
	global.EAS_inidata = ""; // current ini data as a big string
	
	// Experimental features.
	global.EAS_dontJSON = false; // use JSON or EAS's binary format?
	
	/*
		BINARY FORMAT STRUCTURE:
		HEADER (4 bytes) - 'EASS'
		UINT32 amount of files (4 bytes)
		
		repeat  amount of files
		[
			UINT32 file size (4 bytes)
			(max file size is ~4 gigabytes)
			STRING file name (null terminated)
			BYTE[] file data (file size)
		]
		
		END (4 bytes) - 'EEND'
		
		Q: why would you use the binary format instead of JSON?
		A: no idea really, actually, sometimes if you save raw binary data,
		   the string is f'ed up and screws up the json file.
	*/

	//If this message appears then all went fine.
	eas_log("EasyAsync version 3.0 initialized!");
}
