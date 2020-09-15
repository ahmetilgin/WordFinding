extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
 
	var popup_size = $LevelFinish/TextureRect.get_texture().get_size()  
 
	var popup_oran = OS.window_size / popup_size
 
	$ColorRect.set_global_position(Vector2(0, 0 ))
	$LevelFinish.rect_scale.x =2 * popup_oran.x / 3
	$LevelFinish.rect_scale.y =2 * popup_oran.x / 3
	$LevelFinish.set_global_position(Vector2(OS.window_size.x /2  , OS.window_size.y /2  ))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func set_total_star(star_count):
	$LevelFinish/TotalStar.set_text(str(star_count))


func _on_Restart_pressed():
	get_tree().reload_current_scene()
	pass # Replace with function body.


func _on_LevelSelect_pressed():
	$LevelFinish.hide()
	$Node.set_visible(true)
	pass # Replace with function body.


func _on_LevelSelect_released():
	pass # Replace with function body.


func _on_MainMenu_released():
	pass # Replace with function body.
