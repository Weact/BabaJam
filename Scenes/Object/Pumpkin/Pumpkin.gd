extends Node2D
export var real_pumpkin_hitpoints : int = 10
export var pumpkin_texture_1 : Texture = null
export var pumpkin_texture_2 : Texture = null
export var pumpkin_texture_3 : Texture = null
export var pumpkin_texture_mid_1 : Texture = null
export var pumpkin_texture_mid_2 : Texture = null
export var pumpkin_texture_mid_3 : Texture = null
export var pumpkin_texture_low : Texture = null
onready var pumpkin_sprite : Sprite = get_node("Sprite")
onready var hp_bar : TextureProgress = get_node("hp_bar")
var pumpkin_hitpoints : float = real_pumpkin_hitpoints/10
var pumpkin_type : int 
var base_hitpoints = real_pumpkin_hitpoints

func _ready():
	randomize_pumpkin_texture()
	hp_bar.set_max(real_pumpkin_hitpoints)
	hp_bar.set_value(hp_bar.max_value)
	
func get_real_pumpkin_hitpoints() -> int :
	return real_pumpkin_hitpoints
	
func update_pumpkin_hitpoints() -> void :
	hp_bar.value = real_pumpkin_hitpoints
	
func set_real_pumpkin_hitpoints(new_pumpkin_hitpoints) -> void :
	real_pumpkin_hitpoints = new_pumpkin_hitpoints
	update_pumpkin_hitpoints()
	if real_pumpkin_hitpoints <= 0 :
		queue_free()
	if real_pumpkin_hitpoints > base_hitpoints/5 and real_pumpkin_hitpoints <= base_hitpoints/2 :
		update_pumpkin_texture_mid()
	elif real_pumpkin_hitpoints <= base_hitpoints/5 :
		update_pumpkin_texture_low()

func add_pumpkin_hitpoint() -> void :
	var add : int = 1
	set_real_pumpkin_hitpoints(get_real_pumpkin_hitpoints() + add)
	
func randomize_pumpkin_texture() -> void :
	var rand : int  = randi() %3
	if rand == 0 :
		pumpkin_sprite.set_texture(pumpkin_texture_1)
		pumpkin_type = 1
	elif rand == 1 :
		pumpkin_sprite.set_texture(pumpkin_texture_2)
		pumpkin_type = 2
	else :
		pumpkin_sprite.set_texture(pumpkin_texture_3)
		pumpkin_type = 3
		
func update_pumpkin_texture_mid() -> void :
	match(pumpkin_type):
		1 :
			pumpkin_sprite.set_texture(pumpkin_texture_mid_1)
		2 :
			pumpkin_sprite.set_texture(pumpkin_texture_mid_2)
		3 :
			pumpkin_sprite.set_texture(pumpkin_texture_mid_3)

func update_pumpkin_texture_low() -> void :
	pumpkin_sprite.set_texture(pumpkin_texture_low)
	
func _unhandled_key_input(event):
	if event.physical_scancode == KEY_A:
		set_real_pumpkin_hitpoints(get_real_pumpkin_hitpoints()-0.5)

