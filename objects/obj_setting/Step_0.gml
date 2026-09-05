var _mx = mouse_x, _my = mouse_y;

// Handle slider interactions
if (mouse_check_button_released(mb_left)) {
    // Play sound only if a slider was actually being dragged
    if (slider_grabbed != -1) {
        play_sfx(snd_slider_move);
    }
    slider_grabbed = -1;
	text_speed_slider_grabbed = false;
}

// Apply volume changes in real-time
if (audio_is_playing(global.current_music)) {
    audio_sound_gain(global.current_music, global.music_vol, 0);
}

// Handle button clicks
if (mouse_check_button_pressed(mb_left)) {
    // Language selection
    if (point_in_rectangle(_mx, _my, menu_x, 250, menu_x + 200, 300)) {
        if (language_selected != 0) {
            language_selected = 0;
            play_sfx(snd_button_press);
        }
    }
    else if (point_in_rectangle(_mx, _my, menu_x + 220, 250, menu_x + 420, 300)) {
        if (language_selected != 1) {
            language_selected = 1;
            play_sfx(snd_button_press);
        }
    }
    // Difficulty buttons
    else if (point_in_rectangle(_mx, _my, menu_x, 360, menu_x + 80, 390)) {
        difficulty_selected = 0; // Easy
        play_sfx(snd_button_press);
    }
    else if (point_in_rectangle(_mx, _my, menu_x + 100, 360, menu_x + 180, 390)) {
        difficulty_selected = 1; // Normal
        play_sfx(snd_button_press);
    }
    else if (point_in_rectangle(_mx, _my, menu_x + 200, 360, menu_x + 280, 390)) {
        difficulty_selected = 2; // Hard
        play_sfx(snd_button_press);
    }
    // Fullscreen toggle button
    else if (point_in_rectangle(_mx, _my, menu_x, 410, menu_x + 100, 440)) {
        fullscreen_toggle = !fullscreen_toggle;
        window_set_fullscreen(fullscreen_toggle);
        play_sfx(snd_button_press);
    }
    // Text speed slider
    else if (point_in_rectangle(_mx, _my, 250, 455, 450, 475)) {
        text_speed_slider_grabbed = true;
        slider_grabbed = 3; // Mark as slider interaction
    }
    // Save button
    else if (point_in_rectangle(_mx, _my, menu_x, menu_y, menu_x + button_width, menu_y + button_height)) {
        save_settings();
        play_sfx(snd_button_press);
    }
    // Exit button
    else if (point_in_rectangle(_mx, _my, menu_x + 150, menu_y, menu_x + 150 + button_width, menu_y + button_height)) {
        play_sfx(snd_button_press);
        room_goto(rm_menu);
    }
}

// Update text speed slider when grabbed
if (text_speed_slider_grabbed) {
	text_speed_value = clamp((_mx - 250) / 200, 0.5, 2.0);
	global.text_speed = text_speed_value;
}

// Handle keyboard shortcuts
if (keyboard_check_pressed(vk_escape)) {
    room_goto(rm_menu);
}

// Save message timer
if (save_message_visible && --save_message_timer <= 0) {
    save_message_visible = false;
}