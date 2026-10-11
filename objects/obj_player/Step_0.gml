if(instance_exists(obj_textbox)) exit;

var key_left = global.keybinds[? "move_left"];
var key_right = global.keybinds[? "move_right"];
var key_up = global.keybinds[? "move_up"];
var key_down = global.keybinds[? "move_down"];
input_left		= keyboard_check(vk_left) || keyboard_check(key_left);
input_right		= keyboard_check(vk_right) || keyboard_check(key_right);
input_up		= keyboard_check(vk_up) || keyboard_check(key_up);
input_down		= keyboard_check(vk_down) || keyboard_check(key_down);
input_run		= keyboard_check(vk_shift);
input_walk		= keyboard_check(vk_control);

//---------RESET MOVEMENT VARIABLES
moveX = 0; 
moveY = 0;

//---------GET INTENDED MOVEMENT
var right = (input_right - input_left);
var left = (input_down - input_up);
if(right != 0 or left != 0){
	var dir = point_direction(x,y, x+right, y+left);
	moveX = lengthdir_x(spd, dir);
	moveY = lengthdir_y(spd, dir);
}

//---------APPLY MOVEMENT WITH SOLID-OBJECT AND ROOM-EDGE COLLISION
if (bbox_left + moveX >= 0 && bbox_right + moveX <= room_width
&& !place_meeting(x + moveX, y, par_world_solid)) {
	x += moveX;
}
if (bbox_top + moveY >= 0 && bbox_bottom + moveY <= room_height
&& !place_meeting(x, y + moveY, par_world_solid)) {
	y += moveY;
}