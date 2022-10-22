extends Node2D
export var skull_texture : Texture = null
export var sign_texture : Texture = null

onready var pumpkin_scene : PackedScene = preload("res://Scenes/Object/Pumpkin/Pumpkin.tscn")
onready var pumpkin_timer : Timer = get_node("pumpkin_timer")
onready var pumpkins_container : Node2D = get_node("Pumpkins")
onready var game_timer : Timer = get_node("game_timer")
onready var game_timer_progress : TextureProgress = get_node("UI/Control/game_timer_progress")
var pumpkin_spawn_counter : int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	pumpkin_timer.connect("timeout" , self , "_on_pumpkin_timer_timeout")
	game_timer.connect("timeout", self , "_on_game_timer_timeout")
	game_timer_progress.set_max(game_timer.wait_time)
	game_timer_progress.set_value(game_timer_progress.max_value)

func _physics_process(delta: float) -> void:
	game_timer_progress.set_value(game_timer.time_left)

func add_pumpkin() -> void :
	var height : float = get_viewport().size.y
	var width : float = get_viewport().size.x
	var coord : Vector2 = Vector2(rand_range(0,width),rand_range(0,height))
	var new_pumpkin_instance = pumpkin_scene.instance()
	new_pumpkin_instance.set_position(coord)
	pumpkins_container.call_deferred("add_child", new_pumpkin_instance, true)
	pumpkin_spawn_counter +=1

func _on_pumpkin_timer_timeout() -> void :
	add_pumpkin()

func _on_game_timer_timeout () -> void :
	get_tree().reload_current_scene()
