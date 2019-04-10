extends Label

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


func _on_YggdrasilMenu_update_yggdrasil_status(yggdrasilStatus):
	if(yggdrasilStatus[0] < 0):
		self.text = str(0)
	else:
		self.text = str(yggdrasilStatus[0])
	
	self.update()
