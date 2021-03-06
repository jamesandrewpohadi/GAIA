extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var buildingDeployed = false
var foodResourceGenerated = 1
var contaminationPoint = 1 # add into the contamination system later
var spaceTaken = 2 # add space constraint later
var foodBuildingLevel = 0
var isUpdated = false
var buildingDeploying = false

signal contaminationAdd
signal resourceCount 
signal updateSpaceTaken
signal deduct_resources_for_food_bldg
signal upgrade_food_building
signal notify_max_level_achieved
signal buildingIsDeployed
signal updateVillageScreen

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
	
	if foodBuildingLevel == 1:
		if isUpdated == false:
			level_one()
			isUpdated = true
	if foodBuildingLevel == 2:
		if isUpdated == false:
			level_two()
			isUpdated = true
		
	
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func level_one():
	print("food level one")
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
	self.get_node("LevelUpScheme").show()
	self.get_node("LevelUpScheme/level2_foodimg").show()
	
func _on_Building_ProgBar_building_complete():
	buildingDeployed = true
	foodBuildingLevel = 1
	buildingDeploying = false
	
func resource_production():
	emit_signal("resourceCount", foodResourceGenerated)


func _on_BuildingMenu_deploy_building_food():
	#When signal deploy_building is emitted by buildingmenu, i.e. building chosen , building appears on village
	var current_ygg_level = get_node("../../").yggdrasilLevel
	
	if(foodBuildingLevel < current_ygg_level):
		if buildingDeploying == true:
			pass
		else:
			buildingDeploying = true
			emit_signal("deduct_resources_for_food_bldg")
			emit_signal("updateSpaceTaken",spaceTaken)
			emit_signal("contaminationAdd",contaminationPoint)
			if (foodBuildingLevel == 0):
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
	emit_signal("upgrade_food_building")

func _on_Levelupbar_food_upgrade_food_bldg_complete():
	foodBuildingLevel =2
	contaminationPoint = contaminationPoint * foodBuildingLevel
	foodResourceGenerated = foodResourceGenerated * foodBuildingLevel
	emit_signal("updateSpaceTaken",spaceTaken)
	emit_signal("contaminationAdd",contaminationPoint)
	buildingDeployed = false



func _on_VillageScreen_firebase_update_foodBldg(foodBldglvl):
	foodBuildingLevel = foodBldglvl
	


func _on_VillageScreen_update_village_screen():
	emit_signal("updateVillageScreen",foodBuildingLevel)
