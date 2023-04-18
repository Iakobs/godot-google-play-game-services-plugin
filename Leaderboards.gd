extends Control

const TEST_LEADERBOARD_ID := "CgkIio-cpKMEEAIQAg"
const MUSICAL_NOTES_LEADERBOARD_ID := "CgkIio-cpKMEEAIQBQ"

onready var option_button: OptionButton = $"%OptionButton"
onready var submit_score: Button = $"%SubmitScore"
onready var label: Label = $"%Label"

var test_leaderboard_score := 0
var musical_notes_score := 0

func _on_back_pressed() -> void:
	var _error = get_tree().change_scene("res://Main.tscn")

func _on_show_all_leaderboards_pressed() -> void:
	LeaderboardsClient.show_all_leaderboards()

func _on_leaderboard_item_selected(index: int) -> void:
	submit_score.disabled = index == 0
	var score: int
	match(index):
		1: 
			score = test_leaderboard_score
		2: 
			score = musical_notes_score
	label.text = "Score: {0}".format([score])

func _on_submit_score_pressed() -> void:
	var leaderboard: String
	var score: int
	match(option_button.selected):
		1: 
			leaderboard = TEST_LEADERBOARD_ID
			test_leaderboard_score += 5
			score = test_leaderboard_score
		2: 
			leaderboard = MUSICAL_NOTES_LEADERBOARD_ID
			musical_notes_score += 5
			score = musical_notes_score
	label.text = "Score: {0}".format([score])
	
	LeaderboardsClient.submit_score(leaderboard, score)
