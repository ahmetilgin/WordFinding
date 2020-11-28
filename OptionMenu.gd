extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var textureoption_size = $TextureRect.get_texture().get_size()  
	var textureoption_oran = OS.window_size / textureoption_size
	$TextureRect.rect_scale.x = textureoption_oran.x
	$TextureRect.rect_scale.y = textureoption_oran.x
	$TextureRect.set_global_position(Vector2(0,(OS.window_size.y / 2) - (textureoption_size.y / 4)))
 

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Exit_pressed():
	get_tree().paused = not get_tree().paused
	$".".visible = false
	pass # Replace with function body.
