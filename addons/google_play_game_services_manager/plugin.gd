tool
extends EditorPlugin

func _enter_tree() -> void:
	add_autoload_singleton("GamesSignInClient", "res://addons/google_play_game_services_manager/GamesSignInClient.gd")

func _exit_tree() -> void:
	remove_autoload_singleton("GamesSignInClient")
