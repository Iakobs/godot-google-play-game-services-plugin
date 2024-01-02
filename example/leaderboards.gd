extends Control


# Variables
onready var _line_edit_leaderboards_output: LineEdit = find_node("LineEditLeaderboardsOutput")
onready var _line_edit_leaderboard_id: LineEdit = find_node("LineEditLeaderboardId")
onready var _spin_box_score: SpinBox = find_node("SpinBoxScore")
onready var _check_button_leaderboards_force_reload: CheckButton = find_node("CheckButtonLeaderboardsForceReload")
onready var _slider_timespan: HSlider = find_node("HSliderTimespan")
onready var _slider_leaderboards_collection: HSlider = find_node("HSliderLeaderboardsCollection")


# Built-in overrides
func _ready() -> void:
	GooglePlayGamesServices.connect("score_submitted", self, "_on_score_submitted")
	GooglePlayGamesServices.connect("score_loaded", self, "_on_score_loaded")
	GooglePlayGamesServices.connect("all_leaderboards_loaded", self, "_on_all_leaderboards_loaded")
	GooglePlayGamesServices.connect("leaderboard_loaded", self, "_on_leaderboard_loaded")


# Event handlers
# Buttons
func _on_ButtonShowAllLeaderboards_pressed() -> void:
	GooglePlayGamesServices.show_all_leaderboards()


func _on_ButtonShowLeaderboard_pressed() -> void:
	GooglePlayGamesServices.show_leaderboard(_line_edit_leaderboard_id.text)


func _on_ButtonShowLBForTS_pressed() -> void:
	GooglePlayGamesServices.show_leaderboard_for_time_span(
		_line_edit_leaderboard_id.text,
		int(_slider_timespan.value))


func _on_ButtonShowLBForTSAndCollection_pressed() -> void:
	GooglePlayGamesServices.show_leaderboard_for_time_span_and_collection(
		_line_edit_leaderboard_id.text,
		int(_slider_timespan.value),
		int(_slider_leaderboards_collection.value))


func _on_ButtonSubmitScore_pressed() -> void:
	GooglePlayGamesServices.submit_score(_line_edit_leaderboard_id.text, _spin_box_score.value)


func _on_ButtonLoadPlayerScore_pressed() -> void:
	GooglePlayGamesServices.load_player_score(
		_line_edit_leaderboard_id.text,
		int(_slider_timespan.value),
		int(_slider_leaderboards_collection.value))


func _on_ButtonLoadAllLeaderboards_pressed() -> void:
	GooglePlayGamesServices.load_all_leaderboards(_check_button_leaderboards_force_reload.pressed)


func _on_ButtonLoadLeaderboard_pressed() -> void:
	GooglePlayGamesServices.load_leaderboard(
		_line_edit_leaderboard_id.text,
		_check_button_leaderboards_force_reload.pressed)


# Return values
func _on_score_submitted(submitted: bool, leaderboard_id: String) -> void:
	var value := "submitted: " + str(submitted) + " (%s)" % leaderboard_id
	_line_edit_leaderboards_output.text = value
	prints(value)


func _on_score_loaded(leaderboard_id: String, score: Dictionary) -> void:
	var value := "score: " + str(score) + ", leaderboard: " + str(leaderboard_id)
	_line_edit_leaderboards_output.text = value
	prints(value)


func _on_all_leaderboards_loaded(leaderboards: Array) -> void:
	var value := "leaderboards: " + str(leaderboards)
	_line_edit_leaderboards_output.text = value
	prints(value)


func _on_leaderboard_loaded(leaderboard: Dictionary) -> void:
	var value := "leaderboard: " + str(leaderboard)
	_line_edit_leaderboards_output.text = value
	prints(value)
