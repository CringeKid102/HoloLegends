draw_set_font(fnt_main);
draw_set_halign(fa_left);
draw_set_color(c_white);

draw_text(menu_x, 60, global.language == 0 ? "Settings" : "設定");

// Language buttons
draw_text(menu_x, 200, global.language == 0 ? "Language" : "言語");
draw_btn(menu_x, 250, 200, 50, "English", mouse_x, mouse_y);
draw_btn(menu_x + 220, 250, 200, 50, "日本語", mouse_x, mouse_y);

if (language_selected == 0) {
    draw_set_color(c_yellow); draw_set_alpha(0.3);
    draw_rectangle(menu_x, 250, menu_x + 200, 300, false);
} else {
    draw_set_color(c_yellow); draw_set_alpha(0.3);
    draw_rectangle(menu_x + 220, 250, menu_x + 420, 300, false);
}
draw_set_alpha(1); draw_set_color(c_white);

// Sliders
draw_text(menu_x, 110, global.language == 0 ? "Music Volume" : "音楽音量");
global.music_vol = draw_slider(menu_x + 400, 130, slider_width, global.music_vol, 0);

draw_text(menu_x, 150, global.language == 0 ? "SFX Volume" : "効果音音量");
global.sfx_vol = draw_slider(menu_x + 400, 170, slider_width, global.sfx_vol, 1);

// Save / Exit
draw_btn(menu_x, menu_y, button_width, button_height, global.language == 0 ? "Save" : "保存", mouse_x, mouse_y);
draw_btn(menu_x + 150, menu_y, button_width, button_height, global.language == 0 ? "Exit" : "終了", mouse_x, mouse_y);

// Save confirmation
if (save_message_visible) {
    var alpha = min(1, save_message_timer / 30);
    draw_set_alpha(alpha);
    draw_set_color(c_lime);
    draw_text(menu_x + 50, 470, global.language == 0 ? "Settings Saved" : "設定を保存しました");
    draw_set_alpha(1);
    draw_set_color(c_white);
}