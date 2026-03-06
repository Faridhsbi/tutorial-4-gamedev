extends Marker2D

@export var object_to_spawn: PackedScene

func _on_timer_timeout():
	if object_to_spawn != null:
		var spawn_instance = object_to_spawn.instantiate()
	
		spawn_instance.global_position = global_position
		
		get_parent().add_child(spawn_instance)
