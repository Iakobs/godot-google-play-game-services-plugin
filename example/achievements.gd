extends Control


# Variables
onready var _line_edit_output: LineEdit = find_node("LineEditOutput")
onready var _line_edit_achievement_id: LineEdit = find_node("LineEditAchievementId")
onready var _spin_box_amount: SpinBox = find_node("SpinBoxAmount")
onready var _check_button_force_reload: CheckButton = find_node("CheckButtonForceReload")
onready var _check_button_immediate: CheckButton = find_node("CheckButtonImmediate")


# Built-in overrides
func _ready() -> void:
	GooglePlayGamesServices.connect("achievements_unlocked", self, "_on_achievements_unlocked")
	GooglePlayGamesServices.connect("achievements_loaded", self, "_on_achievements_loaded")
	GooglePlayGamesServices.connect("achievements_revealed", self, "_on_achievements_revealed")


# Event handlers
# Buttons
func _on_ButtonIncrement_pressed() -> void:
	GooglePlayGamesServices.achievements_increment(
		_line_edit_achievement_id.text,
		int(_spin_box_amount.value),
		_check_button_immediate.pressed)


func _on_ButtonLoad_pressed() -> void:
	GooglePlayGamesServices.achievements_load(_check_button_force_reload.pressed)


func _on_ButtonReveal_pressed() -> void:
	GooglePlayGamesServices.achievements_reveal(_line_edit_achievement_id.text, _check_button_immediate.pressed)


func _on_ButtonSetSteps_pressed() -> void:
	GooglePlayGamesServices.achievements_set_steps(
		_line_edit_achievement_id.text,
		int(_spin_box_amount.value),
		_check_button_immediate.pressed)


func _on_ButtonShow_pressed() -> void:
	GooglePlayGamesServices.achievements_show()


func _on_ButtonUnlock_pressed() -> void:
	GooglePlayGamesServices.achievements_unlock(_line_edit_achievement_id.text, _check_button_immediate.pressed)


# Return values
func _on_achievements_loaded(achievements: Array) -> void:
	var value := str(achievements)
	_line_edit_output.text = value
	prints(value)


func _on_achievements_unlocked(is_unlocked: bool, achievement_id: String) -> void:
	var value := "unlocked: " + str(is_unlocked) + " (%s)" % achievement_id
	_line_edit_output.text = value
	prints(value)


func _on_achievements_revealed(revealed: bool, achievement_id: String) -> void:
	var value := "revealed: " + str(revealed) + " (%s)" % achievement_id
	_line_edit_output.text = value
	prints(value)
