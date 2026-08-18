hovering = position_meeting(mouse_x, mouse_y, id);

if (mouse_check_button_pressed(mb_left) && hovering) {
    clicked = true;
}

if (mouse_check_button_released(mb_left)) {
    if (clicked && hovering) {
        var _save_file = "save" + string(slot_index + 1) + ".ini";
        if (file_exists(_save_file)) {
            file_delete(_save_file);
        }
    }
    clicked = false;
}

image_index = (clicked || hovering) ? 1 : 0;
