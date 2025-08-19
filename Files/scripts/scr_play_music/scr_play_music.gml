function play_music(_sound) {
    if (audio_is_playing(global.current_music)) {
        audio_stop_sound(global.current_music);
    }
    global.current_music = _sound;
    audio_play_sound(_sound, 1, true); // loop = true
    audio_sound_gain(_sound, global.music_vol, 0); // apply current volume
}