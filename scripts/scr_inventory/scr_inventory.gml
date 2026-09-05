/// @function init_inventory()
/// @description Initialize inventory system
function init_inventory() {
	if (!variable_global_exists("inventory")) {
		global.inventory = ds_map_create();
		global.inventory_max_size = 20;
		global.inventory_item_count = 0;
	}
}

/// @function add_item(item_id, quantity)
/// @description Add item to inventory. Returns true if successful
function add_item(item_id, quantity = 1) {
	if (!variable_global_exists("inventory")) {
		init_inventory();
	}
	
	// Check if inventory is full
	if (global.inventory_item_count >= global.inventory_max_size) {
		show_debug_message("Inventory full!");
		return false;
	}
	
	if (ds_map_exists(global.inventory, item_id)) {
		// Item already exists, just increase quantity
		global.inventory[? item_id] += quantity;
	} else {
		// Add new item
		global.inventory[? item_id] = quantity;
		global.inventory_item_count += 1;
	}
	
	show_debug_message("Added " + string(quantity) + "x " + string(item_id));
	return true;
}

/// @function remove_item(item_id, quantity)
/// @description Remove item from inventory. Returns true if successful
function remove_item(item_id, quantity = 1) {
	if (!variable_global_exists("inventory") || !ds_map_exists(global.inventory, item_id)) {
		return false;
	}
	
	if (global.inventory[? item_id] <= quantity) {
		ds_map_delete(global.inventory, item_id);
		global.inventory_item_count -= 1;
	} else {
		global.inventory[? item_id] -= quantity;
	}
	
	return true;
}

/// @function has_item(item_id, quantity)
/// @description Check if player has item with required quantity
function has_item(item_id, quantity = 1) {
	if (!variable_global_exists("inventory")) {
		return false;
	}
	
	if (!ds_map_exists(global.inventory, item_id)) {
		return false;
	}
	
	return global.inventory[? item_id] >= quantity;
}

/// @function get_item_quantity(item_id)
/// @description Get quantity of item in inventory
function get_item_quantity(item_id) {
	if (!variable_global_exists("inventory")) {
		return 0;
	}
	
	if (!ds_map_exists(global.inventory, item_id)) {
		return 0;
	}
	
	return global.inventory[? item_id];
}

/// @function clear_inventory()
/// @description Clear all items from inventory
function clear_inventory() {
	if (!variable_global_exists("inventory")) {
		return;
	}
	
	ds_map_clear(global.inventory);
	global.inventory_item_count = 0;
}
