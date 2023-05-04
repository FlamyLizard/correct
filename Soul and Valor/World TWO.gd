extends Node2D

func _ready():
	if Global.cave_entrance2:
		var door_node = find_node(Global.cave_entrance2)
		if door_node:
			if door_node.return_from_cave:
				# if the player has returned from the cave this sets their position to the entrance of the cave they came from
				$YSort/player.position = door_node.return_position
			else:
				# if the player has not returned from the cave this set their position to the entrance of the current level/world
				$YSort/Player.position.x = 631
				$YSort/Player.position.y = 193
