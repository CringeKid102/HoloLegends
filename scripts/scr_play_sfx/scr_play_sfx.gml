function play_sfx(_sound) {
    var _snd = audio_play_sound(_sound, 1, false);
    audio_sound_gain(_snd, global.sfx_vol, 0);
    return _snd;
}