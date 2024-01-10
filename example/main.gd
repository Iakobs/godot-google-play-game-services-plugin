extends Control


# Variables
onready var _container_screens: Container = find_node("ContainerScreens")
onready var _container_footer: Container = find_node("ContainerFooter")


# Built-in overrides
func _ready() -> void:
	show_screen("Menu")


# Public methods
func show_screen(screen: String) -> void:
	_container_footer.visible = screen != "Menu"

	for c in _container_screens.get_children():
		var child: Control = c
		child.visible = child.name == screen


# Event handlers
# Buttons
func _on_ButtonBack_pressed() -> void:
	show_screen("Menu")
