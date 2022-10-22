extends Node2D

export var trade_cost : int = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func trade(candies : int) -> void:
	if candies > trade_cost:
		GAME.emit_signal("npc_trade_success", trade_cost)
