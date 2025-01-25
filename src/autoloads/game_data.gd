extends Node

signal score_updated
signal game_over

@export var score: = 0:
	get:
		return score
	set(value):
		score = value
		score_updated.emit()
		
func emit_game_over():
	game_over.emit()
