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
signal updateVillageScreen

var timeCheck = 1
var timeStart
var timeSave = false
var isUpdated = false
var buildingDeploying = false

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
	if academyBuildingLevel == 1:
		if isUpdated == false:
			level_one()
			isUpdated = true
	if academyBuildingLevel == 2:
		if isUpdated == false:
			level_two()
			isUpdated = true
			
func level_one():
	buildingDeployed = true
	emit_signal("buildingIsDeployed")
	self.show()
	$BldgImg.visible = true
	$Building_UI.visible = true
	$Building_UI/Building_Name.visible = true
	
func level_two():
	buildingDeployed = true
	emit_signal("buildingIsDeployed")
	self.show()
	$BldgImg.visible = true
	$Building_UI/Building_Name.visible = true
	self.get_node("LevelupScheme").show()
	self.get_node("LevelupScheme/level2_academyimg").show()

func _on_Building_ProgBar_building_complete():
	buildingDeployed = true
	academyBuildingLevel = 1
	emit_signal("buildingIsDeployed")
	emit_signal("updateVillagerStatus",upVillagerLevel)
	buildingDeployed = false


func _on_BuildingMenu_deploy_building_academy():
	#When signal deploy_building is emitted by buildingmenu, i.e. building chosen , building appears on village
	var current_ygg_level = get_node("../../").yggdrasilLevel
	
	if(academyBuildingLevel < current_ygg_level):
		if buildingDeploying == true:
			pass
		else:
			buildingDeploying = true
			emit_signal("deduct_resources_for_academy_bldg")
			emit_signal("updateSpaceTaken",spaceTaken)
			emit_signal("contaminationAdd",contaminationPoint)
			if (academyBuildingLevel == 0):
				self.show()	
				var checklevelupgradegraphics = self.get_child(2)
				for child in self.get_children():
					if child == checklevelupgradegraphics:
						pass
					else:				
						for things in child.get_children():
							things.show()  
			else:
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
	buildingDeploying = false


func _on_VillageScreen_firebase_update_acadBldg(acadBldglvl):
	academyBuildingLevel = acadBldglvl


func _on_VillageScreen_update_village_screen():
	emit_signal("updateVillageScreen",academyBuildingLevel)
