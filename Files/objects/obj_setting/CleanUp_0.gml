if (global.current_music != noone && audio_is_playing(global.current_music)) {
    audio_stop_sound(global.current_music);
}