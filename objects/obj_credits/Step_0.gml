var _mx = mouse_x, _my = mouse_y;

// Button handling
if (mouse_check_button_pressed(mb_left)) {
    if (point_in_rectangle(_mx, _my, menu_x, menu_y, menu_x + button_width, menu_y + button_height)) {
        room_goto(rm_menu);
    }
}