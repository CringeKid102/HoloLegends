hovering = false;
clicked = false;
hover_snd = false;
scale = 0.8;
target_scale = 1;
hover_offset = 0;
target_hover_offset = 0;

if (room == rm_game) {
	instance_create_layer(960, 540, "Instances", obj_player);
	instance_create_layer(960, 540, "Instances", obj_camera);
	instance_create_layer(640, 400, "Instances", obj_placeholder_npc);
	instance_create_layer(1280, 400, "Instances", obj_placeholder_save);
	instance_create_layer(1600, 700, "Instances", obj_placeholder_exit);
	instance_create_layer(960, 260, "Instances", obj_placeholder_guide);
}
