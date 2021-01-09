extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var money_count = 0
var sum_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	admob_load_interstitial()
	var popup_size = $LevelFinish/TextureRect.get_texture().get_size()  
	var popup_oran = OS.window_size / popup_size
	$ColorRect/ColorRect.rect_size = OS.window_size
	$ColorRect.set_global_position(Vector2(0, 0 ))
	$LevelFinish.rect_scale.x = 4 * popup_oran.x / 5
	$LevelFinish.rect_scale.y = 4 * popup_oran.x / 5
	$LevelFinish.set_global_position(Vector2(OS.window_size.x /2  , OS.window_size.y /2  ))
	pass # Replace with function body.

func admob_load_interstitial():
	get_parent().get_node("AdMob").load_interstitial()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func set_total_star(star_count):
	$LevelFinish/TotalStar.set_text(str(star_count))


func set_finish_time(fin_timer):
	$LevelFinish/finish_time.set_text(str(fin_timer))
	pass
	
func sum_point(time, star):
	sum_count = time + star
	$MoneyCount.start()
	
func _on_Restart_pressed():
	admob_show_interstitial()
	get_tree().reload_current_scene()
	pass # Replace with function body.


func _on_LevelSelect_pressed():
	admob_show_interstitial()
	$LevelFinish.hide()
	$Node.set_visible(true)
	pass # Replace with function body.


func _on_LevelSelect_released():
	pass # Replace with function body.


func _on_MainMenu_released():
	pass # Replace with function body.


func _on_MoneyCount_timeout():
	if sum_count == money_count:
		$MoneyCount.stop()
		save_and_increase_current_money()
	$LevelFinish/money.set_text(str(money_count))
	money_count += 1
	pass # Replace with function body.

func get_saved_data():
	var save_money = File.new()
	var saved_money = {}
	if not save_money.file_exists("user://save_money.save"):
		return saved_money# Error! We don't have a save to load.
	
	
	save_money.open("user://save_money.save", File.READ)
		# Get the saved dictionary from the next line in the save file
	var node_data = parse_json(save_money.get_as_text())
	if(node_data == null):
		save_money.close();
		return saved_money
	save_money.close();
	return node_data;
	pass

func save_and_increase_current_money():
	var date = OS.get_date()
	var time_return = String(date.year) +":"+String(date.month)+":"+String(date.day)
	var save_game = File.new()
	var saved_data = get_saved_data()
	var daily_money = 0
	
	if(saved_data.has("money")):
		 daily_money = int(saved_data["money"])
	var totalMoney = 0
	if(saved_data.has("totalMoney")):
		totalMoney = int(saved_data["totalMoney"])
	var saved_date = ""
	if(saved_data.has("date")):
		saved_date = saved_data["date"]
	else:
		saved_date = time_return
	save_game.open("user://save_money.save", File.WRITE)
	
	if time_return == saved_date:
		daily_money += money_count
	else:
		daily_money = money_count
		totalMoney = money_count
		
	var money_json = {
		"money" : daily_money,
		"date" : time_return,
		"totalMoney": totalMoney + money_count
	}
	save_game.store_line(to_json(money_json))
	save_game.close()
	GoogleService.submit_score(daily_money)
	
		
func _on_MainMenu_pressed():
	admob_show_interstitial()
	get_tree().change_scene("res://MainMenu.tscn")
	pass # Replace with function body.
	
func admob_show_interstitial():
	if Globals.advertise_wait_count == int(rand_range(1, 3)):
		get_parent().get_node("AdMob").show_interstitial()
		Globals.advertise_wait_count = 0
	Globals.advertise_wait_count += 1
