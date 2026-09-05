/// Stub functions for missing GameMaker functions and custom functions
/// These are used by the dialogue system

/// @function create_instance_layer(x, y, layer_name, object_index)
/// @description Wrapper/stub if needed (built-in function might not be recognized)
function create_instance_layer(_x, _y, _layer, _obj) {
	return instance_create_layer(_x, _y, _layer, _obj);
}

/// @function change_variable(instance, variable_name, value)
/// @description Change a variable on an instance
function change_variable(_inst, _var_name, _value) {
	if (instance_exists(_inst)) {
		variable_instance_set(_inst, _var_name, _value);
	}
}

/// @function script_execute_alt(script_function, array_of_args)
/// @description Execute a script with arguments from an array
function script_execute_alt(_script, _args) {
	if (is_method(_script)) {
		// It's a method/function
		return _script(_args);
	} else if (is_real(_script)) {
		// It's a script ID (legacy)
		return script_execute(_script, _args);
	}
	return undefined;
}
