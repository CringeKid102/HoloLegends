if (!variable_global_exists("selected_option")) {
	global.selected_option = 0;
}

if (!variable_global_exists("max_options")) {
	global.max_options = 1;
}

var option_count = max(1, global.max_options);

if (global.selected_option + 1 < option_count) global.selected_option++;
else global.selected_option = 0;