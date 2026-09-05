/// @function quick_save()
/// @description Save game to quicksave slot
function quick_save() {
	if (!variable_global_exists("ds_stats")) {
		global.ds_stats = ds_list_create();
	}
	
	global.save_file_name = "quicksave.ini";
	
	ini_open(global.save_file_name);
	
	// Save character stats
	if (variable_global_exists("ds_stats") && ds_exists(global.ds_stats, ds_type_list)) {
		var stat_count = ds_list_size(global.ds_stats);
		for (var i = 0; i < stat_count; i++) {
			ini_write_real("Character", "Stat_" + string(i), global.ds_stats[| i]);
		}
	}
	
	// Save playtime
	if (variable_global_exists("playtime")) {
		ini_write_real("Game", "Playtime", global.playtime);
	}
	
	// Save current room
	if (room != -1) {
		ini_write_real("Game", "CurrentRoom", room);
	}
	
	// Save player position
	if (instance_exists(obj_player)) {
		ini_write_real("Player", "X", obj_player.x);
		ini_write_real("Player", "Y", obj_player.y);
	}
	
	ini_close();
	
	show_debug_message("Quick save completed: " + global.save_file_name);
}

/// @function quick_load()
/// @description Load game from quicksave slot
function quick_load() {
	global.save_file_name = "quicksave.ini";
	
	if (!file_exists(global.save_file_name)) {
		show_debug_message("No quicksave file found");
		return false;
	}
	
	if (!variable_global_exists("ds_stats")) {
		global.ds_stats = ds_list_create();
	}
	
	ini_open(global.save_file_name);
	
	// Load character stats
	var stat_character = 0;
	var stat_level = 1;
	global.ds_stats[| stat_character] = ini_read_real("Character", "Stat_0", 0);
	global.ds_stats[| stat_level] = ini_read_real("Character", "Stat_1", 1);
	
	// Load playtime
	if (variable_global_exists("playtime")) {
		global.playtime = ini_read_real("Game", "Playtime", 0);
	}
	
	// Load player position
	var player_x = ini_read_real("Player", "X", 0);
	var player_y = ini_read_real("Player", "Y", 0);
	
	ini_close();
	
	// Move player to saved position
	if (instance_exists(obj_player)) {
		obj_player.x = player_x;
		obj_player.y = player_y;
	}
	
	show_debug_message("Quick load completed");
	return true;
}
