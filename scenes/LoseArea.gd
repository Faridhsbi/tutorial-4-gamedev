extends RigidBody2D

@export var scene_name: String = "Game Over"

func _on_FallArea_body_entered(body):
	if body.name == "Player":
		Global.lives -= 1
		
		if Global.lives <= 0:
			var scene_path: String = "res://scenes/%s.tscn" % scene_name
			get_tree().call_deferred("change_scene_to_file", scene_path)
		else:
			get_tree().call_deferred("reload_current_scene")
			
		call_deferred("queue_free")
		
	else:
		call_deferred("queue_free")
