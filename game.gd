extends Node2D
var block_scene = preload("res://Block.tscn")
var frame_scene = preload("res://Frame.tscn")
var background = preload("res://Background.tscn")
var block_list = []
func fill_frames(position):
	var frame = frame_scene.instance()
	add_child(frame)
	frame.set_z_index(-5)
	frame.set_scale(Vector2(Globals.divition_ratio,Globals.divition_ratio))
	frame.set_global_position(position)

func get_window_size():
	var oran = (OS.window_size / (Globals.map_size + 2)) 
	Globals.divition_ratio = oran.x / Globals.cell_size

func _ready():
	get_window_size()
	var current_cell_size = Globals.cell_size * Globals.divition_ratio
	for x in range(0,Globals.map_size):
		for y in range(0,Globals.map_size):	
			if x == 0 and y == 0:
				fill_frames(Vector2((x - 1) *current_cell_size + current_cell_size, (y - 1)* current_cell_size + current_cell_size ))
			if x == 0:
				fill_frames(Vector2((x - 1) *current_cell_size + current_cell_size, y* current_cell_size + current_cell_size))
			if x == Globals.map_size - 1:
				fill_frames(Vector2((x + 1) *current_cell_size + current_cell_size, y* current_cell_size + current_cell_size ))	
			if y == 0:
				fill_frames(Vector2(x *current_cell_size + current_cell_size, (y - 1)* current_cell_size + current_cell_size ))	
			if y == Globals.map_size - 1:		
				fill_frames(Vector2((x) *current_cell_size + current_cell_size, (y + 1)* current_cell_size + current_cell_size))	
			if y == Globals.map_size - 1 and x == Globals.map_size - 1:
				fill_frames(Vector2((x + 1) *current_cell_size + current_cell_size, (y + 1)* current_cell_size + current_cell_size))	
			if x == 0 and y == Globals.map_size - 1:
				fill_frames(Vector2((x - 1) *current_cell_size + current_cell_size, (y + 1)* current_cell_size + current_cell_size))	
			if x == Globals.map_size - 1 and y == 0:
				fill_frames(Vector2((x + 1) *current_cell_size + current_cell_size, (y - 1)* current_cell_size + current_cell_size))	

			var back = background.instance()
			add_child(back)
			back.set_z_index(-1)
			back.set_scale(Vector2(Globals.divition_ratio,Globals.divition_ratio))
			back.set_global_position(Vector2(x * current_cell_size + current_cell_size, y* current_cell_size + current_cell_size))
			if x == Globals.map_size - 1 and y == Globals.map_size - 1:
				continue
			var block = block_scene.instance()
			add_child(block)
			block.set_scale(Vector2(Globals.divition_ratio,Globals.divition_ratio))
			block.set_global_position(Vector2(x *current_cell_size + current_cell_size, y* current_cell_size + current_cell_size ))
			block_list.append(block)
	fill_words_to_blocks()
	pass # Replace with function body.


static func sum_array(array):
	var sum = 0.0
	for element in array:
		 sum += element
	return sum

func subset_sum(numbers, target, partial=[]):
	var s = sum_array(partial)

	# check if the partial sum is equals to target
	if s == target: 
		print (partial, target)
	if s >= target:
		return  # if we reach the number why bother to continue

	for i in range(len(numbers)):
		var n = numbers[i]
		var remaining = []
		for x in range(i+1,len(numbers),1):
			remaining.append(numbers[x])
		subset_sum(remaining, target, partial + [n]) 


func fill_words_to_blocks():
	subset_sum([1,3,54,6,2,7,8],9)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
