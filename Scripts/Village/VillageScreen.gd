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

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
signal update_village_status
signal update_villager_status
signal update_space_constraints_in_bldg_menu

func _ready():
	waterResource = self.get_child(11).waterResource
	foodResource = self.get_child(11).foodResource
	oreResource = self.get_child(11).oreResource
	cementResource = self.get_child(11).cementResource
	resourceArray = [waterResource,foodResource,oreResource,cementResource]

func _process(delta):
	waterResource = self.get_child(11).waterResource
	foodResource = self.get_child(11).foodResource
	oreResource = self.get_child(11).oreResource
	cementResource = self.get_child(11).cementResource
	emit_signal("update_village_status",resourceArray)
	yggdrasilContamination = $YggdrasilStatus.contaminationLevel
	emit_signal("update_villager_status",yggdrasilContamination)
	emit_signal("update_space_constraints_in_bldg_menu",yggdrasilSpace)


func _on_YggdrasilStatus_update_village_system(yggdrasilStatus):
	yggdrasilContamination = yggdrasilStatus[0]
	yggdrasilLevel = yggdrasilStatus[1]
	yggdrasilSpace = yggdrasilStatus[2]
	
	
