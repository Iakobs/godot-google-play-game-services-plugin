extends AndroidPluginClient

signal is_user_authenticated_success
signal is_user_authenticated_failure
signal request_server_side_access_success
signal request_server_side_access_failure
signal sign_in_success
signal sign_in_failure

func _ready() -> void:
	if android_plugin:
		android_plugin.connect("isUserAuthenticatedSuccess", self, "on_user_authenticated_success")
		android_plugin.connect("isUserAuthenticatedFailure", self, "on_user_authenticated_success")
		android_plugin.connect("requestServerSideAccessSuccess", self, "on_request_server_side_access_success")
		android_plugin.connect("requestServerSideAccessFailure", self, "on_request_server_side_access_failure")
		android_plugin.connect("signInSuccess", self, "on_sign_in_success")
		android_plugin.connect("signInFailure", self, "on_sign_in_failure")
		android_plugin.initialize()

func on_user_authenticated_success(is_authenticated: bool) -> void:
	emit_signal("is_user_authenticated_success", is_authenticated)

func on_user_authenticated_failure() -> void:
	emit_signal("is_user_authenticated_failure")

func on_request_server_side_access_success(auth_token: String) -> void:
	emit_signal("request_server_side_access_success", auth_token)

func on_request_server_side_access_failure() -> void:
	emit_signal("request_server_side_access_failure")

func on_sign_in_success(is_authenticated: bool) -> void:
	emit_signal("sign_in_success", is_authenticated)

func on_sign_in_failure() -> void:
	emit_signal("sign_in_failure")

func is_user_authenticated() -> void:
	if android_plugin:
		android_plugin.isAuthenticated()

func request_server_side_access(client_id: String, force_refresh_token: bool) -> void:
	if android_plugin:
		android_plugin.requestServerSideAccess(client_id, force_refresh_token)

func sign_in() -> void:
	if android_plugin:
		android_plugin.signIn()
