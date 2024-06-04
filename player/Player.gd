extends CharacterBody2D

var jumpImpulse := 7.0 * 60
var gravityImpulse := 8.0 * 60
var movementSpeed := 3.0 * 60

var tiltThreshold = 0.5

func _physics_process(delta: float) -> void:
	var tiltValue = Input.get_accelerometer().x

	var horizontalMovement = 0
	if  abs(tiltValue) > tiltThreshold:
		horizontalMovement = tiltValue
	velocity.x = horizontalMovement * movementSpeed

	
	if  Input.is_action_pressed("move_left"):
		horizontalMovement = -3
	if  Input.is_action_pressed("move_right"):
		horizontalMovement = 3
	velocity.x = horizontalMovement * movementSpeed
		
	velocity.y += gravityImpulse * delta
	if is_on_floor():
		velocity.y = -jumpImpulse
	
	move_and_slide()
	
