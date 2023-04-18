extends Control

const CLIENT_ID := "146910152586-hsdmc3na0dhklhmjkvphfkr172lujh1t.apps.googleusercontent.com"

onready var signed_in_status: Label = $"%SignedInStatus"
onready var sign_in: Button = $"%SignIn"
onready var user_authenticated: Button = $"%UserAuthenticated"
onready var token_label: Label = $"%TokenLabel"

var is_signed_in := false

var cross_icon := preload("res://assets/images/kenney_game_icons/White/1x/cross.png")
var checkmark_icon := preload("res://assets/images/kenney_game_icons/White/1x/checkmark.png")

func _ready() -> void:
	var _error = GamesSignInClient.connect("is_user_authenticated_success", self, "on_is_user_authenticated_success")
	_error = GamesSignInClient.connect("is_user_authenticated_failure", self, "on_is_user_authenticated_failure")
	_error = GamesSignInClient.connect("request_server_side_access_success", self, "on_request_server_side_access_success")
	_error = GamesSignInClient.connect("request_server_side_access_failure", self, "on_request_server_side_access_failure")
	_error = GamesSignInClient.connect("sign_in_success", self, "on_is_user_authenticated_success")
	_error = GamesSignInClient.connect("sign_in_failure", self, "on_is_user_authenticated_failure")
	GamesSignInClient.is_user_authenticated()

func _process(_delta: float) -> void:
	process_sign_in()

func process_sign_in() -> void:
	if is_signed_in:
		signed_in_status.text = "You are signed in!"
		sign_in.disabled = true
		user_authenticated.icon = checkmark_icon
	else:
		signed_in_status.text = "No :("
		sign_in.disabled = false
		user_authenticated.icon = cross_icon

func on_is_user_authenticated_success(is_authenticated: bool) -> void:
	is_signed_in = is_authenticated

func on_is_user_authenticated_failure() -> void:
	is_signed_in = false

func on_request_server_side_access_success(auth_token: String) -> void:
	var trimmed_token := auth_token if auth_token.length() <= 15 else auth_token.left(12) + "..."
	token_label.text = "Token: " + trimmed_token

func on_request_server_side_access_failure() -> void:
	token_label.text = "An error occurred while retrieving token"

func _on_user_authenticated_pressed() -> void:
	GamesSignInClient.is_user_authenticated()

func _on_request_token_pressed() -> void:
	GamesSignInClient.request_server_side_access(CLIENT_ID, true)

func _on_sign_in_pressed() -> void:
	GamesSignInClient.sign_in()

func _on_achievements_pressed() -> void:
	var _error = get_tree().change_scene("res://Achievements.tscn")

func _on_leaderboards_pressed() -> void:
	var _error = get_tree().change_scene("res://Leaderboards.tscn")
