ini_open(save_file_name);

ini_write_real("Character", "Index", ds_stats[| e_character_stats.character]);
ini_write_real("Character", "Level", ds_stats[| e_character_stats.level]);

ini_close();

show_message("Game Saved");