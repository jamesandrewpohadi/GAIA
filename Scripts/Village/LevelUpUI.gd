extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
signal upgrade_complete
signal run_upgrade_building_food
signal run_upgrade_building_water

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	self.hide()
	for child in self.get_children():
		child.hide()

func _process(delta):
	pass
	

func _on_FoodBuilding_upgrade_food_building():
	self.visible = true
	$level2graphics.hide()
	print("_on_FoodBuilding_upgrade_food_building")
	emit_signal("run_upgrade_building_food")



func _on_levelupprogbar_progbar_upgrade_complete():
	self.visible = true
	$level2graphics.hide()
	print("_on_WaterBuilding_upgrade_food_building")
	emit_signal("run_upgrade_building_water")

	