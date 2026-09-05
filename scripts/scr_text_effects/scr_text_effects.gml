/// Text effects helper functions for dialogue system

/// @function apply_text_effect(effect_type, time, amplitude)
/// @description Apply text effect based on type
/// Effect types: 0=none, 1=shake, 2=wave, 3=bob, 4=rotate, 5=color_pulse
function apply_text_effect(effect_type, time, amplitude = 4) {
	var effect_result = 0;
	
	switch(effect_type) {
		case 0: // No effect
			break;
		case 1: // Shake effect
			effect_result = irandom_range(-amplitude, amplitude);
			break;
		case 2: // Wave effect
			effect_result = sin(time * 0.2) * amplitude;
			break;
		case 3: // Bob effect (vertical)
			effect_result = sin(time * 0.1) * amplitude;
			break;
		case 4: // Rotate effect
			effect_result = sin(time * 0.15) * 5;
			break;
	}
	
	return effect_result;
}

/// @function get_text_effect_color(effect_type, time)
/// @description Get color for text effect
function get_text_effect_color(effect_type, time) {
	switch(effect_type) {
		case 5: // Color pulse
			return merge_color(c_white, c_yellow, (sin(time * 0.1) + 1) / 2);
		case 6: // Rainbow effect
			var hue = (time * 2) mod 360;
			return make_color_hsv(hue, 255, 255);
		default:
			return c_white;
	}
}

/// @function text_apply_effects(text, effect_type, time, x, y, color)
/// @description Draw text with effects applied
function text_apply_effects(_text, _effect_type, _time, _x, _y, _color) {
	if (_effect_type == 0) {
		// No effect, just draw normally
		draw_text_color(_x, _y, _text, _color, _color, _color, _color, 1);
		return;
	}
	
	var char_x = _x;
	var text_len = string_length(_text);
	
	for (var i = 1; i <= text_len; i++) {
		var char = string_char_at(_text, i);
		var char_offset = apply_text_effect(_effect_type, _time + i, 4);
		var char_color = get_text_effect_color(_effect_type, _time + i);
		
		if (_effect_type == 1 || _effect_type == 2 || _effect_type == 3) {
			// Position-based effects
			draw_text_color(char_x, _y + char_offset, char, char_color, char_color, char_color, char_color, 1);
		} else if (_effect_type == 4) {
			// Rotation effect
			draw_text_transformed_color(char_x, _y, char, 1, 1, char_offset, char_color, char_color, char_color, char_color, 1);
		} else {
			// Color effects
			draw_text_color(char_x, _y, char, char_color, char_color, char_color, char_color, 1);
		}
		
		char_x += string_width(char);
	}
}
