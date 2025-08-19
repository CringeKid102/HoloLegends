enum e_states{
    choose_save_slot,
    choose_character,
    playing_game,
}

enum e_characters {
    char1,
    char2,
    char3,
    char4,
    last,
}

enum e_character_stats {
    character,
    level,
    last,
}

state = e_states.choose_save_slot;

total_save_slots = 3;
selected_option = 0;
max_options = total_save_slots;

ds_stats = ds_list_create();