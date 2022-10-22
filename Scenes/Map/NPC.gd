extends Node2D
class_name NPC
func is_class(value: String): return value == "NPC" or .is_class(value)
func get_class() -> String: return "NPC"
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func trade(candies : int ) -> void :
	connect("tree_entering" , self , "NPC_trade_triggered")
	connect("tree_exiting" , self , "NPC_trade_cancelled")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
