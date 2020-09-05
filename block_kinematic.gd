extends KinematicBody2D
 
var move_star = Tween.new()
var scale_star = Tween.new()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var star_count_pos = Vector2(400, 0)
# Called when the node enters the scene tree for the first time.
func _ready(): 
	add_child(move_star)
	add_child(scale_star)
	move_star.connect("tween_completed",self,"star_pos_edit")
	scale_star.connect("tween_started",self,"on_tween_started")
	pass # Replace with function body.
func on_correct_word():
	if $block_button/CorrectSprite.visible:
		$block_button/CorrectSprite.play("correct")
		move_star.interpolate_property($block_button/CorrectSprite, "global_position", $block_button/CorrectSprite.get_global_position(), star_count_pos, 1.0 ,Tween.TRANS_BACK,Tween.EASE_IN)
		move_star.start()

func on_tween_started(key, pos):
	$block_button/CorrectSprite.set_visible(true)
func star_pos_edit(key, pos):
	$block_button/CorrectSprite.set_visible(false)
	$block_button/CorrectSprite.set_global_position($BlockCollision.get_global_position())
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
