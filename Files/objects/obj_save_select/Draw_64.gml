if (state == e_states.choose_save_slot) {
    
    #region CHOOSE SAVE SLOT
    
    for (var i = 0; i < total_save_slots; i++) {
        var drawX = display_get_width() / 2;
        var drawY = 60 + (i * (sprite_get_height(spr_save_slot) * 1.5));
        
        if (selected_option == i) {
            var index = i;
            draw_set_color(c_white);
        } else {
            index = 0;
            draw_set_color(c_gray);
        }
        
        draw_sprite(spr_save_slot, index, drawX, drawY);
        
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
    
        if (file_exists("save" + string(i)) == false) {
            var text = "No Data";
        } else text = "Ready to Play";
            
        draw_text(drawX, drawY, text)
    }
    
    #endregion
    
}

if (state == e_states.choose_character) {
    
    #region CHOOSE CHARACTER
    
    for (var i = 0; i < e_characters.last; i++) {
        var drawX = 20 + (i * (sprite_get_width(spr_characters) * 2));
        var drawY = sprite_get_height(spr_characters);
        
        draw_sprite(spr_characters, i, drawX, drawY);
        
        if (i == selected_option) draw_sprite(spr_selected, 0, drawX, drawY)
    }
    
    #endregion
    
}
if (state == e_states.choose_character) {
    
    #region PLAYING THE GAME
    
    var index = ds_stats[| e_character_stats.character];
    var level = ds_stats[| e_character_stats.level];
    var drawX = display_get_gui_width() / 2;
    var drawY = display_get_gui_height() / 2;
    
    draw_sprite(spr_characters, index, drawX, drawY)
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    draw_set_color(c_white);
    
    draw_text(drawX, drawY - sprite_get_height(spr_characters) / 2, string(level));
    
    #endregion
    
}