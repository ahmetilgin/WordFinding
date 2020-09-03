extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready(): 
	pass # Replace with function body.
func on_correct_word():
	if $block_button/CorrectSprite.visible:
		$block_button/CorrectSprite.play("correct")
func set_label(text):
	$block_button/Label.set_text(text)
	
func get_label():
	return $block_button/Label.get_text()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_CorrectSprite_animation_finished():
	if $block_button/CorrectSprite.get_animation() == "correct":
		$block_button/CorrectSprite.play("default")
	pass # Replace with function body.
