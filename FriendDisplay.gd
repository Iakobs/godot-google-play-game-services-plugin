extends Control

onready var display_name: Label = $"%DisplayName"
onready var title: Label = $"%Title"
onready var current_level: Label = $"%CurrentLevel"
onready var friend_status: Label = $"%FriendStatus"

export(Resource) var friend_resource: Resource

func _ready() -> void:
	var friend := friend_resource as Player
	display_name.text = friend.display_name
	title.text = friend.title
	current_level.text = String(friend.level_info.current_level.level_number)
	friend_status.text = friend.friend_status
