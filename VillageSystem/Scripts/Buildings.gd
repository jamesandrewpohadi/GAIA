extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var buildingDeployed = false
var resource = 0
signal buildingIsDeployed 
func _ready():
	#Upon initialization, hide the building because it's already placed there
	self.hide()
	for child in self.get_children():
		for things in child.get_children():
			things.hide()
	# Called when the node is added to the scene for the first time.
	# Initialization here
	#pass

func _process(delta):
	pass
	
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_BuildingMenu_deploy_building():
	#When signal deploy_building is emitted by buildingmenu, i.e. building chosen , building appears on village
	self.show()
	for child in self.get_children():
		for things in child.get_children():
			things.show()  # replace with function body


func _on_Building_ProgBar_building_complete():
	buildingDeployed = true
	emit_signal("buildingIsDeployed")
