extends "res://Scripts/Social/ListItem.gd"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass


func _on_Button_pressed():
	main.chat.show()
	main.Panel2.show()
	
	
