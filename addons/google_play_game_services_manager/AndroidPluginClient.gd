class_name AndroidPluginClient
extends Node

var android_plugin

func _ready() -> void:
	if Engine.has_singleton("GodotGooglePlayGameServices") and not android_plugin:
		android_plugin = Engine.get_singleton("GodotGooglePlayGameServices")
	else:
		print("No Google Play Game Services android plugin found.")
