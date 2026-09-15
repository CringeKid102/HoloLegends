if(instance_exists(obj_textbox)) exit;

input_left		= keyboard_check(vk_left) || keyboard_check(ord("A"));
input_right		= keyboard_check(vk_right) || keyboard_check(ord("D"));
input_up		= keyboard_check(vk_up) || keyboard_check(ord("W"));
input_down		= keyboard_check(vk_down) || keyboard_check(ord("S"));
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

//---------APPLY MOVEMENT
x += moveX;
y += moveY;