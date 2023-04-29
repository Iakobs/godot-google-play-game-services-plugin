extends AndroidPluginClient

signal load_friends_success
signal load_friends_failure

func _ready() -> void:
	if android_plugin:
		android_plugin.connect("loadFriendsSuccess", self, "on_load_friend_success")
		android_plugin.connect("loadFriendsFailure", self, "on_load_friend_failure")

func on_load_friend_success(friends: String) -> void:
	print(friends)
	emit_signal("load_friends_success", JSON.parse(friends).result as Array)

func on_load_friend_failure() -> void:
	emit_signal("load_friends_failure")

func load_friends(page_size: int, force_reload: bool) -> void:
	if android_plugin:
		android_plugin.loadFriends(page_size, force_reload)

func compare(other_player_id: String) -> void:
	if android_plugin:
		android_plugin.compareProfile(other_player_id)

func compare_with_alternative_name_hints(
	other_player_id: String,
	other_player_in_game_name: String,
	current_player_in_game_name: String
) -> void:
	if android_plugin:
		android_plugin.compareProfileWithAlternativeNameHints(
			other_player_id,
			other_player_in_game_name,
			current_player_in_game_name
		)
