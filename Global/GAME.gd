extends Node

func _ready() -> void:
	set_new_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("fullscreen"):
			OS.window_fullscreen = !OS.window_fullscreen
		elif event.is_action_pressed("pause"):
			get_tree().paused = !get_tree().paused
			var new_mode = Input.MOUSE_MODE_VISIBLE \
				if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED \
				else Input.MOUSE_MODE_CAPTURED
			set_new_mouse_mode(new_mode)

func set_new_mouse_mode(new_mode) -> void:
	Input.set_mouse_mode(new_mode)
