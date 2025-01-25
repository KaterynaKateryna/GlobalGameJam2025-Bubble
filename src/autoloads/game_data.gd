extends Node

signal score_updated

@export var score: = 0:
	get:
		return score
	set(value):
		score = value
		score_updated.emit()
