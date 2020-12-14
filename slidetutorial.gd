extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = not get_tree().paused
	$background.rect_size = OS.window_size
	$background.set_global_position(Vector2(0, 0 ))
	var FramePanel = $FramePanel.get_texture().get_size()  
	var FramePanel_ratio = OS.window_size / FramePanel
	$FramePanel.scale.x = FramePanel_ratio.x
	$FramePanel.scale.y = FramePanel_ratio.x
	$FramePanel.set_global_position(Vector2(0  , OS.window_size.y /12 ))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_back_pressed():
	$FramePanel/SlideShow.frame -= 1
	_check_frame_count()
	pass # Replace with function body.


func _on_forward_pressed():
	$FramePanel/SlideShow.frame += 1
	_check_frame_count()
	pass # Replace with function body.


func _on_okey_pressed():
	get_tree().paused = not get_tree().paused
	self.hide()
	pass # Replace with function body.


func _check_frame_count():
	if $FramePanel/SlideShow.get_frame() == 11:
		$FramePanel/okey.set_disabled(false)
	pass # Replace with function body.
