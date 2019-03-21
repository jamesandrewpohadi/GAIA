extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var buildingDeployed = false
var contaminationPoint = -6 # add into the contamination system later
var spaceTaken = 2 # add space constraint later

signal buildingIsDeployed
signal repelContamination
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
			contamination_reduction()
			timeSave = false
	
		
	
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Building_ProgBar_building_complete():
	buildingDeployed = true
	emit_signal("buildingIsDeployed")
	emit_signal("updateSpaceTaken",spaceTaken)
	
func contamination_reduction():
	emit_signal("repelContamination",contaminationPoint) 

func _on_BuildingMenu_deploy_building_tree():
	self.show()
	for child in self.get_children():
		for things in child.get_children():
			things.show()  # replace with function bodypass # replace with function body
