extends Control

onready var friends_list: VBoxContainer = $"%FriendsList"

var friend_display := preload("res://FriendDisplay.tscn")

func _ready() -> void:
	var _error := FriendsClient.connect("load_friends_success", self, "on_load_friends_success")

func on_load_friends_success(friends: Array) -> void:
	for friend in friends:
		var container := friend_display.instance() as Control
		var player := Player.new(friend)
		print("Displaying friend {0}".format([player]))
		container.friend_resource = player
		friends_list.add_child(container)

func _on_back_pressed() -> void:
	var _error = get_tree().change_scene("res://Main.tscn")

func _on_show_friends_pressed() -> void:
	for child in friends_list.get_children():
		child.queue_free()
	FriendsClient.load_friends(5, true)
