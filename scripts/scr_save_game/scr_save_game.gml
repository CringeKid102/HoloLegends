function scr_save_game() {
	if (!variable_global_exists("save_file_name")) global.save_file_name = "save1.ini";
	if (!variable_global_exists("ds_stats") || !ds_exists(global.ds_stats, ds_type_list)) global.ds_stats = ds_list_create();
	if (!variable_global_exists("inventory") || !ds_exists(global.inventory, ds_type_map)) global.inventory = ds_map_create();
	quest_init();
	while (ds_list_size(global.ds_stats) < 5) {
		var stat_index = ds_list_size(global.ds_stats);
		var default_value = 0;
		if (stat_index == 1) default_value = 1;
		if (stat_index == 3 || stat_index == 4) default_value = 100;
		global.ds_stats[| stat_index] = default_value;
	}

	ini_open(global.save_file_name);
	var stat_count = ds_list_size(global.ds_stats);
	for (var i = 0; i < stat_count; i++) {
		ini_write_real("Character", "Stat_" + string(i), global.ds_stats[| i]);
	}
	ini_write_real("Character", "Index", global.ds_stats[| 0]);
	ini_write_real("Character", "Level", global.ds_stats[| 1]);
	ini_write_string("Inventory", "Items", ds_map_write(global.inventory));
	var saved_room = room;
	var saved_x = 960;
	var saved_y = 540;
	if (variable_global_exists("playtime")) ini_write_real("Game", "Playtime", global.playtime);
	if (instance_exists(obj_player)) {
		saved_x = obj_player.x;
		saved_y = obj_player.y;
	} else if (variable_global_exists("pending_player_position") && global.pending_player_position) {
		saved_room = global.pending_load_room;
		saved_x = global.pending_player_x;
		saved_y = global.pending_player_y;
	}
	ini_write_real("Game", "CurrentRoom", saved_room);
	ini_write_real("Player", "X", saved_x);
	ini_write_real("Player", "Y", saved_y);
	quest_save_to_ini();
	ini_close();
	return true;
}
