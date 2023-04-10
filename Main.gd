extends Control

const TEST_ACHIEVEMENT_ID := "CgkIio-cpKMEEAIQAQ"
const INCREMENTAL_TEST_ACHIEVEMENT_ID := "CgkIio-cpKMEEAIQAw"
const HIDDEN_TEST_ACHIEVEMENT_ID := "CgkIio-cpKMEEAIQBA"

onready var signed_in_status: Label = $"%SignedInStatus"
onready var sign_in: Button = $"%SignIn"
onready var test_achievement: Button = $"%TestAchievement"
onready var increment_achievement: Button = $"%IncrementAchievement"

var manager
var is_signed_in := false
var test_achievement_unlocked := false

func _ready() -> void:
	if Engine.has_singleton("GodotGooglePlayGameServices"):
		manager = Engine.get_singleton("GodotGooglePlayGameServices")
		connect_to_signals()
		manager.initialize()
	else:
		print("No Google Play Game Services plugin found.")

func _process(_delta: float) -> void:
	sign_in.disabled = is_signed_in
	test_achievement.disabled = test_achievement_unlocked

func _on_sign_in_pressed() -> void:
	if manager:
		manager.signIn()

func _on_show_achievements_pressed() -> void:
	if manager:
		manager.showAchievements()

func _on_test_achievement_pressed() -> void:
	if manager:
		manager.unlockAchievement(TEST_ACHIEVEMENT_ID)
		test_achievement_unlocked = true

func _on_increment_achievement_pressed() -> void:
	if manager:
		manager.incrementImmediateAchievement(INCREMENTAL_TEST_ACHIEVEMENT_ID, 1)

func _on_reveal_button_pressed() -> void:
	if manager:
		manager.revealAchievement(HIDDEN_TEST_ACHIEVEMENT_ID)

func on_user_authenticated_success() -> void:
	signed_in_status.text = "You are signed in!"
	is_signed_in = true

func on_user_authenticated_failure() -> void:
	signed_in_status.text = "No :("
	is_signed_in = false

func on_increment_success(unlocked: bool) -> void:
	if unlocked:
		increment_achievement.text = "Achievemnt unlocked!"
		increment_achievement.disabled = true
	else:
		increment_achievement.text = "Keep clicking!"

func connect_to_signals() -> void:
	if manager:
		manager.connect("onUserAuthenticatedSuccess", self, "on_user_authenticated_success")
		manager.connect("onUserAuthenticatedFailure", self, "on_user_authenticated_failure")
		manager.connect("onIncrementImmediateSuccess", self, "on_increment_success")
