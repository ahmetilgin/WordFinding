extends TouchScreenButton

signal block_move(rot)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func is_raycast_collide_with_block(raycast):
	if !raycast.is_colliding():
		return true
	return false

func look_around():
	var result = Globals.rotations.none
	if is_raycast_collide_with_block(get_parent().get_node("DownCast")):
		result = Globals.rotations.down
	if is_raycast_collide_with_block(get_parent().get_node("UpCast")):
		result = Globals.rotations.up
	if is_raycast_collide_with_block(get_parent().get_node("LeftCast")):
		result = Globals.rotations.left
	if is_raycast_collide_with_block(get_parent().get_node("RightCast")):
		result = Globals.rotations.right
	return result
	
func _on_block_button_pressed():
	var look_around_result = look_around()
	var global_position = get_parent().get_global_position()
	if look_around_result != Globals.rotations.none:
		if look_around_result == Globals.rotations.up:
			get_parent().set_global_position(global_position + Vector2(0, - Globals.cell_size * Globals.divition_ratio))
			pass
		elif look_around_result == Globals.rotations.down:
			get_parent().set_global_position(global_position + Vector2(0, Globals.cell_size * Globals.divition_ratio))
			pass
		elif look_around_result == Globals.rotations.right:
			get_parent().set_global_position(global_position + Vector2(Globals.cell_size * Globals.divition_ratio,0))
			pass
		elif look_around_result == Globals.rotations.left:
			get_parent().set_global_position(global_position + Vector2(-Globals.cell_size * Globals.divition_ratio,0))
			pass
		emit_signal("block_move",look_around_result)
	pass # Replace with function body.


func _on_block_button_released():
	pass # Replace with function body.
