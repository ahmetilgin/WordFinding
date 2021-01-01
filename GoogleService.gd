extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var play_games_services
const LEADERBOARD_ID = "CgkIp_ar1KUTEAIQAA"

signal load_game(data)
# Called when the node enters the scene tree for the first time.
func _ready():

# Check if plugin was added to the project
	if Engine.has_singleton("GodotPlayGamesServices"):
		play_games_services = Engine.get_singleton("GodotPlayGamesServices")

		# Initialize plugin by calling init method and passing to it a boolean to enable/disable displaying game pop-ups
		var show_popups := true 
		play_games_services.init(show_popups)
		# For enabling saved games functionality use below initialization instead
		# play_games_services.initWithSavedGames(show_popups, "SavedGamesName")
		# play_games_services.initWithSavedGames(show_popups, "saved_game")
		# Connect callbacks (Use only those that you need)
		play_games_services.connect("_on_sign_in_success", self, "_on_sign_in_success") # account_id: String
		play_games_services.connect("_on_sign_in_failed", self, "_on_sign_in_failed") # error_code: int
		play_games_services.connect("_on_sign_out_success", self, "_on_sign_out_success") # no params
		play_games_services.connect("_on_sign_out_failed", self, "_on_sign_out_failed") # no params
		play_games_services.connect("_on_achievement_unlocked", self, "_on_achievement_unlocked") # achievement: String
		play_games_services.connect("_on_achievement_unlocking_failed", self, "_on_achievement_unlocking_failed") # achievement: String
		play_games_services.connect("_on_achievement_revealed", self, "_on_achievement_revealed") # achievement: String
		play_games_services.connect("_on_achievement_revealing_failed", self, "_on_achievement_revealing_failed") # achievement: String
		play_games_services.connect("_on_achievement_incremented", self, "_on_achievement_incremented") # achievement: String
		play_games_services.connect("_on_achievement_incrementing_failed", self, "_on_achievement_incrementing_failed") # achievement: String
		play_games_services.connect("_on_achievement_info_loaded", self, "_on_achievement_info_loaded") # achievements_json : String
		play_games_services.connect("_on_achievement_info_load_failed", self, "_on_achievement_info_load_failed")
		play_games_services.connect("_on_leaderboard_score_submitted", self, "_on_leaderboard_score_submitted") # leaderboard_id: String
		play_games_services.connect("_on_leaderboard_score_submitting_failed", self, "_on_leaderboard_score_submitting_failed") # leaderboard_id: String no params
		play_games_services.connect("_on_create_new_snapshot", self, "_on_create_new_snapshot") # name: String
		play_games_services.connect("_on_player_info_loaded", self, "_on_player_info_loaded")  # json_response: String
		play_games_services.connect("_on_player_info_loading_failed", self, "_on_player_info_loading_failed")
		play_games_services.connect("_on_player_stats_loaded", self, "_on_player_stats_loaded")  # json_response: String
		play_games_services.connect("_on_player_stats_loading_failed", self, "_on_player_stats_loading_failed")
		play_games_services.signIn()

	pass # Replace with function body.
func show_leaderboard():
	play_games_services.showLeaderBoard(LEADERBOARD_ID)

# Callbacks:
func _on_leaderboard_score_submitted(leaderboard_id: String):
	pass

func _on_leaderboard_score_submitting_failed(leaderboard_id: String):
	pass
	
func _on_sign_in_success(account_id: String) -> void:
	pass
  
func _on_sign_in_failed(error_code: int) -> void:
	pass


func submit_score(score):
	if(play_games_services != null):
		play_games_services.submitLeaderBoardScore(LEADERBOARD_ID, score)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
