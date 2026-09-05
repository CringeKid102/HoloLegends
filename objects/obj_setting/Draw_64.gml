/// @description Draw settings menu with all options
draw_set_color(c_white);
draw_set_alpha(1);
draw_set_font(fnt_main);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

// Draw semi-transparent background
draw_set_alpha(0.7);
draw_rectangle(0, 0, gui_w, gui_h, false);
draw_set_alpha(1);

// Title
draw_set_color(c_white);
draw_text(menu_x, menu_y - 150, "SETTINGS");

// Audio Settings Section
draw_text(menu_x, menu_y - 100, "AUDIO");
draw_text(menu_x, menu_y - 70, "Music Volume:");
draw_rectangle(menu_x + 100, menu_y - 70, menu_x + 100 + slider_width, menu_y - 50, true); // Placeholder
draw_text(menu_x + 100 + (slider_width * global.music_vol), menu_y - 70, "|"); // Slider indicator

draw_text(menu_x, menu_y - 30, "SFX Volume:");
draw_rectangle(menu_x + 100, menu_y - 30, menu_x + 100 + slider_width, menu_y - 10, true); // Placeholder
draw_text(menu_x + 100 + (slider_width * global.sfx_vol), menu_y - 30, "|"); // Slider indicator

// Language Settings Section
draw_text(menu_x, menu_y + 20, "LANGUAGE");
draw_set_color(language_selected == 0 ? c_yellow : c_white);
draw_rectangle(menu_x, 250, menu_x + 90, 280, false); // English button
draw_text(menu_x + 45, 265, "ENGLISH");

draw_set_color(language_selected == 1 ? c_yellow : c_white);
draw_rectangle(menu_x + 110, 250, menu_x + 200, 280, false); // Japanese button
draw_text(menu_x + 155, 265, "日本語");

draw_set_color(c_white);

// Difficulty Settings Section
draw_text(menu_x, 330, "DIFFICULTY");
draw_set_color(difficulty_selected == 0 ? c_lime : c_white);
draw_rectangle(menu_x, 360, menu_x + 80, 390, false);
draw_text(menu_x + 40, 375, "EASY");

draw_set_color(difficulty_selected == 1 ? c_yellow : c_white);
draw_rectangle(menu_x + 100, 360, menu_x + 180, 390, false);
draw_text(menu_x + 140, 375, "NORMAL");

draw_set_color(difficulty_selected == 2 ? c_red : c_white);
draw_rectangle(menu_x + 200, 360, menu_x + 280, 390, false);
draw_text(menu_x + 240, 375, "HARD");

draw_set_color(c_white);

// Fullscreen Toggle Section
draw_text(menu_x, 410, "FULLSCREEN");
draw_rectangle(menu_x, 410, menu_x + 100, 440, false);
draw_text(menu_x + 50, 425, fullscreen_toggle ? "ON" : "OFF");

// Text Speed Section
draw_text(menu_x, 455, "TEXT SPEED");
draw_rectangle(250, 455, 450, 475, true); // Slider placeholder
var speed_indicator = 250 + ((text_speed_value - 0.5) / 1.5) * 200;
draw_rectangle(speed_indicator - 5, 455, speed_indicator + 5, 475, false); // Slider bar
draw_text(menu_x + 270, 480, string_format(text_speed_value, 1, 1) + "x");

// Save/Load Section
draw_text(menu_x, menu_y, "SAVE/LOAD");

// Playtime display (inline calculation)
var playtime_str = "0:00:00";
if (variable_global_exists("playtime")) {
	var total_seconds = global.playtime;
	var hours = floor(total_seconds div 3600);
	var minutes = floor((total_seconds mod 3600) div 60);
	var seconds = floor(total_seconds mod 60);
	playtime_str = string(hours) + ":" + string_pad(string(minutes), 2, "0") + ":" + string_pad(string(seconds), 2, "0");
}
draw_text(menu_x, menu_y + 30, "Playtime: " + playtime_str);

// Buttons
draw_set_color(c_white);
draw_rectangle(menu_x, menu_y, menu_x + button_width, menu_y + button_height, false);
draw_text(menu_x + button_width / 2, menu_y + button_height / 2, "SAVE");

draw_rectangle(menu_x + 150, menu_y, menu_x + 150 + button_width, menu_y + button_height, false);
draw_text(menu_x + 150 + button_width / 2, menu_y + button_height / 2, "EXIT");

// Success message
if (save_message_visible) {
	draw_set_color(c_lime);
	draw_text(menu_x, gui_h - 50, "Settings saved!");
}

draw_set_color(c_white);
draw_set_alpha(1);
