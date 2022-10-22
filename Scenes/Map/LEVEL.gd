extends Node2D
onready var pumpkin_scene : PackedScene = preload("res://Scenes/Object/Pumpkin/Pumpkin.tscn")
onready var pumpkin_timer : Timer = get_node("Timer")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	pumpkin_timer.connect("timeout" , self , "_on_pumpkin_timer_timeout")
	add_pumpkin()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass

func add_pumpkin() -> void :
	var height : float = get_viewport().size.y
	var width : float = get_viewport().size.x
	var coord : Vector2 = Vector2(rand_range(0,width),rand_range(0,height))
	var new_pumpkin_instance = pumpkin_scene.instance()
	new_pumpkin_instance.set_position(coord)
	call_deferred("add_child",new_pumpkin_instance)
	
func _on_pumpkin_timer_timeout() -> void :
	add_pumpkin()
