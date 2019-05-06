extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var contaminationLevel = 0;
var yggdrasilLevel = 1
var spaceinVillage = 10;
signal update_yggdrasil_menu
signal update_yggdrasil_menu_space
signal reject_upgrade_request
signal notify_upgrade_success
signal notify_max_level_achieved
signal update_village_system
signal update_bldgmenu_space
signal updateVillageScreen
var firebaseUpdating = false
var yggdrasilStatus

func _ready():
	yggdrasilStatus = [contaminationLevel,yggdrasilLevel,spaceinVillage]
	emit_signal("update_yggdrasil_menu",yggdrasilStatus)	
	#emit_signal("update_yggdrasil_menu_space",spaceinVillage)

func _process(delta):
	yggdrasilStatus = [contaminationLevel,yggdrasilLevel,spaceinVillage]
	emit_signal("update_yggdrasil_menu",yggdrasilStatus)
	emit_signal("update_village_system",yggdrasilStatus)

	


func _on_TreeBuilding_repelContamination(repel):
	contaminationLevel += repel


	
	


func _on_FoodBuilding_contaminationAdd(add):
	contaminationLevel += add

func _on_WaterBuilding_contaminationAdd(add):
	contaminationLevel += add

func _on_OreBuilding_contaminationAdd(add):
	contaminationLevel += add
	

func _on_CementBuilding_contaminationAdd(add):
	contaminationLevel += add

func _on_AcademyBuilding_contaminationAdd(add):
	contaminationLevel += add


func _on_WaterBuilding_updateSpaceTaken(space):
	spaceinVillage -= space


func _on_FoodBuilding_updateSpaceTaken(space):
	spaceinVillage -= space



func _on_OreBuilding_updateSpaceTaken(space):
	spaceinVillage -= space



func _on_CementBuilding_updateSpaceTaken(space):
	spaceinVillage -= space


func _on_AcademyBuilding_updateSpaceTaken(space):
	spaceinVillage -= space


func _on_TreeBuilding_updateSpaceTaken(space):
	spaceinVillage -= space


func _on_VillageResourcesCounter_response_to_upgrade_request(ans):
	if (ans == true):
		if( yggdrasilLevel >= 2):
			emit_signal("notify_max_level_achieved")
		else:
			yggdrasilLevel += 1
			spaceinVillage += 10
			yggdrasilStatus = [contaminationLevel,yggdrasilLevel,spaceinVillage]
			emit_signal("notify_upgrade_success")
		
		
	else:
		emit_signal("reject_upgrade_request")


func _on_VillageScreen_firebase_update_yggdrasil(yggdrasilArray):
	yggdrasilLevel = yggdrasilArray[0]
	contaminationLevel = yggdrasilArray[1]
	spaceinVillage = yggdrasilArray[2]
	emit_signal("update_bldgmenu_space",spaceinVillage)


func _on_VillageScreen_update_village_screen():
	emit_signal("updateVillageScreen",[yggdrasilLevel,contaminationLevel,spaceinVillage])
