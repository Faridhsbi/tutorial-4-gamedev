extends ColorRect

@onready var lives_label = $CenterContainer/VBoxContainer/VBoxContainer/Label2 

func _ready():
	if lives_label != null:
		lives_label.text = "Lives Left: " + str(Global.lives)

func _on_button_pressed():
	Global.lives = 3
	TransitionScreen.change_scene("res://scenes/MainMenu.tscn")
