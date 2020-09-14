extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var size = $Node.get_node("3x3").get_texture().get_size()  * 2 + Vector2(3,3)
	var oran = OS.window_size / size
	$Node.scale.x = oran.x
	$Node.scale.y = oran.x
	$Node.set_global_position(Vector2(0,OS.window_size.y/ 2 - size.y / 4 ))
	pass # Replace with function body.



#func _process(delta):
#	_ready()
#	pass

