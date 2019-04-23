extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var waterBuildingLevel 
var buildingDeployed = false
var contaminationPoint = 1 
var spaceTaken = 2 
var waterResourceGenerated = 1

signal buildingIsDeployed
signal resourceCount 
signal contaminationAdd
signal updateSpaceTaken
signal notify_max_level_achieved
signal deduct_resources_for_water_bldg
signal upgrade_water_building
var buildingDeploying
var timeCheck = 1
var timeStart
var timeSave = false
var isUpdated = false

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
	
	if waterBuildingLevel == 1:
		if isUpdated == false:
			level_one()
			isUpdated = true
	if waterBuildingLevel == 2:
		if isUpdated == false:
			level_two()
			isUpdated = true
			
	
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func level_one():
	print("water level one")
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
	self.get_node("LevelUpScheme/level2_waterimg").show()
	
	
func _on_Building_ProgBar_building_complete():
	buildingDeployed = true
	emit_signal("buildingIsDeployed")
	waterBuildingLevel += 1
	$BldgImg.visible = true
	$BldgImg.is_visible_in_tree()
	buildingDeploying = false



		
	
func resource_production():
	emit_signal("resourceCount", waterResourceGenerated)




func _on_BuildingMenu_deploy_building_water():
	#When signal deploy_building is emitted by buildingmenu, i.e. building chosen , building appears on village
	var current_ygg_level = get_node("../../").yggdrasilLevel
	
	if(waterBuildingLevel < current_ygg_level):
		if buildingDeploying == true:
			pass
		else:
			buildingDeploying = true
			emit_signal("deduct_resources_for_water_bldg")
			emit_signal("updateSpaceTaken",spaceTaken)
			emit_signal("contaminationAdd",contaminationPoint)
			if (waterBuildingLevel == 0):
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
	emit_signal("upgrade_water_building")


func _on_levelupbar_water_upgrade_water_bldg_complete():
	waterBuildingLevel +=1
	contaminationPoint = contaminationPoint * waterBuildingLevel
	waterResourceGenerated = waterResourceGenerated * waterBuildingLevel
	emit_signal("updateSpaceTaken",spaceTaken)
	emit_signal("contaminationAdd",contaminationPoint)
	buildingDeployed = false


func _on_VillageScreen_firebase_update_waterBldg(waterBldglvl):
	waterBuildingLevel = waterBldglvl
