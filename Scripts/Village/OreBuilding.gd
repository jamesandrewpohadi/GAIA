extends Sprite


# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var buildingDeployed = false
var oreResourceGenerated = 1
var contaminationPoint = 1 # add into the contamination system later
var spaceTaken = 2 # add space constraint later

signal buildingIsDeployed
signal resourceCount 
signal contaminationAdd
signal updateSpaceTaken

var timeCheck = 1
var timeStart
var timeSave = false

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
	#Generates resource per the stipulated time
	if buildingDeployed == true:
		if timeSave == false:
			timeStart = OS.get_system_time_secs()
			timeSave = true
				#resource_production()
				#timeSave == false
		if ((OS.get_system_time_secs() - timeStart) == timeCheck):
			resource_production();
			timeSave = false
	
		
	
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Building_ProgBar_building_complete():
	buildingDeployed = true
	emit_signal("buildingIsDeployed")
	emit_signal("updateSpaceTaken",spaceTaken)
	
func resource_production():
	emit_signal("contaminationAdd",contaminationPoint)
	emit_signal("resourceCount", oreResourceGenerated)



func _on_BuildingMenu_deploy_building_ore():
		#When signal deploy_building is emitted by buildingmenu, i.e. building chosen , building appears on village
	self.show()
	for child in self.get_children():
		for things in child.get_children():
			things.show()  # replace with function bodypass # replace with function body
