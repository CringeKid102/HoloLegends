keybinds = ds_map_create();
ds_map_add(keybinds, "move_left", ord("A"));
ds_map_add(keybinds, "move_right", ord("D"));
ds_map_add(keybinds, "move_up", ord("W"));
ds_map_add(keybinds, "move_down", ord("S"));

menu_x = 50;
menu_y = 340;
slider_width = 200;
keybind_start_y = 280;
keybind_spacing = 40;
button_width = 100;
button_height = 50;

slider_grabbed = -1;
save_message_visible = false;
save_message_timer = 0;
save_message_duration = 90;
language_selected = 0;

// Ensure global variables exist
if (!variable_global_exists("music_vol")) {
    global.music_vol = 0.8;
}
if (!variable_global_exists("sfx_vol")) {
    global.sfx_vol = 0.8;
}
if (!variable_global_exists("language")) {
    global.language = 0;
}
if (!variable_global_exists("current_music")) {
    global.current_music = noone;
}

// Load saved settings if they exist
if (file_exists("settings.ini")) {
    try {
        ini_open("settings.ini");
        global.music_vol = clamp(ini_read_real("Audio", "MusicVolume", global.music_vol), 0, 1);
        global.sfx_vol = clamp(ini_read_real("Audio", "SFXVolume", global.sfx_vol), 0, 1);
        global.language = clamp(ini_read_real("General", "Language", global.language), 0, 1);
        ini_close();
    } catch (e) {
        show_debug_message("Error loading settings: " + string(e));
    }
}

language_selected = global.language;
play_music(snd_menu_music);

// Additional settings for text speed, fullscreen, and difficulty
if (!variable_global_exists("text_speed")) {
	global.text_speed = 1.0;
}
if (!variable_global_exists("difficulty")) {
	global.difficulty = 1;
}

text_speed_slider_grabbed = false;
text_speed_value = global.text_speed; // Local copy for slider
fullscreen_toggle = window_get_fullscreen();
difficulty_selected = global.difficulty; // 0 = Easy, 1 = Normal, 2 = Hard

// Load additional settings
if (file_exists("settings.ini")) {
	try {
		ini_open("settings.ini");
		global.text_speed = clamp(ini_read_real("General", "TextSpeed", 1.0), 0.5, 2.0);
		global.difficulty = clamp(ini_read_real("General", "Difficulty", 1), 0, 2);
		ini_close();
		text_speed_value = global.text_speed;
		difficulty_selected = global.difficulty;
	} catch (e) {
		show_debug_message("Error loading additional settings: " + string(e));
	}
}