extends RichTextLabel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
#Resource counter facing issues of reducing in value 
#Need to implement some form of real-time(Now using process speed)
func _process(delta):
	pass




func _on_ResourceMenu_foodResourceCount(resource):
	self.text = str(resource)
	self.update()
