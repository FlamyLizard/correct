extends KinematicBody2D

onready var weapon = $weapon

const acc = 10
var max_speed = 85
const friction = 85

var motion = Vector2()

var is_running = false
const walk_speed = 60
const run_speed = 85

func _physics_process(delta):
	var input = Vector2()
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input = input.normalized()

	if Input.is_action_pressed("run"):
		is_running = true
	if Input.is_action_just_released("run"):
		is_running = false

	if input != Vector2.ZERO:

		if input.x > 0:
			if is_running:
				$AnimatedSprite.play("run")
			else:
				$AnimatedSprite.play("walk")
			$AnimatedSprite.flip_h = false
		elif input.x < 0:
			if is_running:
				$AnimatedSprite.play("run")
			else:
				$AnimatedSprite.play("walk")
			$AnimatedSprite.flip_h = true
		else:
			if input.y > 0:
				if is_running:
					$AnimatedSprite.play("run down")
				else:
					$AnimatedSprite.play("walk down")
			elif input.y < 0:
				if is_running:
					$AnimatedSprite.play("run up")
				else:
					$AnimatedSprite.play("walk up")
			else:
				$AnimatedSprite.play("idle")

		if is_running:
			max_speed = run_speed
		else:
			max_speed = walk_speed

		motion += input * acc * delta
		motion = motion.clamped(max_speed * delta)
	else:
		$AnimatedSprite.play("idle")
		motion = motion.move_toward(Vector2.ZERO, friction * delta)

	move_and_collide(motion)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		weapon.attack() 

export (int) var health: = 100

func _on_Area2D_body_entered(body, damage: int):
	health -= damage 
	print(str(health))
	if health <= 0:
		queue_free()
