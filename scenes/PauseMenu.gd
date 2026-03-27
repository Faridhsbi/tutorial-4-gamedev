extends CanvasLayer

func _ready():
	visible = false 

func _input(event):
	if event.is_action_pressed("ui_cancel"): # Tombol ESC
		visible = not visible
		get_tree().paused = visible

func _on_resume_pressed():
	visible = false
	get_tree().paused = false

func _on_main_menu_pressed():
	Global.lives = 3
	get_tree().paused = false
	TransitionScreen.change_scene("res://scenes/MainMenu.tscn")
