extends Area2D

var speed = 100
var direction = 1 
var start_x = 0
var move_distance = 128 

var is_idling = false
var idle_duration = 1.5
var idle_timer = 0.0

func _ready():
	start_x = global_position.x
	
	_update_facing_direction()
	
	if has_node("AnimatedSprite2D"):
		$AnimatedSprite2D.play("Move")

func _update_facing_direction():
	if has_node("AnimatedSprite2D"):
		$AnimatedSprite2D.flip_h = (direction == 1)
	
	if has_node("RayCast2D"):
		$RayCast2D.target_position.x = 60 * direction

func _process(delta):
	if is_idling:
		idle_timer -= delta
		
		if idle_timer <= 0:
			is_idling = false 
			
			start_x = global_position.x 
			
			if has_node("AnimatedSprite2D"):
				$AnimatedSprite2D.play("Move") 
		return 

	position.x += speed * direction * delta
	
	var hit_wall = false
	if has_node("RayCast2D") and $RayCast2D.is_colliding():
		var objek_ditabrak = $RayCast2D.get_collider()
		if objek_ditabrak and objek_ditabrak.name != "Player":
			hit_wall = true
	
	var out_of_bounds = abs(position.x - start_x) >= move_distance

	if hit_wall or out_of_bounds:
		is_idling = true             
		idle_timer = idle_duration   
		
		direction *= -1
		_update_facing_direction()
		
		if has_node("AnimatedSprite2D"):
			$AnimatedSprite2D.play("Idle")

func _on_body_entered(body):
	if body.name == "Player":
		Global.lives -= 1
		if Global.lives <= 0:
			TransitionScreen.change_scene("res://scenes/Game Over.tscn")
		else:
			get_tree().call_deferred("reload_current_scene")
		
