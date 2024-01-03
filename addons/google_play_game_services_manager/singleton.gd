extends Node


# Signals
# Achievements
signal achievements_loaded(achievements)
signal achievement_revealed(revealed, achievement_id)
signal achievement_unlocked(is_unlocked, achievement_id)

# Events
signal events_loaded(events)
signal events_loaded_by_ids(events)

# Leaderboards
signal score_submitted(submitted, leaderboard_id)
signal score_loaded(leaderboard_id, score)
signal all_leaderboards_loaded(leaderboards)
signal leaderboard_loaded(leaderboard)

# Players
signal current_player_loaded(player)
signal friends_loaded(friends)
signal player_searched(player)

# Sign In
signal user_authenticated(is_authenticated)

# Snapshots
signal game_saved(saved, file_name, description)
signal game_loaded(snapshot)
signal conflict_emitted(conflict)


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
	android_plugin.connect("achievementRevealed", self, "_on_achievement_revealed")
	android_plugin.connect("achievementUnlocked", self, "_on_achievement_unlocked")

	# Events
	android_plugin.connect("eventsLoaded", self, "_on_events_loaded")
	android_plugin.connect("eventsLoadedByIds", self, "_on_events_loaded_by_ids")

	# Leaderboards
	android_plugin.connect("scoreSubmitted", self, "_on_score_submitted")
	android_plugin.connect("scoreLoaded", self, "_on_score_loaded")
	android_plugin.connect("allLeaderboardsLoaded", self, "_on_all_leaderboards_loaded")
	android_plugin.connect("leaderboardLoaded", self, "_on_leaderboard_loaded")

	# Players
	android_plugin.connect("currentPlayerLoaded", self, "_on_current_player_loaded")
	android_plugin.connect("friendsLoaded", self, "_on_friends_loaded")
	android_plugin.connect("playerSearched", self, "_on_player_searched")

	# Sign In
	android_plugin.connect("userAuthenticated", self, "_on_user_authenticated")

	# Snapshots
	android_plugin.connect("gameSaved", self, "_on_game_saved")
	android_plugin.connect("gameLoaded", self, "_on_game_loaded")
	android_plugin.connect("conflictEmitted", self, "_on_conflict_emitted")

	android_plugin.initialize()


# Public methods
# Achievements
func increment_achievement(achievement_id: String, amount: int) -> void:
	if android_plugin:
		android_plugin.incrementAchievement(achievement_id, amount)


func load_achievements(force_reload: bool) -> void:
	if android_plugin:
		android_plugin.loadAchievements(force_reload)


func reveal_achievement(achievement_id: String) -> void:
	if android_plugin:
		android_plugin.revealAchievement(achievement_id)


func show_achievements() -> void:
	if android_plugin:
		android_plugin.showAchievements()


func unlock_achievement(achievement_id: String) -> void:
	if android_plugin:
		android_plugin.unlockAchievement(achievement_id)


# Events
func increment_event(event_id: String, amount: int) -> void:
	if android_plugin:
		android_plugin.incrementEvent(event_id, amount)


func load_events(force_reload: bool) -> void:
	if android_plugin:
		android_plugin.loadEvents(force_reload)


func load_events_by_ids(force_reload: bool, event_ids: Array) -> void:
	if android_plugin:
		android_plugin.loadEventsByIds(force_reload, event_ids)


# Leaderboards
func show_all_leaderboards() -> void:
	if android_plugin:
		android_plugin.showAllLeaderboards()


func show_leaderboard(leaderboard_id: String) -> void:
	if android_plugin:
		android_plugin.showLeaderboard(leaderboard_id)


func show_leaderboard_for_time_span(leaderboard_id: String, time_span: int) -> void:
	if android_plugin:
		android_plugin.showLeaderboardForTimeSpan(leaderboard_id, time_span)


func show_leaderboard_for_time_span_and_collection(leaderboard_id: String, time_span: int, collection: int) -> void:
	if android_plugin:
		android_plugin.showLeaderboardForTimeSpanAndCollection(leaderboard_id, time_span, collection)


func submit_score(leaderboard_id: String, score: float) -> void:
	if android_plugin:
		android_plugin.submitScore(leaderboard_id, score)


func load_player_score(leaderboard_id: String, time_span: int, collection: int) -> void:
	if android_plugin:
		android_plugin.loadPlayerScore(leaderboard_id, time_span, collection)


func load_all_leaderboards(force_reload: bool) -> void:
	if android_plugin:
		android_plugin.loadAllLeaderboards(force_reload)


