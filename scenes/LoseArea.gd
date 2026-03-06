extends RigidBody2D

@export var scene_name: String = "LoseScreen"

func _on_FallArea_body_entered(body):
	if body.name == "Player":
		var scene_path: String = "res://scenes/%s.tscn" % scene_name
		get_tree().change_scene_to_file(scene_path)
	else:
		queue_free()
