menu_x = 680
menu_y = 280
button_width = 100;
button_height = 50;

// Initialize with default values
global.music_vol = 0.7;
global.sfx_vol = 0.7;
global.language = 0; // Default to English

// Load saved settings
if (file_exists("settings.ini")) {
    ini_open("settings.ini");
    global.music_vol = ini_read_real("Audio", "MusicVolume", global.music_vol);
    global.sfx_vol = ini_read_real("Audio", "SFXVolume", global.sfx_vol);
    global.language = ini_read_real("General", "Language", global.language);
    
    ini_close();
}