class_name PlayerLevel
extends Resource

var level_number: int
var max_xp: int
var min_xp: int

func _init(dictionary: Dictionary):
	level_number = dictionary.levelNumber
	max_xp = dictionary.maxXp
	min_xp = dictionary.minXp
