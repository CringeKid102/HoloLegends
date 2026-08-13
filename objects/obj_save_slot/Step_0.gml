hovering = position_meeting(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), id);

if (mouse_check_button_pressed(mb_left) && hovering) {
    clicked = true;
}

if (mouse_check_button_released(mb_left)) {
    // Keep this as a hook for opening/selecting a specific save file.
    if (clicked && hovering) {
        // TODO: Add save slot selection logic.
    }
    clicked = false;
}

if (clicked) {
    image_index = 1;
} else {
    image_index = 0;
}

target_hover_offset = hovering ? -10 : 0;
hover_offset = lerp(hover_offset, target_hover_offset, 0.2);
