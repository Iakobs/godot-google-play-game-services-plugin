tool
extends EditorPlugin

func _enter_tree() -> void:
	add_autoload_singleton("GamesSignInClient", "res://addons/google_play_game_services_manager/GamesSignInClient.gd")
	add_autoload_singleton("AchievementsClient", "res://addons/google_play_game_services_manager/AchievementsClient.gd")
	add_autoload_singleton("LeaderboardsClient", "res://addons/google_play_game_services_manager/LeaderboardsClient.gd")

func _exit_tree() -> void:
	remove_autoload_singleton("GamesSignInClient")
	remove_autoload_singleton("AchievementsClient")
	remove_autoload_singleton("LeaderboardsClient")
