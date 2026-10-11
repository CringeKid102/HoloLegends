if (instance_number(obj_quest_manager) > 1) {
	instance_destroy();
	exit;
}

global.quest_manager = id;
quest_init();