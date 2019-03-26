extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var contaminationLevel = 0;
var spaceinVillage = 10;
signal update_yggdrasil_menu
signal update_yggdrasil_menu_space

func _ready():
	emit_signal("update_yggdrasil_menu",contaminationLevel)	
	emit_signal("update_yggdrasil_menu_space",spaceinVillage)

func _process(delta):
	emit_signal("update_yggdrasil_menu",contaminationLevel)

	


func _on_TreeBuilding_repelContamination(repel):
	if contaminationLevel<=0:
		contaminationLevel = 0
	else:
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
	emit_signal("update_yggdrasil_menu_space",spaceinVillage) 


func _on_FoodBuilding_updateSpaceTaken(space):
	spaceinVillage -= space
	emit_signal("update_yggdrasil_menu_space",spaceinVillage) 


func _on_OreBuilding_updateSpaceTaken(space):
	spaceinVillage -= space
	emit_signal("update_yggdrasil_menu_space",spaceinVillage) 


func _on_CementBuilding_updateSpaceTaken(space):
	spaceinVillage -= space
	emit_signal("update_yggdrasil_menu_space",spaceinVillage) 


func _on_AcademyBuilding_updateSpaceTaken(space):
	spaceinVillage -= space
	emit_signal("update_yggdrasil_menu_space",spaceinVillage) 


func _on_TreeBuilding_updateSpaceTaken(space):
	spaceinVillage -= space
	emit_signal("update_yggdrasil_menu_space",spaceinVillage) 
