class_name Achievement
extends Node

const TYPE_STANDARD = "TYPE_STANDARD"
const TYPE_INCREMENTAL = "TYPE_INCREMENTAL"

const STATE_UNLOCKED = "STATE_UNLOCKED"
const STATE_REVEALED = "STATE_REVEALED"
const STATE_HIDDEN = "STATE_HIDDEN"

var achievement_id: String
var achievement_name: String
var description: String 
var type: String
var state: String
var xp_value: int
var current_steps: int
var total_steps: int
var formatted_current_steps: String
var formatted_total_steps: String
var last_updated_timestamp: int

func _init(dictionary: Dictionary):
	achievement_id = dictionary.achievementId
	achievement_name = dictionary.name
	description = dictionary.description
	type = dictionary.type
	state = dictionary.state
	xp_value = dictionary.xpValue
	current_steps = dictionary.currentSteps
	total_steps = dictionary.totalSteps
	formatted_current_steps = dictionary.formattedCurrentSteps
	formatted_total_steps = dictionary.formattedTotalSteps
	last_updated_timestamp = dictionary.lastUpdatedTimestamp
