extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ExitButton_pressed():
	.get_tree().quit()
	pass # Replace with function body.


func _on_SettingButton_pressed():
	if !Globals.game_finish:
		get_tree().paused = not get_tree().paused
		get_parent().get_parent().get_node("OptionCanvas/OptionMenu").visible = true
	pass # Replace with function body.


func _on_LeaderBoardButton_pressed():
	GoogleService.show_leaderboard()
	pass # Replace with function body.
 
