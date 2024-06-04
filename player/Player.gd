extends CharacterBody2D

var jumpImpulse := 7.0 * 60
var gravityImpulse := 8.0 * 60
var movementSpeed := 3.0 * 60
var dir: =0.0


func _physics_process(delta:float)->void:
	dir=Input.get_action_strength("move_right")-Input.get_action_strength("move_left")
	velocity.y+=gravityImpulse*delta
	if is_on_floor():
		velocity.y= -jumpImpulse
	
	velocity.x = dir * movementSpeed
	move_and_slide()
