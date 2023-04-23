![Plugin Icon](assets/images/brand/github-social-preview.png)

[![Android version and API level](https://img.shields.io/badge/Android-API%20Level%2033-darkgreen.svg)](https://developer.android.com)
[![Godot version](https://img.shields.io/badge/Godot%20Engine-3.5.2-blue.svg)](https://github.com/godotengine/godot/)
[![Google Play Game Services version](https://img.shields.io/badge/Play%20Games%20Services%20v2-17.0.0-green.svg)](https://developers.google.com/games/services/android/quickstart)

> :warning: In order to use the Google Play Game Services, you will need a Google developer account, which involves a **once in a lifetime payment of $25** at the time of writing (April 2023)

# Table of contents
* [Purpose](#purpose)
* [How to use this plugin](#how-to-use-this-plugin)
* [How NOT to use this plugin](#how-not-to-use-this-plugin)
* [Autoloads](#autoloads)
* [The demo project](#the-demo-project)

# Purpose

This is a godot 3.5.x plugin for easier integration with the [Godot Google Play Game Services Android Plugin](https://github.com/Iakobs/godot-google-play-game-services-android-plugin). While this plugin is by no means necessary to integrate Google play game services to your godot project, it provides a layer of abstraction on top of the android plugin, giving you some interesting aids like **code completion** or mapping to **typed objects**.

# How to use this plugin

This is a normal godot plugin. Just add the plugin folder called `google_play_game_services_manager` to your `addons` folder, and you should be good to go :)

For further information on how to get your Google credentials for the integration, achievements, leaderboards, etc. please read the docs in the [android plugin](https://github.com/Iakobs/godot-google-play-game-services-android-plugin).

# How NOT to use this plugin

Due to some limitations, this plugin doesn't provide ALL the features of the Google game services libraries, such as receiving images of leaderboards, achievements, etc. or some complex data objects which don't have translations from java to gdscript, like URIs or some library specific objects. Please, read also the [docs of the Google Play Game Services library](https://developers.google.com/games/services/android/quickstart?hl=en) and the [API reference](https://developers.google.com/android/reference/packages) provided by Google.

# Autoloads

The plugin provide some autoloads that connect with the android plugin, organised in a fashion that follows the Google play game services main features, like Signing ing, Achievements, Leaderboards, etc.

Communication with Google Play Game Services is asynchronous, this means that you have to heavily rely on signals. Every autoload exposes some methods to call the Game Services and provides the subsequent signals for success or failure. The naming pattern is always the same: `method_name_success` or `method_name_failure`.

You will also see that you have some types created, like the `Achievement` type, and the mapping between the JSON object coming from the android plugin to the godot type is handled also by the plugin.

These are the autoloads that the plugin provides so far, with their corresponding methods:

* GamesSignInClient
  * `func is_user_authenticated() -> void`
  * `func request_server_side_access(client_id: String, force_refresh_token: bool) -> void`
  * `func sign_in() -> void`
* AchievementsClient
  * `func increment(achievement_id: String, amount: int) -> void`
  * `func load_achievements(force_reload: bool) -> void`
  * `func reveal(achievement_id: String) -> void`
  * `func show_achievements() -> void`
  * `func unlock(achievement_id) -> void`
* LeaderboardsClient
  * `func show_all_leaderboards() -> void`
  * `func show_leaderboard(leaderboard_id: String) -> void`
  * `func show_leaderboard_for_time_span(leaderboard_id: String, time_span: int) -> void`
  * ```gdscript
    func show_leaderboard_for_time_span_and_collection(
	    leaderboard_id: String, 
	    time_span: int, 
	    collection: int
    ) -> void
    ```
  * `func submit_score(leaderboard_id: String, score: int) -> void`

# The demo project

Included with this plugin, there is a demo project that you can run to see the features of the integration with Google Play Game Services. There are some steps that you have to do first, though, which are described in the [android plugin docs](https://github.com/Iakobs/godot-google-play-game-services-android-plugin#configure-your-editor-android-settings).

> :warning: There are some ids from your game, leaderboards, achievements, etc. that you need to change in the `GameSecrets.gd` file.
