tool
extends EditorPlugin


const SINGLETON_NAME := "GooglePlayGamesServices"
const SINGLETON_PATH := "res://addons/google_play_game_services_manager/singleton.gd"


# Built-in overrides
func enable_plugin() -> void:
	add_autoload_singleton(SINGLETON_NAME, SINGLETON_PATH)


func disable_plugin() -> void:
	remove_autoload_singleton(SINGLETON_NAME)
