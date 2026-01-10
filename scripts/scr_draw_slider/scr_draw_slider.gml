function draw_slider(x, y, width, value, slider_index, label) {
    var _mx = mouse_x;
    var _my = mouse_y;
    
    // Expanded hit area
    var hit_x1 = x - 5;
    var hit_x2 = x + width + 5;
    var hit_y1 = y - 10;
    var hit_y2 = y + 20;
    
    var is_hovered = point_in_rectangle(_mx, _my, hit_x1, hit_y1, hit_x2, hit_y2);
    var is_active = (slider_grabbed == slider_index);
    
    // Handle interaction
    if (mouse_check_button_pressed(mb_left) && is_hovered) {
        slider_grabbed = slider_index;
    }
    
    // Update value if active
    if (is_active && mouse_check_button(mb_left)) {
        var old_value = value;
        value = clamp((_mx - x) / width, 0, 1);
    }
    
    // Visual styling
    var track_color = is_active ? c_aqua : (is_hovered ? c_ltgray : c_gray);
    var handle_color = is_active ? c_white : (is_hovered ? c_ltgray : c_white);
    
    // Draw track background
    draw_set_color(c_dkgray);
    draw_rectangle(x, y + 2, x + width, y + 8, false);
    
    // Draw filled portion
    draw_set_color(track_color);
    draw_rectangle(x, y + 2, x + (value * width), y + 8, false);
    
    // Draw handle
    var handle_x = x + (value * width);
    draw_set_color(handle_color);
    draw_circle(handle_x, y + 5, 6, false);
    draw_set_color(c_black);
    draw_circle(handle_x, y + 5, 6, true);
    
    // Draw percentage text
    draw_set_color(c_white);
    draw_set_halign(fa_right);
    draw_text(x + width + 70, y - 10, string(floor(value * 100)) + "%");
    draw_set_halign(fa_left);
    
    return value;
}