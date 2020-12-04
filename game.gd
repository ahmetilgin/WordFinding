extends Node2D
var block_scene = preload("res://Block.tscn")
var frame_scene = preload("res://Frame.tscn")
var background = preload("res://Background.tscn")
var block_list = []
var word_sum_list = []
var sum_word_list = []
var current_cell_size = 0
var current_empty_position = Vector2()
var pos_with_block = {}
var score = 0
var time = 0
var founded_words = []
var total_words 
var border_width = Vector2(5, 5)
signal correct_word
func fill_frames(position):
	var frame = frame_scene.instance()
	add_child(frame)
	frame.set_z_index(-5)
	frame.set_scale(Vector2(Globals.divition_ratio,Globals.divition_ratio))
	frame.set_global_position(position)

func get_window_size():
	var oran = (OS.window_size / (Globals.map_size + 2)) 
	Globals.divition_ratio = oran.x / Globals.cell_size
	$Camera2D.set_global_position($Camera2D.get_global_position() - Vector2(0,OS.window_size.y / 5))
	time =round( Globals.map_size * Globals.map_size * Globals.map_size * 1.4)
	
		

func reset_words():
	for child in get_children():
		if "block" in child.get_name() or "back" in child.get_name():
			child.queue_free()
	sum_word_list.clear()
	block_list.clear()
	word_sum_list.clear()
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
			back.set_z_index(0)
			back.set_name("back")
			back.set_scale(Vector2(Globals.divition_ratio,Globals.divition_ratio))
			back.set_global_position(Vector2(x * current_cell_size + current_cell_size, y* current_cell_size + current_cell_size))
			if x == Globals.map_size - 1 and y == Globals.map_size - 1:
				current_empty_position = Vector2(x+1,y+1)
				continue
			var block = block_scene.instance()
			add_child(block)
			block.set_scale(Vector2(Globals.divition_ratio,Globals.divition_ratio))
			block.set_name("block")
			block.connect("increase_score",self,"on_increase_score")
			block.set_global_position(Vector2(x *current_cell_size + current_cell_size, y* current_cell_size + current_cell_size ))
			block_list.append(block)
			block.get_node("block_button").connect("block_move",self,"check_available_found_word")
			block.get_node("block_button").connect("all_block_move",self,"all_block_move_request")
			var curr_pos = block.get_global_position() / current_cell_size
			curr_pos = Vector2(round(curr_pos.x),round(curr_pos.y))
			pos_with_block[curr_pos] = block
	fill_words_to_blocks(current_cell_size)
	check_available_found_word()
	pass

func _ready():

	get_window_size()
	var score_texture_size = $ScoreTexture.get_texture().get_size()
	var score_texture_orani = OS.window_size / score_texture_size
	$ScoreTexture.set_global_position($Camera2D.get_global_position())
	$ScoreTexture.scale.x =  score_texture_orani.x
	$ScoreTexture.scale.y =  score_texture_orani.x
	Globals.game_finish = false
	reset_words()
	$Panel.set_global_position(Vector2(current_cell_size, current_cell_size) - border_width)
	$Panel.set_size(border_width * 2 + Vector2(current_cell_size,current_cell_size) * Globals.map_size)
	var button_texture_size = $ButtonTexture.get_texture().get_size()
	var button_texture_orani = OS.window_size / score_texture_size
	$ButtonTexture.set_global_position(Vector2(0,$Camera2D.get_global_position().y + OS.window_size.y - (button_texture_size.y * button_texture_orani.x)))
	$ButtonTexture.scale.x = button_texture_orani.x
	$ButtonTexture.scale.y = button_texture_orani.x
	on_pressed_music()
	$OptionCanvas/OptionMenu/TextureRect/Audio/Music.connect("pressed",self,"on_pressed_music")
	
	pass # Replace with function body.

func on_pressed_music():
	if(Globals.is_play_music):
		$GamePlaySound._set_playing(true)
	else:
		$GamePlaySound._set_playing(false)
	pass
#	$ButtonTexture.scale *= screen_size_calibration.x

	#$ScoreTexture.set_scale($ScoreTexture.get_scale() * (normal_window_size.x / normal_window_size.y) * (Globals.divition_ratio))
	
	

	pass # Replace with function body.

func sum_array(array):
	var sum = 0.0
	for element in array:
		 sum += element
	return sum

