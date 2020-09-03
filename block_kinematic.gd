extends KinematicBody2D
 
var move_star = Tween.new()
var scale_star = Tween.new()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var star_count_pos = Vector2(400, 0)
var star_last_pos = Vector2(0, 0)
# Called when the node enters the scene tree for the first time.
func _ready(): 
	add_child(move_star)
	add_child(scale_star)
	move_star.connect("tween_completed",self,"star_pos_edit")
	pass # Replace with function body.
func on_correct_word():
	if $block_button/CorrectSprite.visible:
		$block_button/CorrectSprite.play("correct")
		star_last_pos = $block_button/CorrectSprite.get_global_position()
		move_star.interpolate_property($block_button/CorrectSprite, "global_position", get_global_position(), star_count_pos, 1.0 ,Tween.TRANS_BACK,Tween.EASE_IN)
		move_star.start()

func star_pos_edit(key, pos):
	$block_button/CorrectSprite.set_global_position(star_last_pos)
	scale_star.interpolate_property($block_button/CorrectSprite, "scale", Vector2(0.01, 0.01), Vector2(0.7, 0.7), 1.0 ,Tween.TRANS_LINEAR)
	scale_star.start()
	
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
