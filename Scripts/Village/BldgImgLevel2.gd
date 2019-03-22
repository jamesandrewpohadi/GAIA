extends TileMap

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var appear = false
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	self.hide()
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	if(appear):
		self.show()
	else:
		self.hide()
		



func _on_LevelUpUI_upgrade_complete():
	var appear = true
