extends Node2D
class_name NPC

func is_class(value: String): return value == "NPC" or .is_class(value)
func get_class() -> String: return "NPC"

export var trade_cost : int = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func trade(candies : int) -> void:
	if candies >= trade_cost and candies > 0:
		GAME.emit_signal("npc_trade_success", trade_cost)
