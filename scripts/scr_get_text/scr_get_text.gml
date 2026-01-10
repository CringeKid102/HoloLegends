// scr_get_text
function get_text(english, japanese) {
    if (!variable_global_exists("language")) {
        return english; // Default to English if language isn't set
    }
    return global.language == 0 ? english : japanese;
}