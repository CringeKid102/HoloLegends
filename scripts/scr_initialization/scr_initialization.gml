function scr_initialization() {
    // Default values
    global.music_vol = 0.8;
    global.sfx_vol = 0.8;
    global.language = 0;
    if (!variable_global_exists("current_music")) {
        global.current_music = noone;
    }
    global.save_file_name = "save1.ini";
    
    // Initialize playtime system
    if (!variable_global_exists("playtime")) {
        global.playtime = 0;
    }
    if (!variable_global_exists("playtime_session_start")) {
        global.playtime_session_start = get_timer();
    }
    
    // Initialize character stats
    if (!variable_global_exists("ds_stats")) {
        global.ds_stats = ds_list_create();
        global.ds_stats[| 0] = 0;  // Character index
        global.ds_stats[| 1] = 1;  // Level
        global.ds_stats[| 2] = 0;  // Experience
        global.ds_stats[| 3] = 100; // Health
        global.ds_stats[| 4] = 100; // Max Health
    }
    
    // Initialize inventory
    if (!variable_global_exists("inventory")) {
        global.inventory = ds_map_create();
        global.inventory_max_size = 20;
        global.inventory_item_count = 0;
    }
    
    // Game settings
    global.text_speed = 1.0;
    global.difficulty = 1;
    global.auto_save_enabled = true;
    
    // Try to load existing settings
    if (file_exists("settings.ini")) {
        try {
            ini_open("settings.ini");
            global.music_vol = clamp(ini_read_real("Audio", "MusicVolume", 0.8), 0, 1);
            global.sfx_vol = clamp(ini_read_real("Audio", "SFXVolume", 0.8), 0, 1);
            global.language = clamp(ini_read_real("General", "Language", 0), 0, 1);
            global.text_speed = clamp(ini_read_real("General", "TextSpeed", 1.0), 0.5, 2.0);
            global.difficulty = clamp(ini_read_real("General", "Difficulty", 1), 0, 2);
            ini_close();
        } catch (e) {
            show_debug_message("Failed to load settings: " + string(e));
        }
    }
    
    show_debug_message("Game initialized - All systems ready");
}