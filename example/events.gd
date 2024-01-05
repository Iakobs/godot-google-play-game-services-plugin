extends Control


# Variables
onready var _line_edit_output: LineEdit = find_node("LineEditOutput")
onready var _line_edit_event_id: LineEdit = find_node("LineEditEventId")
onready var _check_button_force_reload: CheckButton = find_node("CheckButtonForceReload")


# Built-in overrides
func _ready() -> void:
	GooglePlayGamesServices.connect("events_loaded", self, "_on_events_loaded")
	GooglePlayGamesServices.connect("events_loaded_by_ids", self, "_on_events_loaded")


# Event handlers
# Buttons
func _on_ButtonIncrement_pressed() -> void:
	GooglePlayGamesServices.events_increment(_line_edit_event_id.text, 1)


func _on_ButtonLoad_pressed() -> void:
	GooglePlayGamesServices.events_load(_check_button_force_reload.pressed)


func _on_ButtonLoadByIds_pressed() -> void:
	GooglePlayGamesServices.events_load_by_ids(
		_check_button_force_reload.pressed,
		_line_edit_event_id.text.split(",", false))


# Return values
func _on_events_loaded(events: Array) -> void:
	var value := str(events)
	_line_edit_output.text = value
	prints(value)
