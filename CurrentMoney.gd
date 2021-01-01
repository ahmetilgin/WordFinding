extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func load_money():
	var date = OS.get_date()
	var time_return = String(date.year) +":"+String(date.month)+":"+String(date.day)
	var save_money = File.new()

	if not save_money.file_exists("user://save_money.save"):
		return # Error! We don't have a save to load.
	
	var current_money = 0
	save_money.open("user://save_money.save", File.READ)
	while save_money.get_position() < save_money.get_len():
		# Get the saved dictionary from the next line in the save file
		var node_data = parse_json(save_money.get_line())
		if(node_data == null):
			save_money.close();
			return 
		
		var saved_date = ""
		if(node_data.has("date")):
			saved_date = node_data["date"]
			if saved_date != time_return:
				current_money = 0
				set_text(str(current_money))
				save_money.close();
				return
		else:
			current_money = 0
			set_text(str(current_money))
			save_money.close();
			return
		if node_data.has("totalMoney"):
			current_money = int(node_data["totalMoney"])
		else:
			current_money = 0
		
	set_text(str(current_money))
	save_money.close();
	pass
# Called when the node enters the scene tree for the first time.
func _ready():
	load_money()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
