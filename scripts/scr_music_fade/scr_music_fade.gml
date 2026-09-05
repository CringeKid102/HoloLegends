/// Enhanced music system with fade transitions

/// @function play_music_fade(_sound, _fade_in_time)
/// @description Play music with fade-in effect
function play_music_fade(_sound, _fade_in_time = 1) {
	if (audio_is_playing(global.current_music)) {
		audio_stop_sound(global.current_music);
	}
	
	global.current_music = _sound;
	global.music_fade_time = _fade_in_time;
	global.music_fade_start = get_timer() / 1_000_000; // Convert to seconds
	global.music_fade_target_vol = global.music_vol;
	
	audio_play_sound(_sound, 1, true); // loop = true
	audio_sound_gain(_sound, 0, 0); // Start at 0 volume
}

/// @function stop_music_fade(_fade_out_time)
/// @description Stop music with fade-out effect
function stop_music_fade(_fade_out_time = 1) {
	if (audio_is_playing(global.current_music)) {
		global.music_fade_time = _fade_out_time;
		global.music_fade_start = get_timer() / 1_000_000;
		global.music_fade_target_vol = 0; // Fade to 0
	}
}

/// @function update_music_fade()
/// @description Update music fade effect (call in Step event)
function update_music_fade() {
	if (!variable_global_exists("current_music")) return;
	if (!audio_is_playing(global.current_music)) return;
	
	if (!variable_global_exists("music_fade_time")) return;
	
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
