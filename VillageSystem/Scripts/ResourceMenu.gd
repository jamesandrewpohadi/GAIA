extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
signal activate_resource_counter
signal minus_resources
var minus_resources = 10
func _ready():
	self.hide()
	for child in self.get_children():
		for children in child.get_children():
			children.hide()
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_VillageUI_open_resource_menu():
	self.show()
	for child in self.get_children():
		child.popup()
		for children in child.get_children():
			children.show()
	 # replace with function body



func _on_BuildingMenu_spend_resource():
	emit_signal("minus_resources", minus_resources)
	


func _on_Buildings_buildingIsDeployed():
	emit_signal("activate_resource_counter")
