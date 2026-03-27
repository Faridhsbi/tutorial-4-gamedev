extends Area2D

@export var sceneName: String = "Level 1"
@export var is_win_area: bool = false 

func _on_Area_Trigger_body_entered(body):
	var current_scene = get_tree().get_current_scene().name
	
	if body.name == "Player":
		if is_win_area:
			Global.lives = 3 
			TransitionScreen.change_scene("res://scenes/" + sceneName + ".tscn")
			
		else:
			if current_scene == sceneName:
				Global.lives -= 1
				
			if Global.lives <= 0:
				TransitionScreen.change_scene("res://scenes/Game Over.tscn")
			else:
				TransitionScreen.change_scene("res://scenes/" + sceneName + ".tscn")
