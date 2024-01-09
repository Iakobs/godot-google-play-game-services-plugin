extends Control


# Variables
onready var _line_edit_snapshots_output: LineEdit = find_node("LineEditSnapshotsOutput")
onready var _line_edit_file_name: LineEdit = find_node("LineEditFileName")
onready var _line_edit_description: LineEdit = find_node("LineEditDescription")
onready var _line_edit_save_data: LineEdit = find_node("LineEditSaveData")
onready var _spin_box_played_time_ms: SpinBox = find_node("SpinBoxPlayedTimeMs")
onready var _spin_box_progress_value: SpinBox = find_node("SpinBoxProgressValue")
onready var _line_edit_title: LineEdit = find_node("LineEditTitle")
onready var _check_button_allow_add_button: CheckButton = find_node("CheckButtonAllowAddButton")
onready var _check_button_allow_delete: CheckButton = find_node("CheckButtonAllowDelete")
onready var _spin_box_max_snapshots: SpinBox = find_node("SpinBoxMaxSnapshots")


# Built-in overrides
func _ready() -> void:
	GooglePlayGamesServices.connect("snapshots_game_saved", self, "_on_snapshots_game_saved")
	GooglePlayGamesServices.connect("snapshots_game_loaded", self, "_on_snapshots_game_loaded")
	GooglePlayGamesServices.connect("snapshots_conflict_emitted", self, "_on_snapshots_conflict_emitted")


# Event handlers
# Buttons
func _on_ButtonLoadGame_pressed() -> void:
	GooglePlayGamesServices.snapshots_load_game(_line_edit_file_name.text)


func _on_ButtonSaveGame_pressed() -> void:
	GooglePlayGamesServices.snapshots_save_game(
		_line_edit_file_name.text,
		_line_edit_description.text,
		_line_edit_save_data.text.to_utf8(),
		int(_spin_box_played_time_ms.value),
		int(_spin_box_progress_value.value))


func _on_ButtonShowSavedGames_pressed() -> void:
	GooglePlayGamesServices.snapshots_show_saved_games(
		_line_edit_title.text,
		_check_button_allow_add_button.pressed,
		_check_button_allow_delete.pressed,
		int(_spin_box_max_snapshots.value))


# Return values
func _on_snapshots_game_saved(saved: bool, file_name: String, description: String) -> void:
	var value := "saved: " + str(saved) + ", file_name: " + file_name + ", description: " + description
	_line_edit_snapshots_output.text = value
	prints(value)


func _on_snapshots_game_loaded(snapshot: Dictionary) -> void:
	var value := "snapshot: " + str(snapshot)
	_line_edit_snapshots_output.text = value
	prints(value)


func _on_snapshots_conflict_emitted(conflict: Dictionary) -> void:
	var value := "conflict: " + str(conflict)
	_line_edit_snapshots_output.text = value
	prints(value)
