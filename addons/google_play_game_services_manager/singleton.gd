extends Node


# Signals
# Achievements
signal achievements_loaded(achievements)
signal achievements_revealed(revealed, achievement_id)
signal achievements_unlocked(is_unlocked, achievement_id)

# Events
signal events_loaded(events)
signal events_loaded_by_ids(events)

# Leaderboards
signal leaderboards_score_submitted(submitted, leaderboard_id)
signal leaderboards_score_loaded(leaderboard_id, score)
signal leaderboards_all_loaded(leaderboards)
signal leaderboards_loaded(leaderboard)

# Players
signal players_current_loaded(player)
signal players_friends_loaded(friends)
signal players_searched(player)

# Sign In
signal sign_in_user_authenticated(is_authenticated)
signal sign_in_requested_server_side_access(token)

# Snapshots
signal snapshots_game_saved(saved, file_name, description)
signal snapshots_game_loaded(snapshot)
signal snapshots_conflict_emitted(conflict)

# Helper
signal image_stored(image)


# Enums
enum TimeSpan {
	TIME_SPAN_DAILY = 0,
	TIME_SPAN_WEEKLY = 1,
	TIME_SPAN_ALL_TIME = 2
}

enum Collection {
	COLLECTION_PUBLIC = 0,
	COLLECTION_FRIENDS = 3
}


# Variables
var android_plugin: JNISingleton


# Built-in overrides
func _ready() -> void:
	if OS.get_name() != "Android":
		return

	if Engine.has_singleton("GodotGooglePlayGameServices"):
		android_plugin = Engine.get_singleton("GodotGooglePlayGameServices")
	else:
		prints("No Google Play Game Services Android plugin found for", name)

	if not android_plugin:
		return

	# Achievements
	android_plugin.connect("achievementsLoaded", self, "_on_achievements_loaded")
	android_plugin.connect("achievementsRevealed", self, "_on_achievements_revealed")
	android_plugin.connect("achievementsUnlocked", self, "_on_achievements_unlocked")

	# Events
	android_plugin.connect("eventsLoaded", self, "_on_events_loaded")
	android_plugin.connect("eventsLoadedByIds", self, "_on_events_loaded_by_ids")

	# Leaderboards
	android_plugin.connect("leaderboardsScoreSubmitted", self, "_on_leaderboards_score_submitted")
	android_plugin.connect("leaderboardsScoreLoaded", self, "_on_leaderboards_score_loaded")
	android_plugin.connect("leaderboardsAllLoaded", self, "_on_leaderboards_all_loaded")
	android_plugin.connect("leaderboardsLoaded", self, "_on_leaderboards_loaded")

	# Players
	android_plugin.connect("playersCurrentLoaded", self, "_on_players_current_loaded")
	android_plugin.connect("playersFriendsLoaded", self, "_on_players_friends_loaded")
	android_plugin.connect("playersSearched", self, "_on_players_searched")

	# Sign In
	android_plugin.connect("signInUserAuthenticated", self, "_on_sign_in_user_authenticated")
	android_plugin.connect("signInRequestedServerSideAccess", self, "_on_sign_in_requested_server_side_access")

	# Snapshots
	android_plugin.connect("snapshotsGameSaved", self, "_on_snapshots_game_saved")
	android_plugin.connect("snapshotsGameLoaded", self, "_on_snapshots_game_loaded")
	android_plugin.connect("snapshotsConflictEmitted", self, "_on_snapshots_conflict_emitted")

	# Helper
	android_plugin.connect("imageStored", self, "_on_image_stored")

	android_plugin.initialize()


# Public methods
# Achievements
func achievements_increment(achievement_id: String, amount: int, immediate := false) -> void:
	if android_plugin:
		android_plugin.achievementsIncrement(achievement_id, amount, immediate)


func achievements_load(force_reload := false) -> void:
	if android_plugin:
		android_plugin.achievementsLoad(force_reload)


func achievements_reveal(achievement_id: String, immediate := false) -> void:
	if android_plugin:
		android_plugin.achievementsReveal(achievement_id, immediate)


func achievements_set_steps(achievement_id: String, amount: int, immediate := false) -> void:
	if android_plugin:
		android_plugin.achievementsSetSteps(achievement_id, amount, immediate)


func achievements_show() -> void:
	if android_plugin:
		android_plugin.achievementsShow()


func achievements_unlock(achievement_id: String, immediate := false) -> void:
	if android_plugin:
		android_plugin.achievementsUnlock(achievement_id, immediate)


# Events
func events_increment(event_id: String, amount: int) -> void:
	if android_plugin:
		android_plugin.eventsIncrement(event_id, amount)


func events_load(force_reload: bool) -> void:
	if android_plugin:
		android_plugin.eventsLoad(force_reload)


func events_load_by_ids(force_reload: bool, event_ids: Array) -> void:
	if android_plugin:
		android_plugin.eventsLoadByIds(force_reload, event_ids)


# Leaderboards
func leaderboards_show_all() -> void:
	if android_plugin:
		android_plugin.leaderboardsShowAll()


func leaderboards_show(leaderboard_id: String) -> void:
	if android_plugin:
		android_plugin.leaderboardsShow(leaderboard_id)


func leaderboards_show_for_time_span(leaderboard_id: String, time_span: int) -> void:
	if android_plugin:
		android_plugin.leaderboardsShowForTimeSpan(leaderboard_id, time_span)


func leaderboards_show_for_time_span_and_collection(leaderboard_id: String, time_span: int, collection: int) -> void:
	if android_plugin:
		android_plugin.leaderboardsShowForTimeSpanAndCollection(leaderboard_id, time_span, collection)


