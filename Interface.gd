extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var size = get_node("ExitButton").get_texture().get_size()  * 3  
	var oran = OS.window_size / size
	scale.x = oran.x
	scale.y = oran.x
	set_global_position(Vector2(OS.window_size.x / 2  - size.x / 1.6 , OS.window_size.y - size.y / 3.75))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
