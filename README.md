![Plugin Icon](assets/images/brand/github-social-preview.png)

[![Android version and API level](https://img.shields.io/badge/Android-API%20Level%2033-darkgreen.svg)](https://developer.android.com)
[![Godot version](https://img.shields.io/badge/Godot%20Engine-3.5.3-blue.svg)](https://github.com/godotengine/godot/)
[![Google Play Game Services version](https://img.shields.io/badge/Play%20Games%20Services%20v2-17.0.0-green.svg)](https://developers.google.com/games/services/android/quickstart)

> ⚠️ A **Godot 4.2+** version of this plugin can be found [here](https://github.com/Iakobs/godot-play-game-services)!

> ⚠️ This plugin **requires** [Google Play Games Services for Godot](https://github.com/Iakobs/godot-google-play-game-services-android-plugin), which is a **native plugin** for Android. The addon on the current repository only provide a global singleton with **code completion** out-of-the-box, but it's not a requirement.

> ⚠️ In order to use the Google Play Game Services, you will need a Google Play Console developer account, which involves a **once in a lifetime payment of $25** at the time of writing (January 2024).

# Table of contents
- [Purpose](#purpose)
- [How to use this plugin](#how-to-use-this-plugin)
- [Autoload](#autoload)
- [Example project](#example-project)
- [Reference](#reference)
  - [Signals](#signals)
  - [Methods](#methods)

# Purpose

This is a godot 3.5+ plugin for easier integration with the [Godot Google Play Game Services Android Plugin](https://github.com/Iakobs/godot-google-play-game-services-android-plugin). While this plugin is by no means necessary to integrate Google Play Games Services to your godot project, it provides a layer of abstraction on top of the Android plugin, giving you some interesting aids like **code completion** or mapping to **typed objects**.

# How to use this plugin

This is a normal godot plugin. Just add the plugin folder called `google_play_game_services_manager` to your `addons` folder, and you should be good to go.

For further information on how to get your Google credentials for the integration, achievements, leaderboards, etc. please read the docs in the [Android plugin](https://github.com/Iakobs/godot-google-play-game-services-android-plugin).

# Autoload

The plugin provides an autoload that connect with the Android native plugin, organised in a fashion that follows the Google Play Games Services main features, like Sign In, Achievements, Leaderboards, etc.

Communication with Google Play Game Services is asynchronous, this means that you have to heavily rely on signals. The autoload methods call the Game Services and provides the subsequent signals for results.

These are the autoloads that the plugin provides so far, with their corresponding methods:

# Example project

Included with this plugin, there is a demo project that you can run to see the features of the integration with Google Play Game Services. There are some steps that you have to do first, though, which are described in the [Android native plugin docs](https://github.com/Iakobs/godot-google-play-game-services-android-plugin#configure-your-editor-android-settings).

> ⚠️ There are some ids from your game leaderboards, achievements, etc. that you need to change in the demo project interface.

# Reference

In this document is listed the autoload signals and methods available for use inside Godot with GDScript.

After you install the addon and enable it in `Project Settings...` > `Plugins`, you should be able to access its functionalities through the singleton:

```gdscript
GooglePlayGamesServices.snapshots_load_game("mysavegame")
```

## Signals

These signals belong to the singleton and can be used by connecting them to a method.

```gdscript
func _ready() -> void:
    GooglePlayGamesServices.connect("leaderboards_all_loaded", self, "_on_leaderboards_all_loaded")
    GooglePlayGamesServices.leaderboards_load_all(true)


func _on_leaderboards_all_loaded(leaderboards: Array) -> void:
    prints(leaderboards)
```

### Achievements

#### achievements_loaded(achievements: Array[Dictionary])

This signal is emitted when calling the `achievements_load` method.
Returns an array of dictionaries representing the [Achievement](https://developers.google.com/android/reference/com/google/android/gms/games/achievement/Achievement) object.

#### achievements_revealed(revealed: bool, achievement_id: String)

This signal is emitted when calling the `achievements_reveal` method.
Returns `true` if the achievement is revealed and `false` otherwise. Also returns the id of the achievement.

#### achievements_unlocked(is_unlocked: bool, achievement_id: String)

This signal is emitted when calling the `achievements_increment` or `achievements_unlock` methods.
Returns `true` if the achievement is unlocked or `false` otherwise. Also returns the id of the achievement.

### Events

#### events_loaded(events: Array[Dictionary])

This signal is emitted when calling the `events_load` method.
Returns an array of dictionaries representing the [Event](https://developers.google.com/android/reference/com/google/android/gms/games/event/Event) object.

#### events_loaded_by_ids(events: Array[Dictionary])

This signal is emitted when calling the `events_load_by_ids` method.
Returns an array of dictionaries representing the [Event](https://developers.google.com/android/reference/com/google/android/gms/games/event/Event) object.

### Leaderboards

#### leaderboards_score_submitted(submitted: bool, leaderboard_id: String)

This signal is emitted when calling the `leaderboards_submit_score` method.
Returns `true` if the score is submitted. `false` otherwise. Also returns the id of the leaderboard.

#### leaderboards_score_loaded(leaderboard_id: String, score: Dictionary)

This signal is emitted when calling the `leaderboards_load_player_score` method.
Return the leaderboard id and a dictionary representing the [LeaderboardScore](https://developers.google.com/android/reference/com/google/android/gms/games/leaderboard/LeaderboardScore).

#### leaderboards_all_loaded(leaderboards: Array[Dictionary])

This signal is emitted when calling the `leaderboards_load_all` method.
Returns an array of dictionaries representing the [Leaderboard](https://developers.google.com/android/reference/com/google/android/gms/games/leaderboard/Leaderboard) object.

#### leaderboards_loaded(leaderboard: Dictionary)

This signal is emitted when calling the `leaderboards_load` method.
Returns a dictionary representing the [Leaderboard](https://developers.google.com/android/reference/com/google/android/gms/games/leaderboard/Leaderboard) object.

#### leaderboards_player_centered_scores_loaded(leaderboard_id: String, leaderboard_scores: Dictionary)

This signal is emitted when calling the `leaderboards_load_player_centered_scores` method. Returns the leaderboard id and a dictionary representing the [LeaderboardScores](https://developers.google.com/android/reference/com/google/android/gms/games/LeaderboardsClient.LeaderboardScores) object.

#### leaderboards_top_scores_loaded(leaderboard_id: String, leaderboard_scores: Dictionary)

This signal is emitted when calling the `leaderboards_load_top_scores` method. Returns the leaderboard id and a dictionary representing the [LeaderboardScores](https://developers.google.com/android/reference/com/google/android/gms/games/LeaderboardsClient.LeaderboardScores) object.

### Players

#### players_current_loaded(player: Dictionary)

This signal is emitted when calling the `players_load_current_player` method.
Returns an dictionary representing the [Player](https://developers.google.com/android/reference/com/google/android/gms/games/Player) object.

#### players_friends_loaded(friends: Array[Dictionary])

This signal is emitted when calling the `players_load_friends` method.
Returns an array of dictionaries representing the [Player](https://developers.google.com/android/reference/com/google/android/gms/games/Player) object.

#### players_searched(player: Dictionary)

This signal is emitted when selecting a player in the search window that is being displayed after calling the [players_search] method. Returns an dictionary representing the [Player](https://developers.google.com/android/reference/com/google/android/gms/games/Player) object.

### Sign In

#### sign_in_user_authenticated(is_authenticated: bool)

This signal is emitted when calling the `sign_in_is_authenticated` and `sign_in_show_popup` methods.
Returns `true` if the user is authenticated or `false` otherwise.

#### sign_in_requested_server_side_access(token: String)

This signal is emitted when calling the `sign_in_request_server_side_access` method.
Returns an OAuth 2.0 authorization token as a string.

### Snapshots

#### snapshots_game_saved(saved: bool, file_name: String, description: String)

This signal is emitted when calling the `snapshots_save_game` method.
Returns a boolean indicating if the game was saved or not, and the name and description of the save file.

#### snapshots_game_loaded(snapshot: Dictionary)

This signal is emitted when calling the `snapshots_load_game` method or after selecting a saved game in the window opened by the `snapshots_show_saved_games` method.
Returns an dictionary representing the [Snapshot](https://developers.google.com/android/reference/com/google/android/gms/games/snapshot/Snapshot) object.

As the loaded content is a byte array, convert it to a string first using `snapshot["content].get_string_from_utf8()`.

#### snapshots_conflict_emitted(conflict: Dictionary)

This signal is emitted when saving or loading a game, whenever a conflict occurs.
Returns an dictionary representing [SnapshotConflict](https://developers.google.com/android/reference/com/google/android/gms/games/SnapshotsClient.SnapshotConflict) object.

## Methods

### Achievements

#### achievements_increment(achievement_id: String, amount: int)

Increments an achievement by the given number of steps.
The achievement must be an incremental achievement.
Once an achievement reaches at least the maximum number of steps, it will be unlocked automatically.
Any further increments will be ignored.
This is the fire-and-forget form of the API (no signals are emitted).

#### achievements_load(force_reload: bool)

Loads the achievement data for the currently signed-in player. Emits `achievements_loaded`.

#### achievements_reveal(achievement_id: String)

Reveals a hidden achievement to the currently signed-in player. If the achievement has already been unlocked, this will have no effect. Emits `achievements_revealed`.

#### achievements_show()

Shows a native popup to browse game achievements of the currently signed-in player.

#### achievements_unlock(achievement_id: String)

Unlocks an achievement for the currently signed in player. If the achievement is hidden this will reveal it to the player. Emits `achievements_unlocked`.

### Events

#### events_increment(event_id: String, amount: int)

Increments an event specified by eventId by the given number of steps.
This is the fire-and-forget form of the API (no signals are emitted).

#### events_load(force_reload: bool)

Loads the event data for the currently signed-in player. Emits `events_loaded`.

#### events_load_by_ids(force_reload: bool, event_ids: Array[String])

Loads the event data for the currently signed-in player for the specified ids. Emits `events_loaded_by_ids`.

### Leaderboards

#### leaderboards_show_all()

Shows a native popup to browse all leaderboards.

#### leaderboards_show(leaderboard_id: String)

Shows a native popup to browse the specified leaderboard.

#### leaderboards_show_for_time_span(leaderboard_id: String, time_span: Int)

Shows a native popup to browse the specified leaderboard for the specified time span.

#### leaderboards_show_for_time_span_and_collection(leaderboard_id: String, time_span: int, collection: int)

Shows a native popup to browse the specified leaderboard for the specified time span and collection.

#### leaderboards_submit_score(leaderboard_id: String, score: float)

Submits a score to the specified leaderboard. Emits `leaderboards_score_submitted`.

#### leaderboards_load_player_score(leaderboard_id: String, time_span: int, collection: int)

Loads the player's score for the specified leaderboard. Emits `leaderboards_score_loaded`.

#### leaderboards_load_all(force_reload: bool)

Loads the leaderboard data for the currently signed-in player. Emits `leaderboards_all_loaded`.

#### leaderboards_load(leaderboard_id: String, force_reload: bool)

Loads the leaderboard data for the currently signed-in player. Emits `leaderboards_loaded`

#### leaderboards_load_player_centered_scores(leaderboard_id: String, time_span: int, collection: int, max_results: int, force_reload: bool)

Loads the selected leaderboard and an array of scores for that leaderboard, centered in the currently signed in player. Emits the `leaderboards_player_centered_scores_loaded` signal.

#### leaderboards_load_top_scores(leaderboard_id: String, time_span: int, collection: int, max_results: int, force_reload: bool)

Loads the selected leaderboard and an array of scores for that leaderboard. Emits the `leaderboards_top_scores_loaded` signal.

### Players

#### players_compare_profile(other_player_id: String)

Shows a native popup to compare two players.

#### players_compare_profile_with_alternative_name_hints(other_player_id: String, other_player_in_game_name: String, current_player_in_game_name: String)

Shows a native popup to compare two players with alternative name hints.

#### players_load_current_player(force_reload: bool)

Loads the player data for the currently signed-in player. Emits `players_current_loaded`.

#### players_load_friends(page_size: int, force_reload: bool, ask_for_permission: bool)

Loads the friends data for the currently signed-in player. Emits `players_friends_loaded`.

#### players_search()

Shows a native popup to search for players. Emits `players_searched`.

### Sign in

#### sign_in_is_authenticated()

Checks if the user is signed in. Emits `sign_in_user_authenticated`.

#### sign_in_show_popup()

Signs in the user. Emits `sign_in_user_authenticated`.

#### sign_in_request_server_side_access(server_client_id: String, force_refresh_token: bool)

Requests server-side access for the specified server client ID. Emits `sign_in_requested_server_side_access`.

### Snapshots

#### snapshots_load_game(file_name: String)

Loads a game from the specified file. Emits `snapshots_game_loaded` or `snapshots_conflict_emitted`.

#### snapshots_save_game(file_name: String, description: String, save_data: PoolByteArray, played_time_millis: int, progress_value: int)

Saves a game to the specified file. If saving a string, convert it to a byte array first using `"value".to_utf8()` before passing it as `save_data`. Emits `snapshots_game_saved` or `snapshots_conflict_emitted`.

#### snapshots_show_saved_games(title: String, allow_add_button: bool, allow_delete: bool, max_snapshots: int)

Shows a native popup to browse saved games. Emits `snapshots_game_loaded`.
