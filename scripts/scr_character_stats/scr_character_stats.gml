/// @function init_character_stats()
/// @description Initialize character stats system
function init_character_stats() {
	if (!variable_global_exists("ds_stats")) {
		global.ds_stats = ds_list_create();
	}
	
	// Add default stats
	global.ds_stats[| 0] = 0;  // Character index
	global.ds_stats[| 1] = 1;  // Level
	global.ds_stats[| 2] = 0;  // Experience points
	global.ds_stats[| 3] = 100; // Health
	global.ds_stats[| 4] = 100; // Max Health
}

/// @function add_experience(amount)
/// @description Add experience and handle level-ups
function add_experience(amount) {
	if (!variable_global_exists("ds_stats")) {
		init_character_stats();
	}
	
	var exp_index = 2;
	var level_index = 1;
	var exp_threshold = 100; // Experience needed per level
	
	global.ds_stats[| exp_index] += amount;
	
	// Check for level up
	while (global.ds_stats[| exp_index] >= exp_threshold) {
		global.ds_stats[| exp_index] -= exp_threshold;
		global.ds_stats[| level_index] += 1;
		exp_threshold = ceil(exp_threshold * 1.1); // Each level requires 10% more
		
		show_debug_message("Level up! New level: " + string(global.ds_stats[| level_index]));
	}
}

/// @function get_character_level()
/// @description Get current character level
function get_character_level() {
	if (!variable_global_exists("ds_stats")) {
		return 1;
	}
	return global.ds_stats[| 1];
}

/// @function get_character_experience()
/// @description Get current experience points
function get_character_experience() {
	if (!variable_global_exists("ds_stats")) {
		return 0;
	}
	return global.ds_stats[| 2];
}
