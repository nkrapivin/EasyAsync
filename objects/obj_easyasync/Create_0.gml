/// @description Initialize.
eas_init();

//Load our container right after initializing. You can load it at any time (if you're not saving at the moment you want to load)
eas_load(scr_easyasync_callback); //the script argument is optional.

// Oh and this object doesn't need to be visible. Because this is just a handler object.