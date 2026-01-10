function save_settings() {
    try {
        ini_open("settings.ini");
        
        // Audio settings
        ini_write_real("Audio", "MusicVolume", global.music_vol);
        ini_write_real("Audio", "SFXVolume", global.sfx_vol);
        
        // Language setting
        global.language = language_selected;
        ini_write_real("General", "Language", global.language);
        
        // Keybinds
        var key = ds_map_find_first(keybinds);
        while (!is_undefined(key)) {
            ini_write_real("Keybinds", key, ds_map_find_value(keybinds, key));
            key = ds_map_find_next(keybinds, key);
        }
        
        ini_close();
        
        // Show success message
        save_message_visible = true;
        save_message_timer = save_message_duration;
        
        // Play success sound
        play_sfx(snd_save_success);
        
    } catch (e) {
        show_debug_message("Failed to save settings: " + string(e));
        // Could show error message here
    }
}