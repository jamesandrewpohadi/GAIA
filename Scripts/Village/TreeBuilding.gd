extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var buildingDeployed = false
var contaminationPoint = -6 # add into the contamination system later
var spaceTaken = 2 # add space constraint later
var treeBuildingLevel = 0

signal buildingIsDeployed
signal repelContamination
signal updateSpaceTaken
signal deduct_resources_for_tree_bldg
signal upgrade_tree_building
signal notify_max_level_achieved

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
	
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Building_ProgBar_building_complete():
	buildingDeployed = true
	treeBuildingLevel = 1
	emit_signal("buildingIsDeployed")
	emit_signal("updateSpaceTaken",spaceTaken)
	emit_signal("repelContamination",contaminationPoint) 
	

func _on_BuildingMenu_deploy_building_tree():
	#When signal deploy_building is emitted by buildingmenu, i.e. building chosen , building appears on village
	var current_ygg_level = self.get_parent().yggdrasilLevel
	
	if(treeBuildingLevel < current_ygg_level):
		if(treeBuildingLevel == 0):
			self.show()	
			var checklevelupgradegraphics = self.get_child(2)
			for child in self.get_children():
				if child == checklevelupgradegraphics:
					pass
				else:				
					for things in child.get_children():
						things.show()  # replace with function bodypass # replace with function body
		else:
			upgrade()
		emit_signal("deduct_resources_for_tree_bldg")
	else:
		emit_signal("notify_max_level_achieved") 
				
				
func upgrade():
	emit_signal("upgrade_tree_building")


func _on_Levelupbar_Tree_upgrade_tree_bldg_complete():
	treeBuildingLevel =2
	contaminationPoint = contaminationPoint * treeBuildingLevel
	emit_signal("updateSpaceTaken",spaceTaken)
	emit_signal("contaminationAdd",contaminationPoint)
