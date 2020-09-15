extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var size = $Node.get_node("3x3").get_texture().get_size()  * 2 + Vector2(3,3)
	var bg_size = $Background.get_texture().get_size()  
	var oran = OS.window_size / size
	var bg_oran = OS.window_size / bg_size
	$Node.scale.x = oran.x
	$Node.scale.y = oran.x
	$Node.set_global_position(Vector2(0,OS.window_size.y/ 2 - size.y / 4 ))
	$Background.rect_size.x = bg_oran.x
	$Background.rect_size.y = bg_oran.y
	pass # Replace with function body.



#func _process(delta):
#	_ready()
#	pass

