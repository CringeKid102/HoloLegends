function scr_load_game() {
	if (!variable_global_exists("save_file_name")) global.save_file_name = "save1.ini";
	if (!file_exists(global.save_file_name)) return false;
	if (!variable_global_exists("ds_stats") || !ds_exists(global.ds_stats, ds_type_list)) global.ds_stats = ds_list_create();
	if (!variable_global_exists("inventory") || !ds_exists(global.inventory, ds_type_map)) global.inventory = ds_map_create();
	quest_init();

	ds_list_clear(global.ds_stats);
	var defaults = [0, 1, 0, 100, 100];
	for (var i = 0; i < array_length_1d(defaults); i++) global.ds_stats[| i] = defaults[i];
	ds_map_clear(global.inventory);
	global.inventory_item_count = 0;

	ini_open(global.save_file_name);
	for (var i = 0; i < array_length_1d(defaults); i++) {
		var fallback = defaults[i];
		if (i == 0) fallback = ini_read_real("Character", "Index", fallback);
		if (i == 1) fallback = ini_read_real("Character", "Level", fallback);
		global.ds_stats[| i] = ini_read_real("Character", "Stat_" + string(i), fallback);
	}
	var inventory_data = ini_read_string("Inventory", "Items", "");
	if (inventory_data != "") {
		ds_map_read(global.inventory, inventory_data);
		global.inventory_item_count = ds_map_size(global.inventory);
	}
	global.pending_load_room = ini_read_real("Game", "CurrentRoom", rm_game);
	global.pending_player_x = ini_read_real("Player", "X", 960);
	global.pending_player_y = ini_read_real("Player", "Y", 540);
	global.pending_player_position = true;
	global.playtime = ini_read_real("Game", "Playtime", 0);
	global.playtime_base = global.playtime;
	global.playtime_session_start = get_timer();
	quest_load_from_ini();
	ini_close();
	return true;
}