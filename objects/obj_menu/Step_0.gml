/// Quick save with Ctrl+S (anywhere in game except menu)
if (keyboard_check_pressed(vk_control) && keyboard_check_pressed(ord("S"))) {
	quick_save();
	show_debug_message("Quick saved!");
}

/// Quick load with Ctrl+L (anywhere in game except menu)
if (keyboard_check_pressed(vk_control) && keyboard_check_pressed(ord("L"))) {
	if (quick_load()) {
		show_debug_message("Quick loaded!");
	}
}
