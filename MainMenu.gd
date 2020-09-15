extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var bg_size = $Background.get_texture().get_size()  
	var bg_oran = OS.window_size / bg_size
	$Background.rect_size.x = bg_oran.x
	$Background.rect_size.y = bg_oran.y
	pass # Replace with function body.



#func _process(delta):
#	_ready()
#	pass

