extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#	var popup_size = $LevelFinish/TextureRect.get_texture().get_size()  
#
#	var popup_oran = OS.window_size / popup_size
#	$ColorRect/ColorRect.rect_size = OS.window_size
#	$ColorRect.set_global_position(Vector2(0, 0 ))
#	$LevelFinish.rect_scale.x = 4 * popup_oran.x / 5
#	$LevelFinish.rect_scale.y = 4 * popup_oran.x / 5
#	$LevelFinish.set_global_position(Vector2(OS.window_size.x /2  , OS.window_size.y /2  ))
#	pass # Replace with function body.


# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect.rect_size = OS.window_size
	$ColorRect.set_global_position(Vector2(0, 0 ))
	var textureoption_size = $TextureRect.get_texture().get_size()  
	var textureoption_oran = OS.window_size / textureoption_size
	$TextureRect.rect_scale.x = textureoption_oran.x
	$TextureRect.rect_scale.y = textureoption_oran.x
	$TextureRect.set_global_position(Vector2(0  , OS.window_size.y /6  ))
	if(Globals.is_play_sfx):
		$TextureRect/Audio/SFX.set_pressed(false)
	else:
		$TextureRect/Audio/SFX.set_pressed(true)
	if(Globals.is_play_music):
		$TextureRect/Audio/Music.set_pressed(false)
	else:
		$TextureRect/Audio/Music.set_pressed(true)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	 
#	pass


func _on_Exit_pressed():
	get_tree().paused = not get_tree().paused
	$".".visible = false
	pass # Replace with function body.


func _on_Music_toggled(button_pressed):
	if(button_pressed):
		Globals.is_play_music = false
	else:
		Globals.is_play_music = true
	pass # Replace with function body.


func _on_SFX_toggled(button_pressed):
	if(button_pressed):
		Globals.is_play_sfx = false
	else:
		Globals.is_play_sfx = true
	pass # Replace with function body.
