extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TouchScreenButton_pressed():
	pass # Replace with function body.


func _on_3x3_released():
	Globals.map_size = 3
	get_tree().change_scene("res://game.tscn")
	pass # Replace with function body.

func _on_4x4_released():
	Globals.map_size = 4
	get_tree().change_scene("res://game.tscn")
	pass # Replace with function body.


func _on_5v5_released():
	Globals.map_size = 5
	get_tree().change_scene("res://game.tscn")
	pass # Replace with function body.


func _on_6x6_released():
	Globals.map_size = 6
	get_tree().change_scene("res://game.tscn")
	pass # Replace with function body.


