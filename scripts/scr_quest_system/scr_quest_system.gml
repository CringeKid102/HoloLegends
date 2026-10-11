function quest_daily_stamp() {
	var current_date = date_current_datetime();
	return string(date_get_year(current_date)) + "-" + string(date_get_month(current_date)) + "-" + string(date_get_day(current_date));
}

function quest_reset_daily_state() {
	ds_map_clear(global.daily_progress);
	ds_map_clear(global.daily_completed);
	global.daily_progress[? "daily_hunt"] = 0;
	global.daily_progress[? "daily_gather"] = 0;
	global.daily_progress[? "daily_delve"] = 0;
	global.daily_completed[? "daily_hunt"] = 0;
	global.daily_completed[? "daily_gather"] = 0;
	global.daily_completed[? "daily_delve"] = 0;
	global.daily_stamp = quest_daily_stamp();
}

function quest_reset_all() {
	quest_init();
	ds_map_clear(global.quest_active);
	ds_map_clear(global.quest_progress);
	ds_map_clear(global.quest_targets);
	ds_map_clear(global.quest_completed);
	ds_map_clear(global.story_flags);
	ds_map_clear(global.achievements);
	global.story_chapter = 0;
	global.quest_tokens = 0;
	quest_reset_daily_state();
}

function quest_refresh_dailies() {
	if (global.daily_stamp != quest_daily_stamp()) {
		quest_reset_daily_state();
	}
}

function quest_init() {
	if (!variable_global_exists("quest_active") || !ds_exists(global.quest_active, ds_type_map)) {
		global.quest_active = ds_map_create();
	}
	if (!variable_global_exists("quest_progress") || !ds_exists(global.quest_progress, ds_type_map)) {
		global.quest_progress = ds_map_create();
	}
	if (!variable_global_exists("quest_targets") || !ds_exists(global.quest_targets, ds_type_map)) {
		global.quest_targets = ds_map_create();
	}
	if (!variable_global_exists("quest_completed") || !ds_exists(global.quest_completed, ds_type_map)) {
		global.quest_completed = ds_map_create();
	}
	if (!variable_global_exists("story_flags") || !ds_exists(global.story_flags, ds_type_map)) {
		global.story_flags = ds_map_create();
	}
	if (!variable_global_exists("achievements") || !ds_exists(global.achievements, ds_type_map)) {
		global.achievements = ds_map_create();
	}
	if (!variable_global_exists("daily_progress") || !ds_exists(global.daily_progress, ds_type_map)) {
		global.daily_progress = ds_map_create();
	}
	if (!variable_global_exists("daily_completed") || !ds_exists(global.daily_completed, ds_type_map)) {
		global.daily_completed = ds_map_create();
	}
	if (!variable_global_exists("daily_stamp")) {
		global.daily_stamp = "";
	}
	if (!variable_global_exists("story_chapter")) {
		global.story_chapter = 0;
	}
	if (!variable_global_exists("quest_tokens")) {
		global.quest_tokens = 0;
	}
	quest_refresh_dailies();
}

function quest_start(_quest_id, _target = 1) {
	quest_init();
	if (ds_map_exists(global.quest_completed, _quest_id)) {
		return false;
	}
	global.quest_active[? _quest_id] = 1;
	if (!ds_map_exists(global.quest_progress, _quest_id)) {
		global.quest_progress[? _quest_id] = 0;
	}
	global.quest_targets[? _quest_id] = max(1, floor(_target));
	return true;
}

function quest_add_progress(_quest_id, _amount = 1) {
	quest_init();
	if (!ds_map_exists(global.quest_active, _quest_id) || global.quest_active[? _quest_id] == 0) {
		return 0;
	}
	var progress = global.quest_progress[? _quest_id] + max(0, _amount);
	var target = global.quest_targets[? _quest_id];
	global.quest_progress[? _quest_id] = min(progress, target);
	if (global.quest_progress[? _quest_id] >= target) {
		quest_complete(_quest_id);
	}
	return global.quest_progress[? _quest_id];
}

function quest_complete(_quest_id) {
	quest_init();
	global.quest_active[? _quest_id] = 0;
	global.quest_completed[? _quest_id] = 1;
	quest_unlock_achievement("first_quest");
	return true;
}

function quest_is_complete(_quest_id) {
	quest_init();
	return ds_map_exists(global.quest_completed, _quest_id) && global.quest_completed[? _quest_id] == 1;
}

function quest_is_active(_quest_id) {
	quest_init();
	return ds_map_exists(global.quest_active, _quest_id) && global.quest_active[? _quest_id] == 1;
}

function quest_get_progress(_quest_id) {
	quest_init();
	if (!ds_map_exists(global.quest_progress, _quest_id)) {
		return 0;
	}
	return global.quest_progress[? _quest_id];
}

function quest_daily_target(_daily_id) {
	switch (_daily_id) {
		case "daily_hunt": return 5;
		case "daily_gather": return 3;
		case "daily_delve": return 1;
	}
	return 0;
}

