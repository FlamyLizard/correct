extends KinematicBody2D

enum{
	idle,
	new_dir, # direction
}

var current_state = idle
