extends TextureProgress

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var canRun = false
signal upgrade_water_bldg_complete
var increment = 10

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	self.hide()
	self.value = self.min_value

func _process(delta):
	if canRun == true:
		if (self.value<self.max_value):
			self.value += delta *increment
		else:
			emit_signal("upgrade_water_bldg_complete")
			canRun = false
			self.value = self.max_value
			self.hide()



func _on_WaterBuilding_upgrade_water_building():
	self.show()
	canRun = true
