/// @description READ ME!

/*
    This object is not required, it's a series of EasyAsync tests.
    Only add it if you know what you're doing!
    
    - Signed, Nik the Cat.
*/

if (room != room_first || instance_number(object_index) > 1 || !instance_exists(obj_easyasync)) instance_destroy();
else
{
    global.EAS_needasync = true; // force asynchronous file operations. (don't do it unless you really need it!)
	global.EAS_dontJSON = true; // test...
    alarm[0] = 2 * room_speed; // wait two seconds.
}