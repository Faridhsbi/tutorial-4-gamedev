extends CanvasLayer

func change_scene(target_scene: String):
	$AnimationPlayer.play("fade_to_black")
	await $AnimationPlayer.animation_finished
	
	get_tree().change_scene_to_file(target_scene)
	
	$AnimationPlayer.play("fade_to_normal")
