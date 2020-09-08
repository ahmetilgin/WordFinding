extends TouchScreenButton

signal block_move()
signal all_block_move(pos)
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
		get_tree().get_root().set_disable_input(true)			
		if look_around_result == Globals.rotations.up:
			get_parent().set_global_position(global_position + Vector2(0, - Globals.cell_size * Globals.divition_ratio))
		elif look_around_result == Globals.rotations.down:
			get_parent().set_global_position(global_position + Vector2(0, Globals.cell_size * Globals.divition_ratio))
		elif look_around_result == Globals.rotations.right:
			get_parent().set_global_position(global_position + Vector2(Globals.cell_size * Globals.divition_ratio,0))
		elif look_around_result == Globals.rotations.left:
			get_parent().set_global_position(global_position + Vector2(-Globals.cell_size * Globals.divition_ratio,0))
		get_parent().get_node("MoveSound").play()
		yield(get_tree().create_timer(0.05), "timeout")
		get_tree().get_root().set_disable_input(false)
		emit_signal("block_move")
	else:
		if !get_tree().get_root().is_input_disabled():
			emit_signal("all_block_move",global_position)
	





