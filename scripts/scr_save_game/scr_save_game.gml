if (!variable_global_exists("save_file_name")) {
	global.save_file_name = "save1.ini";
}

if (!variable_global_exists("ds_stats") || !ds_exists(global.ds_stats, ds_type_list)) {
	global.ds_stats = ds_list_create();
}

var stat_character = 0;
var stat_level = 1;
var stats = global.ds_stats;

ini_open(global.save_file_name);

ini_write_real("Character", "Index", stats[| stat_character]);
ini_write_real("Character", "Level", stats[| stat_level]);

ini_close();
