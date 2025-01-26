extends CanvasLayer

@onready var score_label: Label = get_node("ScoreLabel")
@onready var goal_label: Label = get_node("GoalLabel")
@onready var level_label: Label = get_node("LevelLabel")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameData.score_updated.connect(update_interface)
	GameData.goal_updated.connect(update_goal)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func update_interface() -> void:
	score_label.text = "Score: %s" %GameData.score
	
func update_goal() -> void:
	level_label.text = "Level: %s" % [ GameData.level + 1 ]
	goal_label.text = "Your goal is exactly: %s" % GameData.goal
