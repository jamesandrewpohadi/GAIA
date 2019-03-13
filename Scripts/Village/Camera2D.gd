extends Camera2D


func _ready():
	pass


func _on_SwipeDetector_swiped(direction):
	print("swiping"," direction: ",direction)
	moveCamera(direction)
	
func moveCamera(direction):
	self.position = Vector2(direction)
	print(self.get_camera_position()) #Can't move camera
	self.update()