func leaderboards_submit_score(leaderboard_id: String, score: float) -> void:
	if android_plugin:
		android_plugin.leaderboardsSubmitScore(leaderboard_id, score)


func leaderboards_load_player_score(leaderboard_id: String, time_span: int, collection: int) -> void:
	if android_plugin:
		android_plugin.leaderboardsLoadPlayerScore(leaderboard_id, time_span, collection)


func leaderboards_load_all(force_reload: bool) -> void:
	if android_plugin:
		android_plugin.leaderboardsLoadAll(force_reload)


func leaderboards_load(leaderboard_id: String, force_reload: bool) -> void:
	if android_plugin:
		android_plugin.leaderboardsLoad(leaderboard_id, force_reload)


# Players
func players_compare_profile(other_player_id: String, other_player_in_game_name := "", current_player_in_game_name := "") -> void:
	if android_plugin:
		android_plugin.playersCompareProfile(other_player_id)


func players_compare_profile_with_alternative_name_hints(other_player_id: String, other_player_in_game_name: String, current_player_in_game_name: String) -> void:
	if android_plugin:
		android_plugin.playersCompareProfileWithAlternativeNameHints(
			other_player_id,
			other_player_in_game_name,
			current_player_in_game_name
		)


func players_load_current(force_reload: bool) -> void:
	if android_plugin:
		android_plugin.playersLoadCurrent(force_reload)


func players_load_friends(page_size: int, force_reload: bool, ask_for_permission: bool) -> void:
	if android_plugin:
		android_plugin.playersLoadFriends(page_size, force_reload, ask_for_permission)


func players_search() -> void:
	if android_plugin:
		android_plugin.playersSearch()


# Sign In
func sign_in_is_authenticated() -> void:
	if android_plugin:
		android_plugin.signInIsAuthenticated()


func sign_in_request_server_side_access(client_id: String, force_refresh_token: bool) -> void:
	if android_plugin:
		android_plugin.signInRequestServerSideAccess(client_id, force_refresh_token)


func sign_in_show_popup() -> void:
	if android_plugin:
		android_plugin.signInShowPopup()


# Snapshots
func snapshots_load_game(file_name: String) -> void:
	if android_plugin:
		android_plugin.snapshotsLoadGame(file_name)


func snapshots_save_game(
	file_name: String,
	description: String,
	save_data: PoolByteArray,
	played_time_millis: int,
	progress_value: int
) -> void:
	if android_plugin:
		android_plugin.snapshotsSaveGame(file_name, description, save_data, played_time_millis, progress_value)


func snapshots_show_saved_games(title: String, allow_add_button: bool, allow_delete: bool, max_snapshots: int) -> void:
	if android_plugin:
		android_plugin.snapshotsShowSavedGames(title, allow_add_button, allow_delete, max_snapshots)


# Event handlers
# Achievements
func _on_achievements_loaded(achievements: String) -> void:
	emit_signal("achievements_loaded", JSON.parse(achievements).result)


func _on_achievements_revealed(revealed: bool, achievement_id: String) -> void:
	emit_signal("achievements_revealed", revealed, achievement_id)


func _on_achievements_unlocked(is_unlocked: bool, achievement_id: String) -> void:
	emit_signal("achievements_unlocked", is_unlocked, achievement_id)


func _on_events_loaded(events: String) -> void:
	emit_signal("events_loaded", JSON.parse(events).result)


func _on_events_loaded_by_ids(events: String) -> void:
	emit_signal("events_loaded_by_ids", JSON.parse(events).result)


# Leaderboards
func _on_leaderboards_score_submitted(submitted: bool, leaderboard_id: String) -> void:
	emit_signal("leaderboards_score_submitted", submitted, leaderboard_id)


func _on_leaderboards_score_loaded(leaderboard_id: String, score: String) -> void:
	emit_signal("leaderboards_score_loaded", leaderboard_id, JSON.parse(score).result)


func _on_leaderboards_all_loaded(leaderboards: String) -> void:
	emit_signal("leaderboards_all_loaded", JSON.parse(leaderboards).result)


func _on_leaderboards_loaded(leaderboard: String) -> void:
	emit_signal("leaderboards_loaded", JSON.parse(leaderboard).result)


# Players
func _on_players_current_loaded(player: String) -> void:
	emit_signal("players_current_loaded", JSON.parse(player).result)


func _on_players_friends_loaded(friends: String) -> void:
	emit_signal("players_friends_loaded", JSON.parse(friends).result)


func _on_players_searched(player: String) -> void:
	emit_signal("players_friends_loaded", JSON.parse(player).result)


# Sign In
func _on_sign_in_user_authenticated(_is_authenticated: bool) -> void:
	emit_signal("sign_in_user_authenticated", _is_authenticated)


func _on_sign_in_requested_server_side_access(token: String) -> void:
	emit_signal("sign_in_requested_server_side_access", token)


# Snapshots
func _on_snapshots_game_saved(saved: bool, file_name: String, description: String) -> void:
	emit_signal("snapshots_game_saved", saved, file_name, description)


func _on_snapshots_game_loaded(snapshot: String) -> void:
	var parsed_snapshot: Dictionary = JSON.parse(snapshot).result
	var content: Array = parsed_snapshot.get("content", [])

	if typeof(content) == TYPE_ARRAY:
		parsed_snapshot["content"] = PoolByteArray(content)

	emit_signal("snapshots_game_loaded", parsed_snapshot)


func _on_snapshots_conflict_emitted(conflict: String) -> void:
	emit_signal("snapshots_conflict_emitted", JSON.parse(conflict).result)


func _on_image_stored(image: String) -> void:
	emit_signal("image_stored", image)
