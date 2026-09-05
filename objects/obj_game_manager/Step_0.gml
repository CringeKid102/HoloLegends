/// @description Game Manager - Update systems every frame

// Update playtime
if (variable_global_exists("playtime")) {
	var elapsed = (get_timer() - global.playtime_session_start) / 1_000_000; // convert to seconds
	global.playtime = max(global.playtime, elapsed);
}

// Update music fade transitions
if (variable_global_exists("current_music") && audio_is_playing(global.current_music)) {
	if (variable_global_exists("music_fade_time")) {
		var current_time = get_timer() / 1_000_000;
		var elapsed = current_time - global.music_fade_start;
		var progress = clamp(elapsed / global.music_fade_time, 0, 1);
		
		var target_vol = global.music_fade_target_vol;
		var current_vol = lerp(0, target_vol, progress);
		
		audio_sound_gain(global.current_music, current_vol, 0);
		
		// Stop sound when faded out
		if (progress >= 1 && target_vol == 0) {
			audio_stop_sound(global.current_music);
			global.current_music = noone;
		}
	}
}

// Handle global hotkeys
// Quick save with Ctrl+S
if (keyboard_check_pressed(vk_control) && keyboard_check_pressed(ord("S"))) {
	quick_save();
}

// Quick load with Ctrl+L
if (keyboard_check_pressed(vk_control) && keyboard_check_pressed(ord("L"))) {
	quick_load();
}

// Fullscreen toggle with F11
if (keyboard_check_pressed(vk_f11)) {
	window_set_fullscreen(!window_get_fullscreen());
}

// Auto-save system
if (global.auto_save_enabled) {
	auto_save_timer++;
	if (auto_save_timer >= auto_save_interval) {
		auto_save_timer = 0;
		quick_save();
		show_debug_message("Auto-save completed");
	}
}
