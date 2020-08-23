extends Node2D
var block_scene = preload("res://Block.tscn")
var frame_scene = preload("res://Frame.tscn")
var background = preload("res://Background.tscn")
var block_list = []
var word_sum_list = []
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
		partial.sort()
		if len(word_sum_list) > 5:
			return
		word_sum_list.push_back(partial)
	if s >= target:
		return  # if we reach the number why bother to continue

	for i in range(len(numbers)):
		var n = numbers[i]
		var remaining = []
		for x in range(i+1,len(numbers),1):
			remaining.append(numbers[x])
		subset_sum(remaining, target, partial + [n]) 


func fill_words_to_blocks():
	randomize()
	Globals.words.shuffle()
	var word_list_with_count = {}
	var word_list_count_list = []
	var sum_word_list = []
	for	i in range(0,len(Globals.words)):
		if(len(Globals.words[i]) <=  Globals.map_size):
			var letter_count = len(Globals.words[i])
			if !word_list_with_count.has(letter_count):
				word_list_with_count[letter_count] = []
			word_list_count_list.push_back(letter_count)
			word_list_with_count[letter_count].push_back(Globals.words[i])
			
	subset_sum(word_list_count_list,Globals.map_size * Globals.map_size - 1)
	if len(word_sum_list) >0 :
		var sum_of_list_member = word_sum_list[randi() % len(word_sum_list)]
		for word_len in range(0, len(sum_of_list_member)):
			sum_word_list.append(word_list_with_count[sum_of_list_member[word_len]].pop_back())
#			word_list_count_list.remove()
	var total_letters = []
	for word in sum_word_list:
		var checkbox = CheckBox.new() ;
		$ItemList.add_item(word,checkbox)
		for letter in word:
			total_letters.append(letter)
	total_letters.shuffle()
	
	for	block in block_list:
		block.set_label(total_letters.pop_back())
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
