draw_sprite_ext(spr_box, 0, x, y, placeholder_scale, placeholder_scale, 0, placeholder_color, 1);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);
draw_text(x, y - 80, placeholder_label);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
