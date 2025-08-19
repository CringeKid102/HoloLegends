if (state == e_states.choose_save_slot) {
    
    #region CHOOSE SAVE SLOT
    
    if (keyboard_check_pressed(vk_up)) scr_negative_input();
    if (keyboard_check_pressed(vk_up)) scr_negative_input();
        
    if (keyboard_check_pressed(vk_space)) {
        
        #region START NEW GAME / LOAD GAME
        
        save_file_name = "save_" + string(selected_option);
        
        if (file_exists(save_file_name) == false) {
            state = e_states.choose_character;
            selected_option = 0;
            max_options = e_characters.last;
        } else scr_load_game();
        
        #endregion
        
    } else {
        if (keyboard_check_pressed(vk_backspace)) {
            save_file_name = "save_" + string(selected_option);
            file_delete(save_file_name);
        }
    }
    
    #endregion
    
} else {
    if (state == e_states.choose_character) {
        
        #region CHOOSE CHARCATER
        
        if (keyboard_check_pressed(vk_left)) scr_negative_input();
        if (keyboard_check_pressed(vk_right)) scr_positive_input();
            
        if (keyboard_check_pressed(vk_space)) {
            ds_stats[| e_character_stats.character] = selected_option;
            ds_stats[| e_character_stats.level] = 1;
            
            scr_save_game();
            
            state = e_states.playing_game;
        }
        
        #endregion
        
    } else {
        if (state == e_states.playing_game) {
            room_goto(rm_game);
        }
    }
}