extends Sprite
class_name CreditBase

func is_class(value: String): return value == "CreditBase" or .is_class(value)
func get_class() -> String: return "CreditBase"

export var credit_name : String = ""

func _ready():
	$Label.visible = false
	$Label.text = credit_name

func show():
	$Label.visible = true

func hide():
	$Label.visible = false
