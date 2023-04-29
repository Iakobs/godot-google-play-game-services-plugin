extends Control

onready var display_name: Label = $"%DisplayName"
onready var title: Label = $"%Title"
onready var current_level: Label = $"%CurrentLevel"
onready var friend_status: Label = $"%FriendStatus"

export(Resource) var friend_resource: Resource

var friend: Player

func _ready() -> void:
	friend = friend_resource as Player
	display_name.text = friend.display_name
	title.text = friend.title
	current_level.text = String(friend.level_info.current_level.level_number)
	friend_status.text = friend.friend_status

func _on_compare_pressed() -> void:
	FriendsClient.compare(friend.player_id)
