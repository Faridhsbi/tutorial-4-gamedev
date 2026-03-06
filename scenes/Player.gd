extends CharacterBody2D

@export var speed: int = 400
@export var gravity: int = 1200
@export var jump_speed: int = -400
@export var acceleration: int = 3000
@export var friction: int = 3000

func get_input(delta):
	var direction = 0
	if Input.is_action_pressed("right"):
		direction += 1
	if Input.is_action_pressed("left"):
		direction -= 1

	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_speed

	if direction != 0:
		velocity.x = move_toward(velocity.x, direction * speed, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)

func _physics_process(delta):
	velocity.y += delta * gravity
	get_input(delta)
	move_and_slide()

func _process(_delta):
	if not is_on_floor():
		$Animator.play("Jump")
	elif abs(velocity.x) > 10:
		$Animator.play("Walk")
	else:
		$Animator.play("Idle")

	if velocity.x > 0.1:
		$Sprite2D.flip_h = false
	elif velocity.x < -0.1:
		$Sprite2D.flip_h = true
