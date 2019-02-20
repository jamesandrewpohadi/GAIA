extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var isResourceCollecting = false
var counter = 0 
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
#Resource counter facing issues of reducing in value 
#Need to implement some form of real-time(Now using process speed)
func _process(delta):
	if isResourceCollecting == true:
		counter += 0.01
		self.text = str(int(counter))		

#Upon spend button, value deducts from 
func _on_ResourceMenu_minus_resources(minus_resources):
	counter -= minus_resources
	self.text = str(int(counter))
	self.update()


func _on_ResourceMenu_activate_resource_counter():
	isResourceCollecting = true
