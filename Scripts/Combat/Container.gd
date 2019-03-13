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
	dungeonMenu.hide()
	hide()
	queue_free()
	var stageOne = load('res://Scenes/Social/StageOne.tscn').instance()
	get_parent().add_child(stageOne)




func _on_Exit_pressed():
	hide()
	queue_free()