function quest_daily_add_progress(_daily_id, _amount = 1) {
	quest_init();
	quest_refresh_dailies();
	var target = quest_daily_target(_daily_id);
	if (target <= 0 || global.daily_completed[? _daily_id] == 1) {
		return 0;
	}
	global.daily_progress[? _daily_id] = min(target, global.daily_progress[? _daily_id] + max(0, _amount));
	if (global.daily_progress[? _daily_id] >= target) {
		global.daily_completed[? _daily_id] = 1;
		global.quest_tokens += 10;
		if (global.daily_completed[? "daily_hunt"] == 1
		&& global.daily_completed[? "daily_gather"] == 1
		&& global.daily_completed[? "daily_delve"] == 1) {
			quest_unlock_achievement("daily_trio");
		}
	}
	return global.daily_progress[? _daily_id];
}

function quest_daily_get_progress(_daily_id) {
	quest_init();
	quest_refresh_dailies();
	if (!ds_map_exists(global.daily_progress, _daily_id)) {
		return 0;
	}
	return global.daily_progress[? _daily_id];
}

function quest_daily_is_complete(_daily_id) {
	quest_init();
	quest_refresh_dailies();
	return ds_map_exists(global.daily_completed, _daily_id) && global.daily_completed[? _daily_id] == 1;
}

function quest_set_story_chapter(_chapter) {
	quest_init();
	global.story_chapter = max(global.story_chapter, floor(_chapter));
	if (global.story_chapter >= 1) {
		quest_unlock_achievement("story_begins");
	}
}

function quest_set_story_flag(_flag, _value = 1) {
	quest_init();
	global.story_flags[? _flag] = _value;
}

function quest_get_story_flag(_flag, _default = 0) {
	quest_init();
	if (!ds_map_exists(global.story_flags, _flag)) {
		return _default;
	}
	return global.story_flags[? _flag];
}

function quest_unlock_achievement(_achievement_id) {
	quest_init();
	if (ds_map_exists(global.achievements, _achievement_id)) {
		return false;
	}
	global.achievements[? _achievement_id] = 1;
	return true;
}

function quest_has_achievement(_achievement_id) {
	quest_init();
	return ds_map_exists(global.achievements, _achievement_id) && global.achievements[? _achievement_id] == 1;
}

function quest_get_achievement_count() {
	quest_init();
	return ds_map_size(global.achievements);
}

function quest_save_to_ini() {
	quest_init();
	ini_write_string("Progression", "QuestActive", ds_map_write(global.quest_active));
	ini_write_string("Progression", "QuestProgress", ds_map_write(global.quest_progress));
	ini_write_string("Progression", "QuestTargets", ds_map_write(global.quest_targets));
	ini_write_string("Progression", "QuestCompleted", ds_map_write(global.quest_completed));
	ini_write_string("Progression", "StoryFlags", ds_map_write(global.story_flags));
	ini_write_string("Progression", "Achievements", ds_map_write(global.achievements));
	ini_write_string("Progression", "DailyProgress", ds_map_write(global.daily_progress));
	ini_write_string("Progression", "DailyCompleted", ds_map_write(global.daily_completed));
	ini_write_string("Progression", "DailyStamp", global.daily_stamp);
	ini_write_real("Progression", "StoryChapter", global.story_chapter);
	ini_write_real("Progression", "QuestTokens", global.quest_tokens);
}

function quest_load_from_ini() {
	quest_init();
	ds_map_clear(global.quest_active);
	ds_map_clear(global.quest_progress);
	ds_map_clear(global.quest_targets);
	ds_map_clear(global.quest_completed);
	ds_map_clear(global.story_flags);
	ds_map_clear(global.achievements);
	ds_map_clear(global.daily_progress);
	ds_map_clear(global.daily_completed);
	var map_data = ini_read_string("Progression", "QuestActive", "");
	if (map_data != "") ds_map_read(global.quest_active, map_data);
	map_data = ini_read_string("Progression", "QuestProgress", "");
	if (map_data != "") ds_map_read(global.quest_progress, map_data);
	map_data = ini_read_string("Progression", "QuestTargets", "");
	if (map_data != "") ds_map_read(global.quest_targets, map_data);
	map_data = ini_read_string("Progression", "QuestCompleted", "");
	if (map_data != "") ds_map_read(global.quest_completed, map_data);
	map_data = ini_read_string("Progression", "StoryFlags", "");
	if (map_data != "") ds_map_read(global.story_flags, map_data);
	map_data = ini_read_string("Progression", "Achievements", "");
	if (map_data != "") ds_map_read(global.achievements, map_data);
	map_data = ini_read_string("Progression", "DailyProgress", "");
	if (map_data != "") ds_map_read(global.daily_progress, map_data);
	map_data = ini_read_string("Progression", "DailyCompleted", "");
	if (map_data != "") ds_map_read(global.daily_completed, map_data);
	global.daily_stamp = ini_read_string("Progression", "DailyStamp", "");
	global.story_chapter = ini_read_real("Progression", "StoryChapter", 0);
	global.quest_tokens = ini_read_real("Progression", "QuestTokens", 0);
	quest_refresh_dailies();
}