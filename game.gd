extends Node2D
var block_scene = preload("res://Block.tscn")
var frame_scene = preload("res://Frame.tscn")
var background = preload("res://Background.tscn")
var block_list = []
var word_sum_list = []
var sum_word_list = []
var current_cell_size = 0
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
	current_cell_size = Globals.cell_size * Globals.divition_ratio
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
			block.get_node("block_button").connect("block_move",self,"block_moved")
	fill_words_to_blocks(current_cell_size)
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


func fill_words_to_blocks(current_cell_size):
	randomize()
	Globals.words.shuffle()
	var word_list_with_count = {}
	var word_list_count_list = []
	
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
		# problem yok reis
		$ItemList.add_item(word)
		for letter in word:
			total_letters.append(letter)
	total_letters.shuffle()
	
	for	block in block_list:
		block.set_label(total_letters.pop_back())
		
	$ItemList.set_size(Vector2(Globals.map_size * current_cell_size + 1, len(sum_word_list) * 20 ))
	$ItemList.set_global_position(Vector2(current_cell_size, (Globals.map_size + 1.4) *current_cell_size ))

	pass
	
func reverse(string):
	var rev = ""
	for i in range(len(string) - 1 ,-1, -1):
		rev +=string[i]
	return rev
	
func block_moved(pos):

	var i = 0
	var block_with_pos = {}
	var pos_with_block = {}
	var column_letters = {}
	
	
	for block in block_list:
		var curr_pos = block.get_global_position() / current_cell_size
		curr_pos = Vector2(round(curr_pos.x),round(curr_pos.y))
		block_with_pos[curr_pos] = block.get_label()
		pos_with_block[curr_pos] = block
	


	var row_list = []
	var col_list = []
	for x in range(1, Globals.map_size + 1):
		var row = ""
		var col = ""
		for y in range(1, Globals.map_size + 1):
			if !block_with_pos.has(Vector2(y,x)):
				block_with_pos[Vector2(y,x)] = "*"
			if !block_with_pos.has(Vector2(x,y)):
				block_with_pos[Vector2(x,y)] = "*"
			row +=   block_with_pos[Vector2(y,x)]
			col +=  block_with_pos[Vector2(x,y)]
		row_list.append(row)
		col_list.append(col)
	
	for word in sum_word_list:	
		var reverse_word = reverse(word)
		var col_count = 1
		for col_word in col_list:
			var result = col_word.find(word)
			if (result < 0):
				result = col_word.find(reverse_word)
			if (result > -1):
				for complete_word in range(1, len(word) + 1):
					pos_with_block[Vector2(col_count, result + complete_word)].set_label("#")
			col_count += 1
		
		var row_count = 1
		for row_word in row_list:
			var result = row_word.find(word)
			if (result < 0):
				result = row_word.find(reverse_word)
			if (result > -1):
				for complete_word in range(1, len(word) + 1):
					pos_with_block[Vector2(result + complete_word, row_count)].set_label("#")
					
			row_count += 1
	

#		if !column_letters.has(curr_pos.y):
#			column_letters[curr_pos.y] = " "
#
#		column_letters[curr_pos.y] += block.get_label()
#
#	print(column_letters)
#	print("-------------------")
#	for column in column_letters:
#		print(column_letters[column])
#	var empty_pos = Vector2(0,0)
#	print("-------------------")

	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
