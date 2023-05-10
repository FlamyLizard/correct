extends Area2D

export(String, FILE, "*.tscn,*.scn") var new_scene

onready var Global = get_node("/root/Global")

var return_from_cave = false
var return_position = Vector2.ZERO

func _input(event):
	if event.is_action_pressed("ui_accept"): # keybind for entering the cave which is spacebar
		if get_overlapping_bodies().size() > 0: # false statement if there is no player (0) if there is then its true (greater than 0)
			level_3()
			
func level_3():
	var PTS = get_tree().change_scene("res://Cave3.tscn")
	Global.cave_entrance3 = name
	call_deferred("_set_player_position")
	
func _set_player_position():
	if Global.cave_entrance3:
		var door_node = find_node(Global.cave_entrance3)
		if door_node:
			$YSort/player.position.x= 471
			$YSort/player.position.y= 256
