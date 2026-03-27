extends RigidBody2D

var speed = 400
var is_dead = false

func _ready():
	if has_node("AnimatedSprite2D"):
		$AnimatedSprite2D.play("move")
		$AnimatedSprite2D.flip_h = true

func _physics_process(_delta):
	if not is_dead:
		linear_velocity.x = speed
		linear_velocity.y = 0

func _on_body_entered(body):
	if is_dead:
		return

	if body.name == "Player":
		Global.lives -= 1
		
		if Global.lives <= 0:
			TransitionScreen.change_scene("res://scenes/Game Over.tscn")
		else:
			get_tree().call_deferred("reload_current_scene")
			
		call_deferred("queue_free")
	else:
		is_dead = true
		
		set_deferred("contact_monitor", false)
		
		linear_velocity = Vector2.ZERO 
		
		if has_node("AnimatedSprite2D"):
			$AnimatedSprite2D.play("dead") 
		await get_tree().create_timer(0.1).timeout
		queue_free()
