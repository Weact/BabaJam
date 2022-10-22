extends Node

signal bat_added(total_bats)

var models : int = 4
var bat_model : String = "IdlePurple"
var bat_icon_texture : Texture = null

func _ready() -> void:
	randomize()
	set_new_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	bat_model = get_bat_model()

func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("fullscreen"):
			OS.window_fullscreen = !OS.window_fullscreen
		elif event.is_action_pressed("pause"):
			get_tree().quit()
#			get_tree().paused = !get_tree().paused
#			var new_mode = Input.MOUSE_MODE_VISIBLE \
#				if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED \
#				else Input.MOUSE_MODE_CAPTURED
#			set_new_mouse_mode(new_mode)
		elif event.is_action_pressed("restart"):
			get_tree().reload_current_scene()
			bat_model = get_bat_model()

func set_new_mouse_mode(new_mode) -> void:
	Input.set_mouse_mode(new_mode)

func get_bat_model() -> String:
	var model : String = ""
	var chosen_model_index : int = randi() % models
	match(chosen_model_index):
		0:
			model = "IdlePurple"
			bat_icon_texture = load("res://Assets/Bats/Bat face 1 violet.png")
		1:
			model = "IdleOrange"
			bat_icon_texture = load("res://Assets/Bats/Bat face 1 orange.png")
		2:
			model = "IdleEvolutionPurple"
			bat_icon_texture = load("res://Assets/Bats/Bat face 2 violet.png")
		3:
			model = "IdleEvolutionOrange"
			bat_icon_texture = load("res://Assets/Bats/Bat face 2 orange.png")
		_:
			model = "IdlePurple"
	return model
