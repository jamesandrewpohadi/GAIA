extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var villagerLevel = 0;

signal updateVillagerMenu

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	emit_signal("updateVillagerMenu",villagerLevel)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_AcademyBuilding_updateVillagerStatus(upLevel):
	villagerLevel += upLevel
	emit_signal("updateVillagerMenu", villagerLevel)