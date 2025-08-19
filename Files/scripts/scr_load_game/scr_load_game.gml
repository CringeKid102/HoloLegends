ini_open(save_file_name);

ds_stats[| e_character_stats.character] = ini_read_real("Character", "Index", -1);
ds_stats[| e_character_stats.level] = ini_read_real("Character", "Level", -1);

ini_close();

state = e_states.playing_game;

show_message("Game Loaded")