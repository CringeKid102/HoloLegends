function play_sfx(_sound) {
    if (_sound == -1) {
        return -1;
    }

    var _snd = audio_play_sound(_sound, 1, false);
    if (_snd == -1) {
        return -1;
    }

    var _vol = 1;
    if (variable_global_exists("sfx_vol")) {
        _vol = clamp(global.sfx_vol, 0, 1);
    }

    audio_sound_gain(_snd, _vol, 0);
    return _snd;
}