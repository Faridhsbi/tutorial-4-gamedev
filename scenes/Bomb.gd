extends RigidBody2D
var initial_fall_speed = 300 

func _ready():
	linear_velocity.y = initial_fall_speed

func _on_body_entered(body):
	if body.name == "Player":
		get_tree().call_deferred("reload_current_scene")
	else:
		call_deferred("queue_free")
