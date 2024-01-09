extends Control


# Variables
onready var _line_edit_players_output: LineEdit = find_node("LineEditPlayersOutput")
onready var _line_edit_player_id: LineEdit = find_node("LineEditPlayerId")
onready var _line_edit_player_name: LineEdit = find_node("LineEditPlayerName")
onready var _line_edit_current_player_name: LineEdit = find_node("LineEditCurrentPlayerName")
onready var _spin_box_page_size: SpinBox = find_node("SpinBoxPageSize")
onready var _check_button_players_force_reload: CheckButton = find_node("CheckButtonPlayersForceReload")
onready var _check_button_ask_permission: CheckButton = find_node("CheckButtonAskPermission")


# Built-in overrides
func _ready() -> void:
	GooglePlayGamesServices.connect("players_current_loaded", self, "_on_players_current_loaded")
	GooglePlayGamesServices.connect("players_friends_loaded", self, "_on_players_friends_loaded")
	GooglePlayGamesServices.connect("players_searched", self, "_on_players_searched")


# Event handlers
# Buttons
func _on_ButtonCompareProfile_pressed() -> void:
	GooglePlayGamesServices.players_compare_profile(_line_edit_player_id.text)


func _on_ButtonCompareProfileWithAltNameHints_pressed() -> void:
	GooglePlayGamesServices.players_compare_profile_with_alternative_name_hints(
		_line_edit_player_id.text,
		_line_edit_player_name.text,
		_line_edit_current_player_name.text)


func _on_ButtonLoadCurrentPlayer_pressed() -> void:
	GooglePlayGamesServices.players_load_current(_check_button_players_force_reload.pressed)


func _on_ButtonLoadFriends_pressed() -> void:
	GooglePlayGamesServices.players_load_friends(
		int(_spin_box_page_size.value),
		_check_button_players_force_reload.pressed,
		_check_button_ask_permission.pressed)


func _on_ButtonSearchPlayer_pressed() -> void:
	GooglePlayGamesServices.players_search()


# Return values
func _on_players_current_loaded(player: Dictionary) -> void:
	var value := "player: " + str(player)
	_line_edit_players_output.text = value
	prints(value)


func _on_players_friends_loaded(friends: Array) -> void:
	var value := "friends: " + str(friends)
	_line_edit_players_output.text = value
	prints(value)


func _on_players_searched(player: Dictionary) -> void:
	var value := "player: " + str(player)
	_line_edit_players_output.text = value
	prints(value)
