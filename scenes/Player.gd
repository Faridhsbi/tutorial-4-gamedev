extends CharacterBody2D

var ACCELERATION = 400.0
var DECELERATION = 400.0

@export var speed: float = 400.0
@export var gravity: int = 1200
@export var jump_speed: int = -400

@onready var particle = $GPUParticles2D

func get_input():
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_speed
	if Input.is_action_pressed("right"):
		$Sprite2D.flip_h = false
		velocity.x = lerp(velocity.x, speed, ACCELERATION / speed)  ## naik perlahan (kanan)
	elif Input.is_action_pressed("left"):
		$Sprite2D.flip_h = true
		velocity.x = lerp(velocity.x, -speed, ACCELERATION / speed)  ## naik perlahan (kiri)
	else:
		velocity.x = lerp(velocity.x, 0.0, DECELERATION / speed)  ## turun perlahan

func set_particles():
	if abs(velocity.x) == speed and is_on_floor():
		particle.set_emitting(true)
	else:
		particle.set_emitting(false)

func _physics_process(delta):
	velocity.y += delta * gravity
	get_input()
	set_particles()
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
