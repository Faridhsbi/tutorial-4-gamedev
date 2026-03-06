extends Marker2D

@export var object_to_spawn: PackedScene

func _on_timer_timeout():
	if object_to_spawn != null:
		var spawn_instance = object_to_spawn.instantiate()
		
		var spawn_pos = global_position
		
		spawn_pos.y += randf_range(5.0, 120.0)
		
		spawn_instance.global_position = spawn_pos
		get_parent().add_child(spawn_instance)
