/// @function quick_save()
/// @description Save game to quicksave slot
function quick_save() {
	var previous_save_file = global.save_file_name;
	global.save_file_name = "quicksave.ini";
	var saved = scr_save_game();
	global.save_file_name = previous_save_file;
	return saved;
}

/// @function quick_load()
/// @description Load game from quicksave slot
function quick_load() {
	var quicksave_file = "quicksave.ini";
	if (!file_exists(quicksave_file)) {
		show_debug_message("No quicksave file found");
		return false;
	}
	var previous_save_file = global.save_file_name;
	global.save_file_name = quicksave_file;
	var loaded = scr_load_game();
	global.save_file_name = previous_save_file;
	if (!loaded) return false;
	if (global.pending_load_room != room) {
		room_goto(global.pending_load_room);
	} else if (instance_exists(obj_player)) {
		obj_player.x = global.pending_player_x;
		obj_player.y = global.pending_player_y;
		global.pending_player_position = false;
	}
	return true;
}
