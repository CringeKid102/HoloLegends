// Determine state from the actual save data rather than file_exists, which can be unreliable right after launch.
ini_open(save_file);
is_new = (ini_read_real("Character", "Level", -1) == -1);
ini_close();

hovering = position_meeting(mouse_x, mouse_y, id);

if (mouse_check_button_pressed(mb_left) && hovering) {
    clicked = true;
}

if (mouse_check_button_released(mb_left)) {
    if (clicked && hovering) {
        global.save_file_name = save_file;

        if (!is_new) {
            // Save already exists, continue where the player left off.
            scr_load_game();
        } else {
            // No save yet, create a fresh one with default stats.
            if (!variable_global_exists("ds_stats") || !ds_exists(global.ds_stats, ds_type_list)) {
                global.ds_stats = ds_list_create();
            }
            global.ds_stats[| 0] = 0; // Character index
            global.ds_stats[| 1] = 1; // Level
            scr_save_game();
        }

        room_goto(rm_game);
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
