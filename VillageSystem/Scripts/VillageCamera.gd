extends Camera2D


func _ready():  
    pass

func _input(event):
	if event is InputEventMouseMotion:
		pass
	if event is InputEventScreenDrag: #update on camera. Position moves but not the view....
		position.x -= event.relative.x
		position.y -= event.relative.y
		self.make_current()
