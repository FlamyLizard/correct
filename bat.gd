extends KinematicBody2D

export (int) var health: = 30

var speed = 25
var motion = Vector2.ZERO

var player = null 

func _physics_process(delta):
	motion = Vector2.ZERO
	if player: # if player in the area, enemy will go towards the player
		motion = position.direction_to(player.position) * speed # bat will go towards player (if in area) at x speed
	motion = move_and_slide(motion)

func _on_hostile_area_body_entered(body): # checks when something (player) enters the collision shape
	player = body 

func _on_hostile_area_body_exited(body): # wont chase the player when not in the collision shape 
	player = null 
	
func hit(damage: int):
	health -= damage 
	print(str(health))
	if health <= 0:
		queue_free() # "kills" the enemy, essentially just removes the enemy from the scene, usually this wouldn't be the right choice of scripting but its simple

