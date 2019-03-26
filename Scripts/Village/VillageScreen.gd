extends Node
var foodResource 
var oreResource 
var waterResource 
var cementResource 
var resourceArray
var yggdrasilLevel
var yggdrasilContamination
var yggdrasilSpace
var villagerArray
onready var main = get_parent()

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
signal update_village_status
signal update_villager_status
signal update_space_constraints_in_bldg_menu

func _ready():
	waterResource = $Wrapper/VillageResourcesCounter.waterResource
	foodResource = $Wrapper/VillageResourcesCounter.foodResource
	oreResource = $Wrapper/VillageResourcesCounter.oreResource
	cementResource = $Wrapper/VillageResourcesCounter.cementResource
	resourceArray = [waterResource,foodResource,oreResource,cementResource]

func _process(delta):
	waterResource = $Wrapper/VillageResourcesCounter.waterResource
	foodResource = $Wrapper/VillageResourcesCounter.foodResource
	oreResource = $Wrapper/VillageResourcesCounter.oreResource
	cementResource = $Wrapper/VillageResourcesCounter.cementResource
	emit_signal("update_village_status",resourceArray)
	yggdrasilContamination = $Wrapper/YggdrasilStatus.contaminationLevel
	emit_signal("update_villager_status",yggdrasilContamination)
	emit_signal("update_space_constraints_in_bldg_menu",yggdrasilSpace)


func _on_YggdrasilStatus_update_village_system(yggdrasilStatus):
	yggdrasilContamination = yggdrasilStatus[0]
	yggdrasilLevel = yggdrasilStatus[1]
	yggdrasilSpace = yggdrasilStatus[2]
	
	


func _on_VillageUI_open_resource_menu():
	pass # replace with function body


func _on_Combat_pressed():
	var map = load('res://Scenes/Combat/MapScreen.tscn').instance()
	hide()
	get_parent().add_child(map)


func _on_Social_pressed():
	main.social.show()
