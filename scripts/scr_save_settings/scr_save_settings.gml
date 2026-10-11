function save_settings(_settings_instance) {
    try {
        if (!instance_exists(_settings_instance)) {
            return false;
        }

        var _keybinds = noone;
        if (variable_instance_exists(_settings_instance, "keybinds")) {
            _keybinds = variable_instance_get(_settings_instance, "keybinds");
        }
        if (!ds_exists(_keybinds, ds_type_map)) {
            show_debug_message("Warning: keybinds not properly initialized");
        }

        if (!variable_instance_exists(_settings_instance, "language_selected")) {
            show_debug_message("Warning: language_selected not found");
            return false;
        }

        var _language = variable_instance_get(_settings_instance, "language_selected");
        var _difficulty = variable_instance_get(_settings_instance, "difficulty_selected");
        ini_open("settings.ini");

        // Audio settings
        ini_write_real("Audio", "MusicVolume", global.music_vol);
        ini_write_real("Audio", "SFXVolume", global.sfx_vol);

        // General settings
        global.language = _language;
        ini_write_real("General", "Language", global.language);
        ini_write_real("General", "TextSpeed", global.text_speed);
        ini_write_real("General", "Difficulty", _difficulty);
        ini_write_real("General", "Fullscreen", window_get_fullscreen() ? 1 : 0);

        // Keybinds (if they exist)
        if (ds_exists(_keybinds, ds_type_map)) {
            var key = ds_map_find_first(_keybinds);
            while (!is_undefined(key)) {
                ini_write_real("Keybinds", key, ds_map_find_value(_keybinds, key));
                key = ds_map_find_next(_keybinds, key);
            }
        }

        ini_close();

        // Show success message (if variables exist)
        if (variable_instance_exists(_settings_instance, "save_message_visible")) {
            variable_instance_set(_settings_instance, "save_message_visible", true);
            variable_instance_set(_settings_instance, "save_message_timer", variable_instance_get(_settings_instance, "save_message_duration"));
        }

        // Play success sound
        play_sfx(snd_select);

        return true;
    } catch (e) {
        show_debug_message("Failed to save settings: " + string(e));
        return false;
    }
}