func subset_sum(numbers, target, partial=[]):
	var s = sum_array(partial)
	# check if the partial sum is equals to target

	if len(word_sum_list) > 5:
		return
	if s == target:
		partial.sort()

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
	$ItemList.clear()
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
	total_words = [] + sum_word_list
	for word in sum_word_list:
		# problem yok reis
		add_item_to_list(word)
		for letter in word:
			total_letters.append(letter)
	total_letters.shuffle()
	
	for	block in block_list:
		block.set_label(total_letters.pop_back())
	
	$ItemList.set_size(Vector2(Globals.map_size * current_cell_size + 1, $ItemList.get_size().y))
	$ItemList.set_global_position(Vector2(current_cell_size, (Globals.map_size + 1.4) *current_cell_size ))
	pass
	
func reverse(string):
	var rev = ""
	for i in range(len(string) - 1 ,-1, -1):
		rev +=string[i]
	return rev
	
func update_pos_with_block():
	pos_with_block = {}
	var block_with_pos = {}
	for block in block_list:
		var curr_pos = block.get_global_position() / current_cell_size
		curr_pos = Vector2(round(curr_pos.x),round(curr_pos.y))
		block_with_pos[curr_pos] = block.get_label()
		pos_with_block[curr_pos] = block
	
	return [block_with_pos,update_current_empty_pos(block_with_pos)]
	
func update_current_empty_pos(block_with_pos):
	var row_list = []
	var col_list = []
	for x in range(1, Globals.map_size + 1):
		var row = ""
		var col = ""
		for y in range(1, Globals.map_size + 1):
			if !block_with_pos.has(Vector2(y,x)):
				current_empty_position = Vector2(y,x)
				block_with_pos[Vector2(y,x)] = "*"
			if !block_with_pos.has(Vector2(x,y)):
				current_empty_position = Vector2(x,y)
				block_with_pos[Vector2(x,y)] = "*"
			row +=  block_with_pos[Vector2(y,x)]
			col +=  block_with_pos[Vector2(x,y)]
		row_list.append(row)
		col_list.append(col)
	return [row_list, col_list]
func check_available_found_word():
	var i = 0
	var res = update_pos_with_block()
	var block_with_pos = res[0]
	
	var column_letters = {}

	var row_list = res[1][0]
	var col_list = res[1][1]

	var rev_sum_word_list = [] #büyükten küçüğe sıralanan sum_word_list
	for rev_word in sum_word_list:
		rev_sum_word_list.push_front(rev_word)

	var is_word_found = false
	for word in rev_sum_word_list:
		var reverse_word = reverse(word)
		var col_count = 1
		var row_count = 1
		if not word in founded_words:
			for col_word in col_list:
				var result = col_word.find(word)
				if (result < 0):
					result = col_word.find(reverse_word)
				if (result > -1):
					if(Globals.is_play_sfx):
						$FoundWordSound.play()
					for complete_word in range(1, len(word) + 1):
						correcting_word(col_count,result + complete_word)
						set_checked_word(word)
					is_word_found = true
#					print("Founded_word:",word)
#					print("Col List:",col_list)
					sum_word_list.erase(word)
					founded_words.append(word)
					break
				col_count += 1
			if is_word_found:
				break
			for row_word in row_list:
				var result = row_word.find(word)
				if (result < 0):
					result = row_word.find(reverse_word)
				if (result > -1):
					if(Globals.is_play_sfx):
						$FoundWordSound.play()
					for complete_word in range(1, len(word) + 1):
						correcting_word(result + complete_word,row_count)
						set_checked_word(word)
					is_word_found = true
					sum_word_list.erase(word)
					founded_words.append(word)
#					print("Founded_word:",word)
#					print("Row List:",row_list)
					break
				row_count += 1
			if is_word_found:
				break
			
	if	is_word_found:
		check_available_found_word()
			

func correcting_word(start_point,count):
	pos_with_block[Vector2(start_point, count)].set_label("#")
	pos_with_block[Vector2(start_point, count)].set_button_text_visible(false)
	pos_with_block[Vector2(start_point, count)].get_node("block_button").get_node("CorrectSprite").set_visible(true)
	pos_with_block[Vector2(start_point, count)].on_correct_word()
	pass
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
func set_checked_word(word):

	for index in range(0,$ItemList.get_item_count()):
		if($ItemList.get_item_text(index)  == word):
			var item_list_icon = ImageTexture.new()
			var img = load("res://assets/checkbox_checked.png")
			var image_texture = img.get_data()
			image_texture.lock()
			item_list_icon.create_from_image(image_texture)
			$ItemList.set_item_icon(index,item_list_icon)
			$ItemList.set_item_custom_fg_color(index,Color(0,1,0,1))
			image_texture.unlock()
		
			

	pass
