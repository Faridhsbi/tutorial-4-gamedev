extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		body.DECELERATION = 50.0     
		body.ACCELERATION = 100.0 

func _on_body_exited(body):
	if body.name == "Player":
		body.DECELERATION = 400.0    
		body.ACCELERATION = 400.0
