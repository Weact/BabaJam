extends BatBase
class_name BatEntity

func is_class(value: String): return value == "BatEntity" or .is_class(value)
func get_class() -> String: return "BatEntity"

onready var anim_player : AnimationPlayer = get_node("AnimationPlayer")
onready var area_collision : CollisionShape2D = get_node("Area2D/Collision")

var is_controlled : bool = false
var point_pos : Vector2 = Vector2.ZERO

var level : int = 1

func add_level() -> void:
	level += 1

func _ready() -> void:
	if is_instance_valid(get_parent()) and is_instance_valid(get_parent().get_parent()):
		var n = get_parent().get_parent().get_name()
		if n == "ControlPoints":
			match(level):
				1:
					pass
				2:
					set_modulate(Color.orange)
			is_controlled = true
			area_collision.set_disabled(true)
	if not is_controlled:
		anim_player.play("Appear")

func _physics_process(_delta: float) -> void:
	pass

func control() -> void:
	queue_free()
