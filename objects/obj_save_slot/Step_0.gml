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
            if (scr_load_game()) {
                room_goto(global.pending_load_room);
            }
        } else {
            // Reset every run-owned system before creating a fresh slot.
            if (!variable_global_exists("ds_stats") || !ds_exists(global.ds_stats, ds_type_list)) {
                global.ds_stats = ds_list_create();
            }
            ds_list_clear(global.ds_stats);
            global.ds_stats[| 0] = 0; // Character index
            global.ds_stats[| 1] = 1; // Level
            global.ds_stats[| 2] = 0; // Experience
            global.ds_stats[| 3] = 100; // Health
            global.ds_stats[| 4] = 100; // Max health
            if (!variable_global_exists("inventory") || !ds_exists(global.inventory, ds_type_map)) {
                global.inventory = ds_map_create();
            }
            ds_map_clear(global.inventory);
            global.inventory_item_count = 0;
            quest_reset_all();
            global.pending_load_room = rm_game;
            global.pending_player_x = 960;
            global.pending_player_y = 540;
            global.pending_player_position = true;
            scr_save_game();
            room_goto(rm_game);
        }
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
