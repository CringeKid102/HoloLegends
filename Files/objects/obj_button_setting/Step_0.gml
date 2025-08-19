if (obj_title.y >= 300) {
    // Animation phases
    y -= 20;
    if (y <= target_y) {
        y = target_y;
    }

    // Button interaction
    hovering = position_meeting(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), id);

    if (hovering && mouse_check_button_pressed(mb_left)) {
        clicked = true;
    }

    if (!hovering) {
        hover_snd = false;
    }

    if (mouse_check_button_released(mb_left)) {
        if (clicked && hovering) {
            play_sfx(snd_button_press);
            room_goto(rm_setting);
        }
        clicked = false;
    }

    if (clicked) {
        image_index = 2;
        target_scale = 0.8;
        target_hover_offset = 0;
    } else if (hovering) {
        if (!hover_snd) {
            play_sfx(snd_button_hover);
            hover_snd = true;
        }
        image_index = 1;
        target_scale = 1;           // Slightly grow
        target_hover_offset = -13;     // Move upward
    } else {
        image_index = 0;
        target_scale = 0.8;
        target_hover_offset = 0;
    }

    scale = lerp(scale, target_scale, 0.2);
    hover_offset = lerp(hover_offset, target_hover_offset, 0.2);
}
