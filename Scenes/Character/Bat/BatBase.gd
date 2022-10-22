extends Node2D
class_name BatBase

func is_class(value: String): return value == "BatBase" or .is_class(value)
func get_class() -> String: return "BatBase"

onready var anim : AnimatedSprite = get_node("AnimatedSprite")
onready var area : Area2D = get_node("Area2D")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	var __
	__ = area.connect("area_entered", self, "_on_bat_area_entered")
	__ = area.connect("area_exited", self, "_on_bat_area_exited")
	
	init_bat_model()

func init_bat_model() -> void:
	anim.set_animation(GAME.bat_model)

func _on_bat_area_entered(_area : Area2D) -> void:
	pass

func _on_bat_area_exited(_area : Area2D) -> void:
	pass
