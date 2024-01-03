![Plugin Icon](assets/images/brand/github-social-preview.png)

[![Android version and API level](https://img.shields.io/badge/Android-API%20Level%2033-darkgreen.svg)](https://developer.android.com)
[![Godot version](https://img.shields.io/badge/Godot%20Engine-3.5.3-blue.svg)](https://github.com/godotengine/godot/)
[![Google Play Game Services version](https://img.shields.io/badge/Play%20Games%20Services%20v2-17.0.0-green.svg)](https://developers.google.com/games/services/android/quickstart)

> ⚠️ A **Godot 4.2+** version of this plugin can be found [here](https://github.com/Iakobs/godot-play-game-services)!

> ⚠️ This plugin **requires** [Google Play Games Services for Godot](https://github.com/Iakobs/godot-google-play-game-services-plugin), which is a **native plugin** for Android. The addon on the current repository only provide a global singleton with **code completion** out-of-the-box, but it's not a requirement.

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
GooglePlayGamesServices.load_game("mysavegame")
```

## Signals

These signals belong to the singleton and can be used by connecting them to a method.

```gdscript
func _ready() -> void:
    GooglePlayGamesServices.connect("all_leaderboards_loaded", self, "_on_all_leaderboards_loaded")
    GooglePlayGamesServices.load_all_leaderboards(true)


func _on_all_leaderboards_loaded(leaderboards: Array) -> void:
    prints(leaderboards)
```

### Achievements

#### achievements_loaded(achievements: Array[Dictionary])

This signal is emitted when calling the `load_achievements` method.
Returns an array of dictionaries representing the [Achievement](https://developers.google.com/android/reference/com/google/android/gms/games/achievement/Achievement) object.

#### achievement_revealed(revealed: bool, achievement_id: String)

This signal is emitted when calling the `reveal_achievement` method.
Returns `true` if the achievement is revealed and `false` otherwise. Also returns the id of the achievement.

#### achievement_unlocked(is_unlocked: bool, achievement_id: String)

This signal is emitted when calling the `increment_achievement` or `unlock_achievement` methods.
Returns `true` if the achievement is unlocked or `false` otherwise. Also returns the id of the achievement.

### Events

#### events_loaded(events: Array[Dictionary])

This signal is emitted when calling the `load_events` method.
Returns an array of dictionaries representing the [Event](https://developers.google.com/android/reference/com/google/android/gms/games/event/Event) object.

#### events_loaded_by_ids(events: Array[Dictionary])

This signal is emitted when calling the `load_events_by_ids` method.
Returns an array of dictionaries representing the [Event](https://developers.google.com/android/reference/com/google/android/gms/games/event/Event) object.

### Leaderboards

#### score_submitted(submitted: bool, leaderboard_id: String)

This signal is emitted when calling the `submit_score` method.
Returns `true` if the score is submitted. `false` otherwise. Also returns the id of the leaderboard.

#### score_loaded(leaderboard_id: String, score: Dictionary)

This signal is emitted when calling the `load_player_score` method.
Return the leaderboard id and an dictionary representing the [LeaderboardScore](https://developers.google.com/android/reference/com/google/android/gms/games/leaderboard/LeaderboardScore).

#### all_leaderboards_loaded(leaderboards: Array[Dictionary])

This signal is emitted when calling the `load_all_leaderboards` method.
Returns an array of dictionaries representing the [Leaderboard](https://developers.google.com/android/reference/com/google/android/gms/games/leaderboard/Leaderboard) object.

#### leaderboard_loaded(leaderboard: Dictionary)

This signal is emitted when calling the `load_leaderboard` method.
Returns an dictionary representing the [Leaderboard](https://developers.google.com/android/reference/com/google/android/gms/games/leaderboard/Leaderboard) object.

### Players

#### current_player_loaded(player: Dictionary)

This signal is emitted when calling the `load_current_player` method.
Returns an dictionary representing the [Player](https://developers.google.com/android/reference/com/google/android/gms/games/Player) object.

#### friends_loaded(friends: Array[Dictionary])

This signal is emitted when calling the `load_friends` method.
Returns an array of dictionaries representing the [Player](https://developers.google.com/android/reference/com/google/android/gms/games/Player) object.

#### player_searched(player: Dictionary)

This signal is emitted when selecting a player in the search window that is being displayed after calling the [search_player] method. Returns an dictionary representing the [Player](https://developers.google.com/android/reference/com/google/android/gms/games/Player) object.

### Sign In

#### user_authenticated(is_authenticated: bool)

This signal is emitted when calling the `is_authenticated` and `sign_in` methods.
Returns `true` if the user is authenticated or `false` otherwise.

#### requested_server_side_access(token: String)

This signal is emitted when calling the `request_server_side_access` method.
Returns an OAuth 2.0 authorization token as a string.

### Snapshots

#### game_saved(saved: bool, file_name: String, description: String)

This signal is emitted when calling the `save_game` method.
Returns a boolean indicating if the game was saved or not, and the name and description of the save file.

#### game_loaded(snapshot: Dictionary)

This signal is emitted when calling the `load_game` method or after selecting a saved game in the window opened by the `show_saved_games` method.
Returns an dictionary representing the [Snapshot](https://developers.google.com/android/reference/com/google/android/gms/games/snapshot/Snapshot) object.

As the loaded content is a byte array, convert it to a string first using `snapshot["content].get_string_from_utf8()`.

#### conflict_emitted(conflict: Dictionary)

This signal is emitted when saving or loading a game, whenever a conflict occurs.
Returns an dictionary representing [SnapshotConflict](https://developers.google.com/android/reference/com/google/android/gms/games/SnapshotsClient.SnapshotConflict) object.

## Methods

### Achievements

#### increment_achievement(achievement_id: String, amount: int)

Increments an achievement by the given number of steps.
The achievement must be an incremental achievement.
Once an achievement reaches at least the maximum number of steps, it will be unlocked automatically.
Any further increments will be ignored.
This is the fire-and-forget form of the API (no signals are emitted).

#### load_achievements(force_reload: bool)

Loads the achievement data for the currently signed-in player. Emits `achievements_loaded`.

#### reveal_achievement(achievement_id: String)

Reveals a hidden achievement to the currently signed-in player. If the achievement has already been unlocked, this will have no effect. Emits `achievement_revealed`.

#### show_achievements()

Shows a native popup to browse game achievements of the currently signed-in player.

#### unlock_achievement(achievement_id: String)

Unlocks an achievement for the currently signed in player. If the achievement is hidden this will reveal it to the player. Emits `achievement_unlocked`.

### Events

#### increment_event(event_id: String, amount: int)

Increments an event specified by eventId by the given number of steps.
This is the fire-and-forget form of the API (no signals are emitted).

#### load_events(force_reload: bool)

Loads the event data for the currently signed-in player. Emits `events_loaded`.

#### load_events_by_ids(force_reload: bool, event_ids: Array[String])

Loads the event data for the currently signed-in player for the specified ids. Emits `events_loaded_by_ids`.

### Leaderboards

#### show_all_leaderboards()

Shows a native popup to browse all leaderboards.

#### show_leaderboard(leaderboard_id: String)

Shows a native popup to browse the specified leaderboard.

#### show_leaderboard_for_time_span(leaderboard_id: String, time_span: Int)

Shows a native popup to browse the specified leaderboard for the specified time span.

#### show_leaderboard_for_time_span_and_collection(leaderboard_id: String, time_span: int, collection: int)

Shows a native popup to browse the specified leaderboard for the specified time span and collection.

#### submit_score(leaderboard_id: String, score: float)

Submits a score to the specified leaderboard. Emits `score_submitted`.

#### load_player_score(leaderboard_id: String, time_span: int, collection: int)

Loads the player's score for the specified leaderboard. Emits `score_loaded`.

#### load_all_leaderboards(force_reload: bool)

Loads the leaderboard data for the currently signed-in player. Emits `all_leaderboards_loaded`.

#### load_leaderboard(leaderboard_id: String, force_reload: bool)

Loads the leaderboard data for the currently signed-in player. Emits `leaderboard_loaded`

### Players

#### compare_profile(other_player_id: String)

Shows a native popup to compare two players.

#### compare_profile_with_alternative_name_hints(other_player_id: String, other_player_in_game_name: String, current_player_in_game_name: String)

Shows a native popup to compare two players with alternative name hints.

#### load_current_player(force_reload: bool)

Loads the player data for the currently signed-in player. Emits `current_player_loaded`.

#### load_friends(page_size: int, force_reload: bool, ask_for_permission: bool)

Loads the friends data for the currently signed-in player. Emits `friends_loaded`.

#### search_player()

Shows a native popup to search for players. Emits `player_searched`.

### Sign in

#### is_authenticated()

Checks if the user is signed in. Emits `user_authenticated`.

#### sign_in()

Signs in the user. Emits `user_authenticated`.

#### request_server_side_access(server_client_id: String, force_refresh_token: bool)

Requests server-side access for the specified server client ID. Emits `requested_server_side_access`.

### Snapshots

#### load_game(file_name: String)

Loads a game from the specified file. Emits `game_loaded` or `conflict_emitted`.

#### save_game(file_name: String, description: String, save_data: PoolByteArray, played_time_millis: int, progress_value: int)

Saves a game to the specified file. If saving a string, convert it to a byte array first using `"value".to_utf8()` before passing it as `save_data`. Emits `game_saved` or `conflict_emitted`.

#### show_saved_games(title: String, allow_add_button: bool, allow_delete: bool, max_snapshots: int)

Shows a native popup to browse saved games. Emits `game_loaded`.
