class_name PlayerLevelInfo
extends Resource

var current_level: PlayerLevel
var current_xp_total: int
var last_level_up_timestamp: int
var next_level: PlayerLevel
var is_max_level: bool

func _init(dictionary: Dictionary):
	current_level = PlayerLevel.new(dictionary.currentLevel)
	current_xp_total = dictionary.currentXpTotal
	last_level_up_timestamp = dictionary.lastLevelUpTimestamp
	next_level = PlayerLevel.new(dictionary.nextLevel)
	is_max_level = dictionary.isMaxLevel
