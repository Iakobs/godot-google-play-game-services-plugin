extends Control


# Variables
onready var _line_edit_sign_in_output: LineEdit = find_node("LineEditSignInOutput")


# Built-in overrides
func _ready() -> void:
	GooglePlayGamesServices.connect("sign_in_user_authenticated", self, "_on_sign_in_user_authenticated")


# Event handlers
# Buttons
func _on_ButtonIsAuthenticated_pressed() -> void:
	GooglePlayGamesServices.sign_in_is_authenticated()


func _on_ButtonSignIn_pressed() -> void:
	GooglePlayGamesServices.sign_in_show_popup()


# Return values
func _on_sign_in_user_authenticated(is_authenticated: bool) -> void:
	var value := "is_authenticated: " + str(is_authenticated)
	_line_edit_sign_in_output.text = value
	prints(value)
