extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func ready():
	GoogleService.connect("load_game",self,"loaded_game")
	



func loaded_game(data):	
	if(data.has("totalMoney")):
		set_text(str(data["totalMoney"]))
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
