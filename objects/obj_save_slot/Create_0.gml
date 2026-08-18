image_speed = 0;
image_index = 0;

hovering = false;
clicked = false;
hover_offset = 0;
target_hover_offset = 0;

// Derived from room x position so it stays stable across room re-entries.
slot_index = round((x - 460) / 500);

save_file = "save" + string(slot_index + 1) + ".ini";

ini_open(save_file);
is_new = (ini_read_real("Character", "Level", -1) == -1);
ini_close();
