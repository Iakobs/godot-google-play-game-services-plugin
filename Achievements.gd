extends Control

const TEST_ACHIEVEMENT_ID := "CgkIio-cpKMEEAIQAQ"
const INCREMENTAL_TEST_ACHIEVEMENT_ID := "CgkIio-cpKMEEAIQAw"
const HIDDEN_TEST_ACHIEVEMENT_ID := "CgkIio-cpKMEEAIQBA"

func _ready() -> void:
	var _error := AchievementsClient.connect("reveal_success", self, "on_reveal_success")

func on_reveal_success() -> void:
	AchievementsClient.unlock(HIDDEN_TEST_ACHIEVEMENT_ID)

func _on_back_pressed() -> void:
	get_tree().change_scene("res://Main.tscn")

func _on_show_achievements_pressed() -> void:
	AchievementsClient.show_achievements()

func _on_unlock_pressed() -> void:
	AchievementsClient.unlock(TEST_ACHIEVEMENT_ID)

func _on_increment_pressed() -> void:
	AchievementsClient.increment(INCREMENTAL_TEST_ACHIEVEMENT_ID, 1)

func _on_reveal_pressed() -> void:
	AchievementsClient.reveal(HIDDEN_TEST_ACHIEVEMENT_ID)
