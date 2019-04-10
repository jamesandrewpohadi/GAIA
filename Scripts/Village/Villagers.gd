extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var villagerLevel = 0;
var villagerHappinessLevel = 5
var villagerMood = ["Happy","Sick"]
signal updateVillagerMenu
var currentContaminationLevel = 0
var villageStatus = [villagerLevel,villagerHappinessLevel,villagerMood[0]]

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	checkVillagerHappinessLevel()
	emit_signal("updateVillagerMenu",villageStatus)



func _on_AcademyBuilding_updateVillagerStatus(upLevel):
	villagerLevel += upLevel
	emit_signal("updateVillagerMenu", villageStatus)

func checkVillagerHappinessLevel():
	villagerHappinessLevel = -currentContaminationLevel
	if (villagerHappinessLevel <-2):
		villageStatus = [villagerLevel,villagerHappinessLevel,villagerMood[1]]
	else:
		villageStatus = [villagerLevel,villagerHappinessLevel,villagerMood[0]]

func _on_VillageScreen_update_villager_status(contaminationlevel):
	currentContaminationLevel = contaminationlevel
