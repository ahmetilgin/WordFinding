extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var money_count = 0
var sum_count = 0
# Called when the node enters the scene tree for the first time.
func _ready():
 
	var popup_size = $LevelFinish/TextureRect.get_texture().get_size()  
 
	var popup_oran = OS.window_size / popup_size
	$ColorRect/ColorRect.rect_size = OS.window_size
	$ColorRect.set_global_position(Vector2(0, 0 ))
	$LevelFinish.rect_scale.x = 4 * popup_oran.x / 5
	$LevelFinish.rect_scale.y = 4 * popup_oran.x / 5
	$LevelFinish.set_global_position(Vector2(OS.window_size.x /2  , OS.window_size.y /2  ))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func set_total_star(star_count):
	$LevelFinish/TotalStar.set_text(str(star_count))


func set_finish_time(fin_timer):
	$LevelFinish/finish_time.set_text(str(fin_timer))
	pass
	
func sum_point(time, star):
	sum_count = time + star
	$MoneyCount.start()
	
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


func _on_MoneyCount_timeout():
	if sum_count == money_count:
		$MoneyCount.stop()
	$LevelFinish/money.set_text(str(money_count))
	money_count += 1
	pass # Replace with function body.
