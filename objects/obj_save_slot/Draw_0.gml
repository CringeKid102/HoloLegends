draw_sprite(sprite_index, image_index, x, y + hover_offset);

if (is_new) {
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(x, y + hover_offset, "NEW GAME");
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
