extends Node2D
class_name Bat

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass

func _input(event):
	if event is InputEventMouseMotion:
		move_bat(event.relative)

func move_bat(pos):
	position += pos
