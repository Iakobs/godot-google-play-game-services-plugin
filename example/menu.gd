extends Control


# Variables
onready var _menu_container: Container = find_node("MenuContainer")


# Built-in overrides
func _ready() -> void:
	_connect_menu_buttons()


# Private methods
func _connect_menu_buttons() -> void:
	for c in _menu_container.get_children():
		var child: Control = c

		if not child.has_signal("pressed"):
			continue

		var screen_name := child.name.replace("Button", "")
		child.connect("pressed", self, "_on_button_pressed", [screen_name])


# Event handlers
func _on_button_pressed(screen_name: String) -> void:
	get_tree().call_group("main", "show_screen", screen_name)
