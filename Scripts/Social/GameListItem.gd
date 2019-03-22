extends ColorRect

var dict_func

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func sell():
	hide()
	
func buy():
	hide()

func _on_Button_pressed():
	dict_func.my_func.call_func()
