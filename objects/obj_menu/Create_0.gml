scr_initialization();
if (!instance_exists(obj_quest_manager)) {
	instance_create_layer(0, 0, "Instances", obj_quest_manager);
}
play_music(snd_menu_music);