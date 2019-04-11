extends Panel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_MobBoss1_on_boss_dead():
	for i in get_parent().get_parent().get_children():
		if "Player" in i.name:
			i.get_node("UI/AreaAnalogLeft/AnalogLeft").set_process_input(false)
	show()
	pass # replace with function body
