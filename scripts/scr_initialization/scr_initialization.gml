function scr_initialization() {
    // Default values
    global.music_vol = 0.8;
    global.sfx_vol = 0.8;
    global.language = 0;
    global.current_music = noone;
    
    // Try to load existing settings
    if (file_exists("settings.ini")) {
        try {
            ini_open("settings.ini");
            global.music_vol = clamp(ini_read_real("Audio", "MusicVolume", 0.8), 0, 1);
            global.sfx_vol = clamp(ini_read_real("Audio", "SFXVolume", 0.8), 0, 1);
            global.language = clamp(ini_read_real("General", "Language", 0), 0, 1);
            ini_close();
        } catch (e) {
            show_debug_message("Failed to load settings: " + string(e));
            // Fallback to defaults
        }
    }
}