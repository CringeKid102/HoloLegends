/// Debug Console system for development

/// @function show_debug_console()
/// @description Toggle debug console visibility
function show_debug_console() {
	if (!variable_global_exists("debug_console_visible")) {
		global.debug_console_visible = true;
		global.debug_console_messages = ds_list_create();
		return;
	}
	
	global.debug_console_visible = !global.debug_console_visible;
}

/// @function add_debug_message(message)
/// @description Add message to debug console
function add_debug_message(message) {
	if (!variable_global_exists("debug_console_messages")) {
		global.debug_console_messages = ds_list_create();
	}
	
	var timestamp = string_format(get_timer() / 1_000_000, 8, 2);
	ds_list_insert(global.debug_console_messages, 0, timestamp + " - " + message);
	
	// Keep only last 20 messages
	if (ds_list_size(global.debug_console_messages) > 20) {
		ds_list_delete(global.debug_console_messages, 20);
	}
}

/// @function draw_debug_console()
/// @description Draw debug console overlay
function draw_debug_console() {
	if (!variable_global_exists("debug_console_visible") || !global.debug_console_visible) {
		return;
	}
	
	var console_w = 400;
	var console_h = 300;
	var console_x = 10;
	var console_y = 10;
	
	// Draw semi-transparent background
	draw_set_alpha(0.8);
	draw_set_color(c_black);
	draw_rectangle(console_x, console_y, console_x + console_w, console_y + console_h, false);
	
	// Draw border
	draw_set_color(c_lime);
	draw_rectangle(console_x, console_y, console_x + console_w, console_y + console_h, true);
	
	// Draw title
	draw_set_color(c_lime);
	draw_text(console_x + 5, console_y + 5, "DEBUG CONSOLE (Press ` to toggle)");
	
	// Draw messages
	draw_set_color(c_white);
	draw_set_font(fnt_small);
	
	if (variable_global_exists("debug_console_messages")) {
		var msg_count = ds_list_size(global.debug_console_messages);
		for (var i = 0; i < min(msg_count, 12); i++) {
			var msg = global.debug_console_messages[| i];
			draw_text(console_x + 5, console_y + 25 + (i * 20), msg);
		}
	}
	
	// Draw stats at bottom
	draw_set_color(c_yellow);
	
	var playtime_str = "0:00:00";
	if (variable_global_exists("playtime")) {
		var total_seconds = global.playtime;
		var hours = floor(total_seconds div 3600);
		var minutes = floor((total_seconds mod 3600) div 60);
		var seconds = floor(total_seconds mod 60);
		playtime_str = string(hours) + ":" + string_pad(string(minutes), 2, "0") + ":" + string_pad(string(seconds), 2, "0");
	}
	
	var level = 1;
	if (variable_global_exists("ds_stats") && ds_exists(global.ds_stats, ds_type_list)) {
		level = global.ds_stats[| 1];
	}
	
	draw_text(console_x + 5, console_y + console_h - 25, 
		"FPS: " + string(fps) + " | " +
		"Level: " + string(level) + " | " +
		"Time: " + playtime_str
	);
	
	draw_set_alpha(1);
	draw_set_color(c_white);
}
