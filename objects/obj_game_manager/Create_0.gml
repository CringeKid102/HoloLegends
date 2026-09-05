/// @description Game Manager - Handles global game systems
/// Place one instance in the first room (rm_menu)

// Initialize systems on creation
event_inherited();

// Initialize playtime tracking
if (!variable_global_exists("playtime")) {
	global.playtime = 0;
}
if (!variable_global_exists("playtime_session_start")) {
	global.playtime_session_start = get_timer();
}

// Initialize character stats
if (!variable_global_exists("ds_stats")) {
	global.ds_stats = ds_list_create();
	global.ds_stats[| 0] = 0;  // Character index
	global.ds_stats[| 1] = 1;  // Level
	global.ds_stats[| 2] = 0;  // Experience
	global.ds_stats[| 3] = 100; // Health
	global.ds_stats[| 4] = 100; // Max Health
}

// Initialize inventory
if (!variable_global_exists("inventory")) {
	global.inventory = ds_map_create();
	global.inventory_max_size = 20;
	global.inventory_item_count = 0;
}

// Initialize game settings
if (!variable_global_exists("difficulty")) {
	global.difficulty = 1; // 0 = Easy, 1 = Normal, 2 = Hard
}

if (!variable_global_exists("text_speed")) {
	global.text_speed = 1.0; // 0.5 = slow, 1.0 = normal, 2.0 = fast
}

if (!variable_global_exists("auto_save_enabled")) {
	global.auto_save_enabled = true;
}

auto_save_timer = 0;
auto_save_interval = 60 * 60; // Every 60 seconds
