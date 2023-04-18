extends Control

const TEST_ACHIEVEMENT_ID := "CgkIio-cpKMEEAIQAQ"
const INCREMENTAL_TEST_ACHIEVEMENT_ID := "CgkIio-cpKMEEAIQAw"
const HIDDEN_TEST_ACHIEVEMENT_ID := "CgkIio-cpKMEEAIQBA"

onready var unlock: Button = $"%Unlock"
onready var increment: Button = $"%Increment"
onready var reveal: Button = $"%Reveal"

func _ready() -> void:
	var _error := AchievementsClient.connect("reveal_success", self, "on_reveal_success")
	_error = AchievementsClient.connect("load_success", self, "on_load_success")
	
	get_achievements_info()

func on_reveal_success() -> void:
	AchievementsClient.unlock(HIDDEN_TEST_ACHIEVEMENT_ID)
	AchievementsClient.get_achievement(HIDDEN_TEST_ACHIEVEMENT_ID, true)

func on_load_success(achievements: Array) -> void:
	for element in achievements:
		on_get_success(Achievement.new(element))

func on_get_success(achievement: Achievement) -> void:
	if achievement:
		if achievement.achievement_id == TEST_ACHIEVEMENT_ID \
		&& achievement.state == achievement.STATE_UNLOCKED:
			unlock.disabled = true
		if achievement.achievement_id == INCREMENTAL_TEST_ACHIEVEMENT_ID \
		&& achievement.state == achievement.STATE_UNLOCKED:
			increment.disabled = true
		if achievement.achievement_id == HIDDEN_TEST_ACHIEVEMENT_ID \
		&& achievement.state == achievement.STATE_UNLOCKED:
			reveal.disabled = true
	else:
		print("No achievements found")

func get_achievements_info() -> void:
	AchievementsClient.load_achievements(true)

func _on_back_pressed() -> void:
	var _error = get_tree().change_scene("res://Main.tscn")

func _on_show_achievements_pressed() -> void:
	AchievementsClient.show_achievements()

func _on_unlock_pressed() -> void:
	AchievementsClient.unlock(TEST_ACHIEVEMENT_ID)
	AchievementsClient.get_achievement(TEST_ACHIEVEMENT_ID, true)

func _on_increment_pressed() -> void:
	AchievementsClient.increment(INCREMENTAL_TEST_ACHIEVEMENT_ID, 1)
	AchievementsClient.get_achievement(INCREMENTAL_TEST_ACHIEVEMENT_ID, true)

func _on_reveal_pressed() -> void:
	AchievementsClient.reveal(HIDDEN_TEST_ACHIEVEMENT_ID)