func add_item_to_list(word):
	var item_list_icon = ImageTexture.new()
	var img = load("res://assets/checkbox_unchecked.png")
	var image_texture = img.get_data()
	image_texture.lock()
	item_list_icon.create_from_image(image_texture)
	$ItemList.add_item(word, item_list_icon, false)
	$ItemList.set_item_custom_fg_color($ItemList.get_item_count() - 1, Color(0.01,0,0,1))
	image_texture.unlock()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# todo yoksa basma
func all_block_move_request(pos):
	if(!Globals.is_all_moving):
		Globals.is_all_moving = true
		var current_clicked_block = pos / current_cell_size
		current_clicked_block = Vector2(round(current_clicked_block.x),round (current_clicked_block.y))
		var same_line_list = []
		if current_empty_position.x == current_clicked_block.x:
			
			# aşağı kaydırma komple
			if current_clicked_block.y < current_empty_position.y:	
				for shift in range(current_empty_position.y - 1, current_clicked_block.y -1, -1):
					pos_with_block[Vector2(current_clicked_block.x,shift)].get_node("block_button")._go_given_rotation(Globals.rotations.down)
					yield(get_tree().create_timer(0.01), "timeout")
			# yukarı kaydırma komple
			if current_clicked_block.y > current_empty_position.y:
				for shift in range(current_empty_position.y + 1,current_clicked_block.y + 1):
					pos_with_block[Vector2(current_clicked_block.x,shift)].get_node("block_button")._go_given_rotation(Globals.rotations.up)
					yield(get_tree().create_timer(0.01), "timeout")
				
		elif current_empty_position.y == current_clicked_block.y:	
			# sağa kaydırma
			if current_clicked_block.x < current_empty_position.x:
				for shift in range(current_empty_position.x - 1, current_clicked_block.x -1, -1):
					pos_with_block[Vector2(shift,current_clicked_block.y)].get_node("block_button")._go_given_rotation(Globals.rotations.right)
					yield(get_tree().create_timer(0.01), "timeout")
			# sola kaydırma
			if current_clicked_block.x > current_empty_position.x:
				for shift in range(current_empty_position.x + 1,current_clicked_block.x + 1):
					pos_with_block[Vector2(shift,current_clicked_block.y)].get_node("block_button")._go_given_rotation(Globals.rotations.left)
					yield(get_tree().create_timer(0.01), "timeout")
		if(Globals.is_play_sfx):
			$AllMoveSound.play()
		check_available_found_word()
		Globals.is_all_moving = false
		update_pos_with_block()

	pass
func on_increase_score():
	score = score + 1
	$ScoreTexture/Score.set_text(str(score))
	if len(founded_words) == len(total_words):
		level_finished()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	reset_words()
#	pass
func level_finished():
	$GamePlaySound.stop()
	if(Globals.is_play_sfx):
		$GameFinishSound.play()
	$Control/LevelFinish.popup()
	$Control/ColorRect.set_visible(true)
	$Control.sum_point(score,time)
	$Control.set_total_star(score)
	$Control.set_finish_time(time)
	Globals.game_finish = true
	$ScoreTexture/CountTimer.stop()

	
func _on_CountTimer_timeout():
	if( time > 0):
		time = time - 1
	$ScoreTexture/Timer.set_text(str(time))
	if( time == 0):
		level_finished()
		pass
#		$GamePlaySound.stop()
#		$GameFinishSound.play()
#		$Control/LevelFinish.popup()
#		$Control/ColorRect.set_visible(true)
#		$Control.set_total_star(score)
#		Globals.game_finish = true
	pass # Replace with function body.


func _on_ExitButton_pressed():
	get_parent().get_tree().quit()
	pass # Replace with function body.


func _on_SettingButton_pressed():
	get_tree().paused = not get_tree().paused
	$OptionCanvas/OptionMenu.visible = true
	pass # Replace with function body.
