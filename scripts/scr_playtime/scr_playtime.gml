/// @function init_playtime()
/// @description Initialize playtime tracking
function init_playtime() {
	if (!variable_global_exists("playtime")) {
		global.playtime = 0; // in seconds
	}
	if (!variable_global_exists("playtime_session_start")) {
		global.playtime_session_start = get_timer(); // microseconds
	}
}

/// @function update_playtime()
/// @description Update playtime (call in game manager or persistent object)
function update_playtime() {
	if (!variable_global_exists("playtime")) {
		init_playtime();
	}
	
	var elapsed = (get_timer() - global.playtime_session_start) / 1_000_000; // convert to seconds
	global.playtime = max(global.playtime, elapsed);
}

/// @function get_playtime_formatted()
/// @description Return playtime as formatted string HH:MM:SS
function get_playtime_formatted() {
	if (!variable_global_exists("playtime")) {
		return "0:00:00";
	}
	
	var total_seconds = global.playtime;
	var hours = floor(total_seconds div 3600);
	var minutes = floor((total_seconds mod 3600) div 60);
	var seconds = floor(total_seconds mod 60);
	
	return string(hours) + ":" + string_pad(string(minutes), 2, "0") + ":" + string_pad(string(seconds), 2, "0");
}

/// @function get_playtime_short()
/// @description Return playtime as short format (just minutes and seconds)
function get_playtime_short() {
	if (!variable_global_exists("playtime")) {
		return "0:00";
	}
	
	var total_seconds = global.playtime;
	var minutes = floor(total_seconds div 60);
	var seconds = floor(total_seconds mod 60);
	
	return string(minutes) + ":" + string_pad(string(seconds), 2, "0");
}
