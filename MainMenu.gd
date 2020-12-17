extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if(Globals.is_tutorialed):
		get_node("tutorial")._on_okey_pressed()

	var topgui_size = $topgui.get_texture().get_size()  
	var bottomgui_size = $bottomgui.get_texture().get_size()  
	var topgui_oran = OS.window_size / topgui_size
	var bottomgui_oran = OS.window_size / bottomgui_size
	$BG.rect_size = OS.window_size
	$topgui.rect_scale.x = topgui_oran.x
	$topgui.rect_scale.y = topgui_oran.x
	$bottomgui.rect_scale.x = bottomgui_oran.x
	$bottomgui.rect_scale.y = bottomgui_oran.x
	$bottomgui.set_global_position(Vector2(0,OS.window_size.y - (bottomgui_size.y * bottomgui_oran.x)))
	$topgui.set_global_position(Vector2(0,0))
	on_pressed_music()
	$OptionCanvas/OptionMenu/TextureRect/Audio/Music.connect("pressed",self,"on_pressed_music")
	
	pass # Replace with function body.

func on_pressed_music():
	$GameMenuSound._set_playing(Globals.is_play_music)


#func _process(delta):
#	_ready()
#	pass



