extends Node2D

const OFFSET : float = 20.0

export var skull_texture : Texture = null
export var sign_texture : Texture = null
onready var candy_scene : PackedScene = preload("res://Scenes/candy/Candy.tscn")
onready var pumpkin_scene : PackedScene = preload("res://Scenes/Object/Pumpkin/Pumpkin.tscn")
onready var bat_scene : PackedScene = preload("res://Scenes/Character/Bat/Entities/BatEntity.tscn")
onready var pumpkin_timer : Timer = get_node("pumpkin_timer")
onready var bat_container : Node2D = get_node("Bats/Entities")
onready var pumpkins_container : Node2D = get_node("Pumpkins")
onready var candies_container : Node2D = get_node("Candies")
onready var game_timer : Timer = get_node("game_timer")
onready var game_timer_progress : TextureProgress = get_node("UI/Control/game_timer_progress")
onready var candies_counter_text : Label = get_node("UI/Control/HUD/Candies/CandyCounter")
onready var bat_icon : TextureRect = get_node("UI/Control/HUD/Bats/BatIcon")
onready var bat_counter_label : Label = get_node("UI/Control/HUD/Bats/BatCounter")

var candies_counter : int = 0
var difficulty_multiplier : int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	pumpkin_timer.connect("timeout" , self , "_on_pumpkin_timer_timeout")
	game_timer.connect("timeout", self , "_on_game_timer_timeout")
	GAME.connect("bat_added", self, "_on_bat_added")
	GAME.connect("npc_trade_success", self, "_on_npc_trade_success")
	game_timer_progress.set_max(game_timer.wait_time)
	game_timer_progress.set_value(game_timer_progress.max_value)
	bat_icon.set_texture(GAME.bat_icon_texture)

func _physics_process(delta: float) -> void:
	game_timer_progress.set_value(game_timer.time_left)

func add_pumpkin(new_pumpkin_hp : int = 5) -> void :
	var height : float = get_viewport().size.y
	var width : float = get_viewport().size.x
	var coord : Vector2 = Vector2(rand_range(0,width),rand_range(0,height))
	var new_pumpkin_instance = pumpkin_scene.instance()
	new_pumpkin_instance.real_pumpkin_hitpoints = new_pumpkin_hp
	new_pumpkin_instance.set_position(coord)
	new_pumpkin_instance.connect("tree_exiting" , self , "_on_pumpkin_destroyed",[new_pumpkin_instance])
	pumpkins_container.call_deferred("add_child", new_pumpkin_instance, true)
	difficulty_multiplier += 1

func add_bat() -> void:
	var height : float = get_viewport().size.y
	var width : float = get_viewport().size.x
	var coord : Vector2 = Vector2(rand_range(0,width),rand_range(0,height))
	var new_bat_instance = bat_scene.instance()
	new_bat_instance.set_position(coord)
	bat_container.call_deferred("add_child", new_bat_instance, true)

func _on_pumpkin_timer_timeout() -> void :
	add_pumpkin(5 + difficulty_multiplier)

func _on_game_timer_timeout() -> void :
	get_tree().reload_current_scene()

func _on_pumpkin_destroyed(pumpkin) -> void :
	var new_candy_instance = candy_scene.instance()
	new_candy_instance.set_position(pumpkin.get_position())
	new_candy_instance.connect("tree_exiting" , self , "_on_candy_destroyed" , [new_candy_instance])
	candies_container.call_deferred("add_child" , new_candy_instance , true)
	game_timer.wait_time = game_timer.get_time_left() + 2.0
	game_timer.start()
	game_timer_progress.set_max(game_timer.wait_time)

func _on_candy_destroyed(candy) -> void :
	candies_counter += 1
	GAME.candies = candies_counter
	candies_counter_text.text = "X " + str(candies_counter)

func _on_bat_added(n : int) -> void:
	bat_counter_label.text = "X " + str(n)

func _on_npc_trade_success(cn : int) -> void:
	candies_counter -= cn
	GAME.candies = candies_counter
	candies_counter_text.text = "X " + str(candies_counter)
	add_bat()
