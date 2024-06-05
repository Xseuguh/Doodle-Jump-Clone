extends Node2D

@onready var width := get_viewport_rect().size.x
@onready var height := get_viewport_rect().size.y

var platform := preload("res://Levels/objects/Platform.tscn")

var platformCount := 20
@onready var player :=  $Player
@onready var platformParent :=  $Platforms
var platforms := []
@onready var treshold = height * 0.5
var scrollSpeed = 0.05

@onready var background := $ParallaxBackground/ParallaxLayer/TextureRect

var numberOfScroll = 0

func _ready()-> void:
	player.global_position.y=treshold
	for i in platformCount:
		var inst = platform.instantiate()
		inst.global_position.y = height / platformCount * i
		inst.global_position.x = rand_x()
		platformParent.add_child(inst)
		platforms.append(inst)
	player.global_position.x = rand_x()
	platforms.back().global_position.x = player.global_position.x
	
func rand_x()->float:
	return randf_range(28.0, width-28.0)
	
func _physics_process(_delta:float)-> void:
	if player.global_position.y < treshold:
		numberOfScroll += 1
		var move: float = lerp(0.0, treshold - player.global_position.y, scrollSpeed)
		move_background(move)
		player.global_position.y += move
		for platform in platforms:
			platform.global_position.y += move
			if platform.global_position.y > height:
				platform.global_position.y -= height
				platform.global_position.x = rand_x()
	if player.global_position.y > height:
		game_over()
	
	if player.global_position.x > width :
		player.global_position.x = 0
	elif player.global_position.x < 0 :
		player.global_position.x = width

		
func move_background(move:float)-> void:
	var ratio := 0.75
	background.global_position.y = fmod((background.global_position.y + height + move * ratio), height) - height


func game_over()-> void:
	numberOfScroll = 0
	get_tree().reload_current_scene()
	

func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		print("Écran touché")
		Input.vibrate_handheld()
