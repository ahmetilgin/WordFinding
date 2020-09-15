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
		

func _go_given_rotation(rot):	
	if !Globals.game_finish:	
		if rot == Globals.rotations.up:
			get_parent().set_global_position(global_position + Vector2(0, - Globals.cell_size * Globals.divition_ratio))
		elif rot == Globals.rotations.down:
			get_parent().set_global_position(global_position + Vector2(0, Globals.cell_size * Globals.divition_ratio))
		elif rot == Globals.rotations.right:
			get_parent().set_global_position(global_position + Vector2(Globals.cell_size * Globals.divition_ratio,0))
		elif rot == Globals.rotations.left:
			get_parent().set_global_position(global_position + Vector2(-Globals.cell_size * Globals.divition_ratio,0))
func move_around():
	if !Globals.game_finish:
		var look_around_result = look_around()
		var global_position = get_parent().get_global_position()
		if !Globals.is_all_moving:
			if look_around_result != Globals.rotations.none:	
				_go_given_rotation(look_around_result)
				get_parent().get_node("MoveSound").play()
				emit_signal("block_move")
			else:
				emit_signal("all_block_move",global_position)





func _on_block_button_pressed():
	move_around()
	pass # Replace with function body.
