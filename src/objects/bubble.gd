extends StaticBody2D

@onready var modifier_label = get_node("ModifierLabel")

var modifier = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if modifier:
		modifier_label.text = modifier
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func get_modifier():
	if modifier:
		return modifier
	return "+1"
