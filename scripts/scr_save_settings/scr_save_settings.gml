function save_settings() {
    try {
        // Check if required variables exist
        if (!variable_instance_exists(id, "keybinds") || !ds_exists(keybinds, ds_type_map)) {
            show_debug_message("Warning: keybinds not properly initialized");
        }
        
        if (!variable_instance_exists(id, "language_selected")) {
            show_debug_message("Warning: language_selected not found");
            return;
        }
        
        ini_open("settings.ini");
        
        // Audio settings
        ini_write_real("Audio", "MusicVolume", global.music_vol);
        ini_write_real("Audio", "SFXVolume", global.sfx_vol);
        
        // General settings
        global.language = language_selected;
        ini_write_real("General", "Language", global.language);
        ini_write_real("General", "TextSpeed", global.text_speed);
        ini_write_real("General", "Difficulty", difficulty_selected);
        ini_write_real("General", "Fullscreen", window_get_fullscreen() ? 1 : 0);
        
        // Keybinds (if they exist)
        if (variable_instance_exists(id, "keybinds") && ds_exists(keybinds, ds_type_map)) {
            var key = ds_map_find_first(keybinds);
            while (!is_undefined(key)) {
                ini_write_real("Keybinds", key, ds_map_find_value(keybinds, key));
                key = ds_map_find_next(keybinds, key);
            }
        }
        
        ini_close();
        
        // Show success message (if variables exist)
        if (variable_instance_exists(id, "save_message_visible")) {
            save_message_visible = true;
            save_message_timer = save_message_duration;
        }
        
        // Play success sound
        play_sfx(snd_select);
        
    } catch (e) {
        show_debug_message("Failed to save settings: " + string(e));
    }
}