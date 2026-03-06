extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		body.friction = 200     
		body.acceleration = 400 

func _on_body_exited(body):
	if body.name == "Player":
		body.friction = 3000    
		body.acceleration = 3000
