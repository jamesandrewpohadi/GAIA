extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var villagerLevel = 0;
var villagerHappinessLevel
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
	if (villagerHappinessLevel <0):
		villageStatus = [villagerLevel,villagerHappinessLevel,villagerMood[1]]
	else:
		villageStatus = [villagerLevel,villagerHappinessLevel,villagerMood[0]]

func _on_VillageScreen_update_villager_status(contaminationlevel):
	currentContaminationLevel = contaminationlevel


func _on_VillageScreen_firebase_update_villagers(villagerArray):
	villagerLevel = villagerArray[0]
	currentContaminationLevel = villagerArray[1]
	checkVillagerHappinessLevel()
	emit_signal("updateVillagerMenu", villageStatus)
	
