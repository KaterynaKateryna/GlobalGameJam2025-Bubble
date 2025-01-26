extends Node

signal score_updated
signal goal_updated
signal game_over
signal game_won

const levels = [ 63, -125, 178, 625, 1000 ]

@export var score: = 0:
	get:
		return score
	set(value):
		score = value
		score_updated.emit()
	
@export var level: = -1:
	get:
		return level
		
@export var goal: = 0:
	get:
		return goal
	set(value):
		goal = value
		goal_updated.emit()
		
func next_level():
	print("level: %s" % level)
	if level < levels.size() - 1:
		level += 1;
		goal = levels[level]
		print("level: %s" % level)
		
		
		
func emit_game_over():
	game_over.emit()
