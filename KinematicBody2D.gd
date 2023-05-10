extends KinematicBody2D

onready var weapon = $weapon
onready var collision_shape = $CollisionShape2D
onready var attack = $attack
onready var walk = $walk
onready var hurt = $hurt

const health_max = 100
var health = health_max

const acc = 10
var max_speed = 85
const friction = 85

var motion = Vector2()

var is_running = false
const walk_speed = 60
const run_speed = 85

var time_since_last_step = 0
const step_interval = 0.75

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

	if input != Vector2.ZERO:
		if time_since_last_step >= step_interval:
			walk.play()
			time_since_last_step = 0
		else:
			time_since_last_step += delta
	else:
		walk.stop()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		weapon.attack() 
		attack.play()

func _on_Area2D_body_entered(body):
	if "bat" in body.name:
		take_damage(10) 
	if "skeleton" in body.name:
		take_damage(25) 
	if "spider" in body.name:
		take_damage(5) 

func take_damage(damage):
	hurt.play()
	health -= damage
	print(str(health))
	if health <= 0:
# Player dies
		queue_free()
