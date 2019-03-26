extends TextureProgress

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var canRun = false
var increment = 10

signal progbar_upgrade_complete

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	self.value = self.min_value
	self.hide()

func _process(delta):
	if canRun == true:
		if (self.value<self.max_value):
			self.value += delta *increment
		else:
			canRun = false
			self.value = self.max_value
			self.hide()
			emit_signal("progbar_upgrade_complete")


func _on_LevelUpUI_run_upgrade_building():
	canRun = true
	self.show()
