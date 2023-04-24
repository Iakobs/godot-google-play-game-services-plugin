class_name Player
extends Resource

const VISIBILITY_FEATURE_UNAVAILABLE = "FEATURE_UNAVAILABLE"
const VISIBILITY_REQUEST_REQUIRED = "REQUEST_REQUIRED"
const VISIBILITY_UNKNOWN = "UNKNOWN"
const VISIBILITY_VISIBLE = "VISIBLE"

const FRIEND_STATUS_FRIEND = "FRIEND"
const FRIEND_STATUS_NO_RELATIONSHIP = "NO_RELATIONSHIP"
const FRIEND_STATUS_UNKNOWN = "UNKNOWN"

var banner_image_landscape_uri: String
var banner_image_portrait_uri: String
var friends_list_visibility_status: String
var display_name: String
var hi_res_image_uri: String
var level_info: PlayerLevelInfo
var player_id: String
var friend_status: String
var retrievedTimestamp: int
var title: String
var has_hi_res_image: bool
var has_icon_image: bool

func _init(dictionary: Dictionary):
	banner_image_landscape_uri = dictionary.bannerImageLandscapeUri
	banner_image_portrait_uri = dictionary.bannerImagePortraitUri
	friends_list_visibility_status = dictionary.friendsListVisibilityStatus
	display_name = dictionary.displayName
	hi_res_image_uri = dictionary.hiResImageUri
	level_info = PlayerLevelInfo.new(dictionary.levelInfo)
	player_id = dictionary.playerId
	friend_status = dictionary.friendStatus
	retrievedTimestamp = dictionary.retrievedTimestamp
	title = dictionary.title
	has_hi_res_image = dictionary.hasHiResImage
	has_icon_image = dictionary.hasIconImage
