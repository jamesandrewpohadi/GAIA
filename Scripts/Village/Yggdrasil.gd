extends Sprite


func _ready():
	self.hide()
	for child in self.get_children():
		self.hide()
	
	
	

	

	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_Build_Touch_pressed():
	self.show() # replace with function body
	for child in self.get_children():
		self.show()

