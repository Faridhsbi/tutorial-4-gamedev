extends RigidBody2D
var initial_fall_speed = 300 

func _ready():
	linear_velocity.y = initial_fall_speed

func _on_body_entered(body):
	if body.name == "Player":
		Global.lives -= 1
		
		if Global.lives <= 0:
			TransitionScreen.change_scene("res://scenes/Game Over.tscn")
		else:
			get_tree().call_deferred("reload_current_scene")
			
		call_deferred("queue_free")
	else:
		call_deferred("queue_free")
