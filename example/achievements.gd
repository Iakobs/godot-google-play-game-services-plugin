extends Control


# Variables
onready var _line_edit_achievements_output: LineEdit = find_node("LineEditAchievementsOutput")
onready var _line_edit_achievement_id: LineEdit = find_node("LineEditAchievementId")
onready var _spin_box_achievements_amount: SpinBox = find_node("SpinBoxAchievementsAmount")
onready var _check_button_achievements_force_reload: CheckButton = find_node("CheckButtonAchievementsForceReload")


# Built-in overrides
func _ready() -> void:
	GooglePlayGamesServices.connect("achievement_unlocked", self, "_on_achievement_unlocked")
	GooglePlayGamesServices.connect("achievements_loaded", self, "_on_achievements_loaded")
	GooglePlayGamesServices.connect("achievement_revealed", self, "_on_achievement_revealed")


# Event handlers
# Buttons
func _on_ButtonIncrementAchievement_pressed() -> void:
	GooglePlayGamesServices.increment_achievement(
		_line_edit_achievement_id.text,
		int(_spin_box_achievements_amount.value))


func _on_ButtonLoadAchievements_pressed() -> void:
	GooglePlayGamesServices.load_achievements(_check_button_achievements_force_reload.pressed)


func _on_ButtonRevealAchievement_pressed() -> void:
	GooglePlayGamesServices.reveal_achievement(_line_edit_achievement_id.text)


func _on_ButtonShowAchievements_pressed() -> void:
	GooglePlayGamesServices.show_achievements()


func _on_ButtonUnlockAchievement_pressed() -> void:
	GooglePlayGamesServices.unlock_achievement(_line_edit_achievement_id.text)


# Return values
func _on_achievements_loaded(achievements: Array) -> void:
	var value := str(achievements)
	_line_edit_achievements_output.text = value
	prints(value)


func _on_achievement_unlocked(is_unlocked: bool, achievement_id: String) -> void:
	var value := "unlocked: " + str(is_unlocked) + " (%s)" % achievement_id
	_line_edit_achievements_output.text = value
	prints(value)


func _on_achievement_revealed(revealed: bool, achievement_id: String) -> void:
	var value := "revealed: " + str(revealed) + " (%s)" % achievement_id
	_line_edit_achievements_output.text = value
	prints(value)