func load_leaderboard(leaderboard_id: String, force_reload: bool) -> void:
	if android_plugin:
		android_plugin.loadLeaderboard(leaderboard_id, force_reload)


# Players
func compare_profile(other_player_id: String) -> void:
	if android_plugin:
		android_plugin.compareProfile(other_player_id)


func compare_profile_with_alternative_name_hints(other_player_id: String, other_player_in_game_name: String, current_player_in_game_name: String) -> void:
	if android_plugin:
		android_plugin.compareProfileWithAlternativeNameHints(
			other_player_id,
			other_player_in_game_name,
			current_player_in_game_name
		)


func load_current_player(force_reload: bool) -> void:
	if android_plugin:
		android_plugin.loadCurrentPlayer(force_reload)


func load_friends(page_size: int, force_reload: bool, ask_for_permission: bool) -> void:
	if android_plugin:
		android_plugin.loadFriends(page_size, force_reload, ask_for_permission)


func search_player() -> void:
	if android_plugin:
		android_plugin.searchPlayer()


# Sign In
func is_authenticated() -> void:
	if android_plugin:
		android_plugin.isAuthenticated()


func request_server_side_access(client_id: String, force_refresh_token: bool) -> void:
	if android_plugin:
		android_plugin.requestServerSideAccess(client_id, force_refresh_token)


func sign_in() -> void:
	if android_plugin:
		android_plugin.signIn()


# Snapshots
func load_game(file_name: String) -> void:
	if android_plugin:
		android_plugin.loadGame(file_name)


func save_game(
	file_name: String,
	description: String,
	save_data: PoolByteArray,
	played_time_millis: int,
	progress_value: int
) -> void:
	if android_plugin:
		android_plugin.saveGame(file_name, description, save_data, played_time_millis, progress_value)


func show_saved_games(title: String, allow_add_button: bool, allow_delete: bool, max_snapshots: int) -> void:
	if android_plugin:
		android_plugin.showSavedGames(title, allow_add_button, allow_delete, max_snapshots)


# Event handlers
# Achievements
func _on_achievements_loaded(achievements: String) -> void:
	emit_signal("achievements_loaded", JSON.parse(achievements).result)


func _on_achievement_revealed(revealed: bool, achievement_id: String) -> void:
	emit_signal("achievement_revealed", revealed, achievement_id)


func _on_achievement_unlocked(is_unlocked: bool, achievement_id: String) -> void:
	emit_signal("achievement_unlocked", is_unlocked, achievement_id)


func _on_events_loaded(events: String) -> void:
	emit_signal("events_loaded", JSON.parse(events).result)


func _on_events_loaded_by_ids(events: String) -> void:
	emit_signal("events_loaded_by_ids", JSON.parse(events).result)


# Leaderboards
func _on_score_submitted(submitted: bool, leaderboard_id: String) -> void:
	emit_signal("score_submitted", submitted, leaderboard_id)


func _on_score_loaded(leaderboard_id: String, score: String) -> void:
	emit_signal("score_loaded", leaderboard_id, JSON.parse(score).result)


func _on_all_leaderboards_loaded(leaderboards: String) -> void:
	emit_signal("all_leaderboards_loaded", JSON.parse(leaderboards).result)


func _on_leaderboard_loaded(leaderboard: String) -> void:
	emit_signal("leaderboard_loaded", JSON.parse(leaderboard).result)


# Players
func _on_current_player_loaded(player: String) -> void:
	emit_signal("current_player_loaded", JSON.parse(player).result)


func _on_friends_loaded(friends: String) -> void:
	emit_signal("friends_loaded", JSON.parse(friends).result)


func _on_player_searched(player: String) -> void:
	emit_signal("friends_loaded", JSON.parse(player).result)


# Sign In
func _on_user_authenticated(_is_authenticated: bool) -> void:
	emit_signal("user_authenticated", _is_authenticated)


# Snapshots
func _on_game_saved(saved: bool, file_name: String, description: String) -> void:
	emit_signal("game_saved", saved, file_name, description)


func _on_game_loaded(snapshot: String) -> void:
	var parsed_snapshot: Dictionary = JSON.parse(snapshot).result
	var content: Array = parsed_snapshot.get("content", [])

	if typeof(content) == TYPE_ARRAY:
		parsed_snapshot["content"] = PoolByteArray(content)

	emit_signal("game_loaded", parsed_snapshot)


func _on_conflict_emitted(conflict: String) -> void:
	emit_signal("conflict_emitted", JSON.parse(conflict).result)
