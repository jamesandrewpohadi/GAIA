extends Container
var dungeonMenu
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	dungeonMenu = get_node("DungeonMenu")
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_DungeonButton_pressed():
	dungeonMenu.show()
	pass # replace with function body


func _on_CloseButton_pressed():
	dungeonMenu.hide()
	pass # replace with function body


func _on_SoloButton_pressed():
	get_tree().change_scene('res://StageOne.tscn')
	pass # replace with function body




func _on_Exit_pressed():
	get_tree().change_scene('res://Village.tscn')
	pass # replace with function body


