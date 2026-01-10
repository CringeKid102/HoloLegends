/// @function draw_btn(x, y, width, height, text, mouse_x, mouse_y)
/// @description Draws a button with text origin at its center
function draw_btn(x, y, width, height, text, mouse_x, mouse_y) {
    // Check hover state
    var _hover = point_in_rectangle(mouse_x, mouse_y, x, y, x + width, y + height);
    
    // Draw button outline (white/yellow border)
    draw_set_color(_hover ? c_yellow : c_white);
    draw_rectangle(x, y, x + width, y + height, false);
    
    // Save old alignment settings (to avoid side effects)
    var _old_halign = draw_get_halign();
    var _old_valign = draw_get_valign();
    
    // Set text origin to CENTER (both horizontally and vertically)
    draw_set_halign(fa_center);  // Horizontal center
    draw_set_valign(fa_middle); // Vertical middle
    
    // Draw text (black) with origin at the button's center
    draw_set_color(c_black);
    draw_text(x + width/2, y + height/2, text); // Now perfectly centered
    
    // Restore alignment (critical for other drawing operations)
    draw_set_halign(_old_halign);
    draw_set_valign(_old_valign);
}