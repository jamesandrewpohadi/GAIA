extends TextureProgress

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
signal update_building_animation
signal building_complete
var check_number = 20
func _ready():
	self.value = self.min_value
	
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	#Checks if the building(or more technically, if the progress bar has appeared) has appeared, if it appeared, then increase progress bar.
	var increment = 10
	if self.visible == false:
		pass
	else:
		if self.value < self.max_value:
			self.value += delta * increment
			if self.value > check_number:
				emit_signal("update_building_animation")
				check_number += 20
			#Once bar is full, hide bar
		else:
			emit_signal("update_building_animation")
			emit_signal("building_complete")
			self.hide()
			
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
