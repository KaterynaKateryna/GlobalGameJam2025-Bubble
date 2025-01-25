extends CanvasLayer

@onready var score_label: Label = get_node("ScoreLabel")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameData.score_updated.connect(update_interface)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func update_interface() -> void:
	score_label.text = "Score: %s" %GameData.score
