extends AndroidPluginClient

enum TimeSpan {
	TIME_SPAN_DAILY = 0,
	TIME_SPAN_WEEKLY = 1,
	TIME_SPAN_ALL_TIME = 2
}

enum Collection {
	COLLECTION_PUBLIC = 0,
	COLLECTION_FRIENDS = 3
}

func show_all_leaderboards() -> void:
	if android_plugin:
		android_plugin.showAllLeaderboards()

func show_leaderboard(leaderboard_id: String) -> void:
	if android_plugin:
		android_plugin.showLeaderboard(leaderboard_id)

func show_leaderboard_for_time_span(leaderboard_id: String, time_span: int) -> void:
	if android_plugin:
		android_plugin.showLeaderboardForTimeSpan(leaderboard_id, time_span)

func show_leaderboard_for_time_span_and_collection(
	leaderboard_id: String, 
	time_span: int, 
	collection: int
) -> void:
	if android_plugin:
		android_plugin.showLeaderboardForTimeSpanAndCollection(leaderboard_id, time_span, collection)
