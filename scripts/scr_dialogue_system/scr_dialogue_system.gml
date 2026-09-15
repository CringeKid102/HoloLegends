/// @function create_dialogue(myText, mySpeaker, myEffects, myTextSpeed, myTypes, myNextLine, myScripts, myTextCol, myEmotion, myEmote)
/// @description Creates a dialogue textbox instance with the provided parameters
function create_dialogue(_text, _speaker, _effects, _text_speed, _types, _next_line, _scripts, _text_col, _emotion, _emote) {
	var _textbox = instance_create_layer(0, 0, "Instances", obj_textbox);
	variable_instance_set(_textbox, "text", _text);
	variable_instance_set(_textbox, "speaker", _speaker);
	variable_instance_set(_textbox, "effects", _effects);
	variable_instance_set(_textbox, "text_speed", _text_speed);
	variable_instance_set(_textbox, "type", _types);
	variable_instance_set(_textbox, "nextline", _next_line);
	variable_instance_set(_textbox, "executeScript", _scripts);
	variable_instance_set(_textbox, "text_col", _text_col);
	variable_instance_set(_textbox, "emotion", _emotion);
	variable_instance_set(_textbox, "emotes", _emote);
	with (_textbox) alarm[0] = 1; // Trigger setup
	
	return _textbox;
}

/// @function create_textevent(text, speaker, effects, text_speed, types, next_line, scripts, text_col, emotion, emote)
/// @description Creates a one-time text event that appears at game start
function create_textevent(_text, _speaker, _effects, _text_speed, _types, _next_line, _scripts, _text_col, _emotion, _emote) {
	var _textevent = instance_create_layer(0, 0, "Instances", obj_textevent);
	variable_instance_set(_textevent, "myText", _text);
	variable_instance_set(_textevent, "mySpeaker", _speaker);
	variable_instance_set(_textevent, "myEffects", _effects);
	variable_instance_set(_textevent, "myTextSpeed", _text_speed);
	variable_instance_set(_textevent, "myTypes", _types);
	variable_instance_set(_textevent, "myNextLine", _next_line);
	variable_instance_set(_textevent, "myScripts", _scripts);
	variable_instance_set(_textevent, "myTextCol", _text_col);
	variable_instance_set(_textevent, "myEmotion", _emotion);
	variable_instance_set(_textevent, "myEmote", _emote);
	event_perform_object(_textevent, ev_other, 10); // Set up dialogue
	
	return _textevent;
}
