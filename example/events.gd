extends Control


# Variables
onready var _line_edit_events_output: LineEdit = find_node("LineEditEventsOutput")
onready var _line_edit_event_id: LineEdit = find_node("LineEditEventId")
onready var _check_button_events_force_reload: CheckButton = find_node("CheckButtonEventsForceReload")


# Built-in overrides
func _ready() -> void:
	GooglePlayGamesServices.connect("events_loaded", self, "_on_events_loaded")
	GooglePlayGamesServices.connect("events_loaded_by_ids", self, "_on_events_loaded")


# Event handlers
# Buttons
func _on_ButtonIncrementEvent_pressed() -> void:
	GooglePlayGamesServices.increment_event(_line_edit_event_id.text, 1)


func _on_ButtonLoadEvents_pressed() -> void:
	GooglePlayGamesServices.load_events(_check_button_events_force_reload.pressed)


func _on_ButtonLoadEventsByIds_pressed() -> void:
	GooglePlayGamesServices.load_events_by_ids(
		_check_button_events_force_reload.pressed,
		_line_edit_event_id.text.split(",", false))


# Return values
func _on_events_loaded(events: Array) -> void:
	var value := str(events)
	_line_edit_events_output.text = value
	prints(value)
