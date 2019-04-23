extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var buildingDeployed = false
var upVillagerLevel = 1
var contaminationPoint = 2 # add into the contamination system later
var spaceTaken = 2 # add space constraint later
var academyBuildingLevel = 0

signal updateVillagerStatus
signal buildingIsDeployed
signal contaminationAdd
signal updateSpaceTaken
signal deduct_resources_for_academy_bldg
signal notify_max_level_achieved
signal upgrade_academy_building

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
	pass



func _on_Building_ProgBar_building_complete():
	buildingDeployed = true
	academyBuildingLevel = 1
	emit_signal("buildingIsDeployed")
	emit_signal("updateVillagerStatus",upVillagerLevel)
	emit_signal("updateSpaceTaken",spaceTaken)
	emit_signal("contaminationAdd",contaminationPoint)


func _on_BuildingMenu_deploy_building_academy():
	#When signal deploy_building is emitted by buildingmenu, i.e. building chosen , building appears on village
	var current_ygg_level = get_node("../../").yggdrasilLevel
	
	if(academyBuildingLevel < current_ygg_level):
		if(academyBuildingLevel == 0):
			emit_signal("deduct_resources_for_academy_bldg")
			self.show()	
			var checklevelupgradegraphics = self.get_child(2)
			for child in self.get_children():
				if child == checklevelupgradegraphics:
					pass
				else:				
					for things in child.get_children():
						things.show()  # replace with function bodypass # replace with function body
		else:
			emit_signal("deduct_resources_for_academy_bldg")
			upgrade()

	else:
		emit_signal("notify_max_level_achieved") 


func upgrade():
	emit_signal("upgrade_academy_building")


func _on_Levelupbar_academy_upgrade_academy_bldg_complete():
	academyBuildingLevel +=1
	contaminationPoint = contaminationPoint * academyBuildingLevel
	emit_signal("updateVillagerStatus",upVillagerLevel)
	emit_signal("updateSpaceTaken",spaceTaken)
	emit_signal("contaminationAdd",contaminationPoint)


func _on_VillageScreen_firebase_update_acadBldg(acadBldglvl):
	academyBuildingLevel = acadBldglvl
