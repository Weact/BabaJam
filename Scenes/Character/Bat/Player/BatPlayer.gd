extends BatBase
class_name BatPlayer

func is_class(value: String): return value == "BatPlayer" or .is_class(value)
func get_class() -> String: return "BatPlayer"

onready var bat_entity_scene : PackedScene = preload("res://Scenes/Character/Bat/Entities/BatEntity.tscn")
onready var control_points_container : Node2D = get_node("ControlPoints")

var total_bats : int = 1

func is_point_taken(index: int) -> bool:
	var p = control_points_container.get_child(index)
	if p.get_child_count() > 0:
		return true
	return false

func are_all_points_taken() -> bool:
	for point in control_points_container.get_children():
		if point.get_child_count() < 1:
			return false
	return true

func assign_new_bat_to_random_control_point() -> bool:
	var control_point_id : int = generate_new_control_point_index()
	if not are_all_points_taken():
		while is_point_taken(control_point_id):
			control_point_id = generate_new_control_point_index()
	else:
		upgrade_bat()
		
	var control_point_node : Position2D = control_points_container.get_child(control_point_id)
	print("Control Point assigned to " , control_point_node.name)
	
	if is_instance_valid(control_point_node):
		var new_bat_instance = bat_entity_scene.instance()
		control_point_node.call_deferred("add_child", new_bat_instance)
	else:
		return false
	
	update_total_bats()
	return true

func get_random_point_in_container():
	return control_points_container.get_child(generate_new_control_point_index())

func clear_all_controlled_bats() -> void:
	for point in control_points_container.get_children():
		if point.get_child_count() > 0:
			for bat in point.get_children():
				bat.call_deferred("queue_free")

func upgrade_bat() -> void:
	clear_all_controlled_bats()

func update_total_bats() -> void:
	total_bats += 1

func generate_new_control_point_index() -> int:
	return randi() % control_points_container.get_child_count()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()

func _physics_process(delta: float) -> void:
	pass

func _input(event):
	if event is InputEventMouseMotion:
		move_bat(event.relative)

func move_bat(pos):
	position += pos

func _on_bat_area_entered(area : Area2D) -> void:
	var body = area.get_owner()
	if is_instance_valid(body):
		if body.is_class("BatEntity") and body.has_method("control"):
			if assign_new_bat_to_random_control_point():
				body.control()
		elif body.is_class("Pumpkin") and body.has_method("damage"):
			body.damage_taken = total_bats
			body.is_damaging = true
			body.damage()

func _on_bat_area_exited(area : Area2D) -> void:
	var body = area.get_owner()
	if is_instance_valid(body):
		if body.is_class("Pumpkin") and body.has_method("stop_damage"):
			body.stop_damage()
		if body.is_class("Candy") :
			body.queue_free()
