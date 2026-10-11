/// @function create_dialogue(myText, mySpeaker, myEffects, myTextSpeed, myTypes, myNextLine, myScripts, myTextCol, myEmotion, myEmote)
/// @description Creates a dialogue textbox instance with the provided parameters
function dialogue_get_line_value(_value, _line, _default) {
	if (is_array(_value)) {
		if (_line < array_length_1d(_value)) return _value[_line];
		return _default;
	}
	if (is_undefined(_value)) return _default;
	return _value;
}

function create_dialogue(_text, _speaker = -1, _effects = -1, _text_speed = -1, _types = 0, _next_line = -1, _scripts = -1, _text_col = -1, _emotion = -1, _emote = -1) {
	var _line_count = is_array(_text) ? array_length_1d(_text) : 1;
	_line_count = max(1, _line_count);
	var _texts = array_create(_line_count);
	var _speakers = array_create(_line_count, -1);
	var _effects_by_line = array_create(_line_count);
	var _speed_by_line = array_create(_line_count);
	var _types_by_line = array_create(_line_count, 0);
	var _next_by_line = array_create(_line_count, 0);
	var _scripts_by_line = array_create(_line_count, -1);
	var _colors_by_line = array_create(_line_count);
	var _emotion_by_line = array_create(_line_count, 0);
	var _emotes_by_line = array_create(_line_count, -1);
	var _names = array_create(_line_count, "None");
	var _portraits = array_create(_line_count, -1);
	var _voices = array_create(_line_count, -1);
	var _fonts = array_create(_line_count, fnt_main);
	var _portrait_talk = array_create(_line_count, -1);
	var _portrait_talk_x = array_create(_line_count, -1);
	var _portrait_talk_y = array_create(_line_count, -1);
	var _portrait_talk_n = array_create(_line_count, 0);
	var _portrait_talk_s = array_create(_line_count, 0);
	var _portrait_idle = array_create(_line_count, -1);
	var _portrait_idle_x = array_create(_line_count, -1);
	var _portrait_idle_y = array_create(_line_count, -1);
	var _portrait_idle_n = array_create(_line_count, 0);
	var _portrait_idle_s = array_create(_line_count, 0);

	for (var _line = 0; _line < _line_count; _line++) {
		_texts[_line] = dialogue_get_line_value(_text, _line, "");
		_speakers[_line] = dialogue_get_line_value(_speaker, _line, -1);
		_effects_by_line[_line] = dialogue_get_line_value(_effects, _line, -1);
		if (_effects_by_line[_line] == -1) _effects_by_line[_line] = [];
		_speed_by_line[_line] = dialogue_get_line_value(_text_speed, _line, -1);
		if (_speed_by_line[_line] == -1) _speed_by_line[_line] = [1, 1];
		_types_by_line[_line] = dialogue_get_line_value(_types, _line, 0);
		if (_types_by_line[_line] == -1) _types_by_line[_line] = 0;
		_next_by_line[_line] = dialogue_get_line_value(_next_line, _line, 0);
		if (!is_array(_next_line) && _next_by_line[_line] == -1) _next_by_line[_line] = 0;
		_scripts_by_line[_line] = dialogue_get_line_value(_scripts, _line, -1);
		_colors_by_line[_line] = dialogue_get_line_value(_text_col, _line, -1);
		if (_colors_by_line[_line] == -1) _colors_by_line[_line] = [];
		_emotion_by_line[_line] = dialogue_get_line_value(_emotion, _line, 0);
		if (_emotion_by_line[_line] == -1) _emotion_by_line[_line] = 0;
		_emotes_by_line[_line] = dialogue_get_line_value(_emote, _line, -1);

		var _speaker_instance = _speakers[_line];
		if (_speaker_instance == obj_player) _speaker_instance = instance_find(obj_player, 0);
		_speakers[_line] = _speaker_instance;
		if (instance_exists(_speaker_instance)) {
			if (variable_instance_exists(_speaker_instance, "myName")) _names[_line] = variable_instance_get(_speaker_instance, "myName");
			if (variable_instance_exists(_speaker_instance, "myPortrait")) _portraits[_line] = variable_instance_get(_speaker_instance, "myPortrait");
			if (variable_instance_exists(_speaker_instance, "myVoice")) _voices[_line] = variable_instance_get(_speaker_instance, "myVoice");
			if (variable_instance_exists(_speaker_instance, "myFont")) _fonts[_line] = variable_instance_get(_speaker_instance, "myFont");
			if (variable_instance_exists(_speaker_instance, "myPortraitTalk")) _portrait_talk[_line] = variable_instance_get(_speaker_instance, "myPortraitTalk");
			if (variable_instance_exists(_speaker_instance, "myPortraitTalk_x")) _portrait_talk_x[_line] = variable_instance_get(_speaker_instance, "myPortraitTalk_x");
			if (variable_instance_exists(_speaker_instance, "myPortraitTalk_y")) _portrait_talk_y[_line] = variable_instance_get(_speaker_instance, "myPortraitTalk_y");
			if (variable_instance_exists(_speaker_instance, "myPortraitIdle")) _portrait_idle[_line] = variable_instance_get(_speaker_instance, "myPortraitIdle");
			if (variable_instance_exists(_speaker_instance, "myPortraitIdle_x")) _portrait_idle_x[_line] = variable_instance_get(_speaker_instance, "myPortraitIdle_x");
			if (variable_instance_exists(_speaker_instance, "myPortraitIdle_y")) _portrait_idle_y[_line] = variable_instance_get(_speaker_instance, "myPortraitIdle_y");
			if (_portrait_talk[_line] != -1) {
				_portrait_talk_n[_line] = sprite_get_number(_portrait_talk[_line]) - 1;
				_portrait_talk_s[_line] = sprite_get_speed(_portrait_talk[_line]) / room_speed;
			}
			if (_portrait_idle[_line] != -1) {
				_portrait_idle_n[_line] = sprite_get_number(_portrait_idle[_line]) - 1;
				_portrait_idle_s[_line] = sprite_get_speed(_portrait_idle[_line]) / room_speed;
			}
		}
	}

	var _textbox = instance_create_layer(0, 0, "Instances", obj_textbox);
	variable_instance_set(_textbox, "text", _texts);
	variable_instance_set(_textbox, "speaker", _speakers);
	variable_instance_set(_textbox, "effects", _effects_by_line);
	variable_instance_set(_textbox, "text_speed", _speed_by_line);
	variable_instance_set(_textbox, "type", _types_by_line);
	variable_instance_set(_textbox, "nextline", _next_by_line);
	variable_instance_set(_textbox, "executeScript", _scripts_by_line);
	variable_instance_set(_textbox, "text_col", _colors_by_line);
	variable_instance_set(_textbox, "emotion", _emotion_by_line);
	variable_instance_set(_textbox, "emotes", _emotes_by_line);
	variable_instance_set(_textbox, "name", _names);
	variable_instance_set(_textbox, "portrait", _portraits);
	variable_instance_set(_textbox, "voice", _voices);
	variable_instance_set(_textbox, "font", _fonts);
	variable_instance_set(_textbox, "portrait_talk", _portrait_talk);
	variable_instance_set(_textbox, "portrait_talk_x", _portrait_talk_x);
	variable_instance_set(_textbox, "portrait_talk_y", _portrait_talk_y);
	variable_instance_set(_textbox, "portrait_talk_n", _portrait_talk_n);
	variable_instance_set(_textbox, "portrait_talk_s", _portrait_talk_s);
	variable_instance_set(_textbox, "portrait_idle", _portrait_idle);
	variable_instance_set(_textbox, "portrait_idle_x", _portrait_idle_x);
	variable_instance_set(_textbox, "portrait_idle_y", _portrait_idle_y);
	variable_instance_set(_textbox, "portrait_idle_n", _portrait_idle_n);
	variable_instance_set(_textbox, "portrait_idle_s", _portrait_idle_s);
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
