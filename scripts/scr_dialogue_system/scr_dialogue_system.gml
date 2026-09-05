/// @function create_dialogue(myText, mySpeaker, myEffects, myTextSpeed, myTypes, myNextLine, myScripts, myTextCol, myEmotion, myEmote)
/// @description Creates a dialogue textbox instance with the provided parameters
function create_dialogue(_text, _speaker, _effects, _text_speed, _types, _next_line, _scripts, _text_col, _emotion, _emote) {
	var _textbox = instance_create_layer(0, 0, "Instances", obj_textbox);
	
	with (_textbox) {
		text = _text;
		speaker = _speaker;
		effects = _effects;
		text_speed = _text_speed;
		type = _types;
		nextline = _next_line;
		executeScript = _scripts;
		text_col = _text_col;
		emotion = _emotion;
		emotes = _emote;
		
		alarm[0] = 1; // Trigger setup
	}
	
	return _textbox;
}

/// @function reset_dialogue_defaults()
/// @description Resets dialogue system variables to default values
function reset_dialogue_defaults() {
	myText			= -1;
	mySpeaker		= -1;
	myEffects		= -1;
	myTextSpeed		= -1;
	myTypes			= 0;
	myNextLine		= -1;
	myScripts		= -1;
	myTextCol		= -1;
	myEmotion		= -1;
	myEmote			= -1;
}

/// @function create_textevent(text, speaker, effects, text_speed, types, next_line, scripts, text_col, emotion, emote)
/// @description Creates a one-time text event that appears at game start
function create_textevent(_text, _speaker, _effects, _text_speed, _types, _next_line, _scripts, _text_col, _emotion, _emote) {
	var _textevent = instance_create_layer(0, 0, "Instances", obj_textevent);
	
	with (_textevent) {
		myText = _text;
		mySpeaker = _speaker;
		myEffects = _effects;
		myTextSpeed = _text_speed;
		myTypes = _types;
		myNextLine = _next_line;
		myScripts = _scripts;
		myTextCol = _text_col;
		myEmotion = _emotion;
		myEmote = _emote;
		
		event_perform(ev_create, 0); // Call Other_10 to set up dialogue
	}
	
	return _textevent;
}
