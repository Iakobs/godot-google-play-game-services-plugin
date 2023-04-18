extends Control

const TEST_LEADERBOARD_ID := "CgkIio-cpKMEEAIQAg"
const MUSICAL_NOTES_LEADERBOARD_ID := "CgkIio-cpKMEEAIQBQ"

func _on_back_pressed() -> void:
	var _error = get_tree().change_scene("res://Main.tscn")

func _on_show_all_leaderboards_pressed() -> void:
	LeaderboardsClient.show_all_leaderboards()
