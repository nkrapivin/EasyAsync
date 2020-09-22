/// @description Tests.

//Misc.
eas_log("Do we really need async? " + string(global.EAS_needasync));

//INI test
//eas_ini_close();
eas_ini_open("Test.ini");
//eas_ini_open("crash.ini");
ini_write_real("Hehe", "Real", 111);
ini_write_string("Meow", "AString", "WAAAAAAAAAAAAAAAAAAAAARIO");
show_debug_message(ini_read_string("Meow", "AString", "oh no"));
show_debug_message("a real " + string(ini_read_real("Hehe", "Real", 0)));
eas_ini_close();

//Text test

//Write test
f = eas_file_text_open_write("grossley.txt");
eas_file_text_write_string(f, "pug is the right way.......... or is it?");
repeat (100) eas_file_text_writeln(f);
eas_file_text_write_string(f, "m e o w");
eas_file_text_writeln(f);
eas_file_text_close(f);

//Read test
str = "";
f = eas_file_text_open_read("grossley.txt");
str += eas_file_text_read_string(f);
repeat (100) str += eas_file_text_readln(f);
str += eas_file_text_read_string(f);
str += eas_file_text_readln(f);
eas_file_text_close(f);

show_debug_message(str);

//Bin test
randomize();
f = eas_file_bin_open("test.bin", 2);
repeat (128) eas_file_bin_write_byte(f, irandom_range(1, 255));
eas_file_bin_close(f);

f = eas_file_bin_open("test.bin", 0);
arr = array_create(128);
var _a = 0; repeat (128) arr[_a++] = eas_file_bin_read_byte(f);
show_debug_message(string(arr));
eas_file_bin_close(f);
arr = undefined;

show_debug_message("Tests done!");
eas_save(scr_easyasync_callback); // this will call scr_easyasync_callback script when saving finished.
instance_destroy();