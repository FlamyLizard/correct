extends Area2D

onready var anim = get_parent().get_node("AnimationPlayer")

export (int) var damage: = 10 

func attack():
	anim.play("attack") # unless attack button is clicked no attack animation played


func _on_weapon_body_entered(body): # checks enemy (bat.gd) script if it has the func "hit" and if so then damage is dealt
	if body.has_method("hit"): # this only applies when that enemies collision shape is within the strike area 
		body.hit(damage)
