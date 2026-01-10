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

if (file_exists("settings.ini")) {
    ini_open("settings.ini");
    global.music_vol = ini_read_real("Audio", "MusicVolume", global.music_vol);
    global.sfx_vol = ini_read_real("Audio", "SFXVolume", global.sfx_vol);
    global.language = ini_read_real("General", "Language", global.language);
    ini_close();
}

language_selected = global.language;
play_music(snd_menu_music);