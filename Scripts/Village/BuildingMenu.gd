extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
signal deploy_building_food
signal deploy_building_water
signal deploy_building_ore
signal deploy_building_academy
signal deploy_building_cement
signal deploy_building_tree
signal insufficient_resources

var current_food_resource
var current_water_resource
var current_cement_resource
var current_ore_resource
var current_space_available

signal spend_resource
func _ready():
	#upon initialization, hide building menu
	for child in self.get_children():
		for stuff in child.get_children():
			stuff.hide()
	# Called when the node is added to the scene for the first time.
	# Initialization here
	#pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_VillageUI_open_build_menu():
	#When open build menu signal launched, i.e, build button is pressed, open building menu
	
	for child in self.get_children():
		child.popup()
		for stuff in child.get_children():
			stuff.show()


func _on_Build_Menu_Building_choose_pressed():
	emit_signal("deploy_building")
	self.hide()
	for child in self.get_children():
		child.hide()
		for stuff in child.get_children():
			stuff.hide() # replace with function body


func _on_SpendResource_pressed():
	emit_signal("spend_resource")
	 # replace with function body


func _on_Food_Building_Button_pressed():
	if (current_food_resource < 20 or current_water_resource < 20 or current_cement_resource < 10 or current_space_available<2):
		emit_signal("insufficient_resources")
	else:
		emit_signal("deploy_building_food")
		self.hide()
		for child in self.get_children():
			child.hide()
			for stuff in child.get_children():
				stuff.hide() # replace with function body

func _on_Water_Building_Button_pressed():
	if(current_cement_resource < 10 or current_food_resource < 10 or current_space_available < 2):
		emit_signal("insufficient_resources")
	else:		
		emit_signal("deploy_building_water")
		self.hide()
		for child in self.get_children():
			child.hide()
			for stuff in child.get_children():
				stuff.hide()

func _on_Ore_Building_Button_pressed():
	if(current_cement_resource < 40 or current_food_resource < 50 or current_water_resource < 50 or current_ore_resource < 20 or current_space_available<8):
		emit_signal("insufficient_resources")
	else:		
		emit_signal("deploy_building_ore")
		self.hide()
		for child in self.get_children():
			child.hide()
			for stuff in child.get_children():
				stuff.hide()
			



func _on_Cement_Building_Button_pressed():
	if(current_cement_resource < 10 or current_food_resource < 10 or current_water_resource < 10 or current_space_available < 2):
		emit_signal("insufficient_resources")
	else:
		emit_signal("deploy_building_cement")
		self.hide()
		for child in self.get_children():
			child.hide()
			for stuff in child.get_children():
				stuff.hide()


func _on_Academy_Building_Button_pressed():
	if (current_cement_resource < 30 or current_food_resource < 50 or current_water_resource < 50 or current_ore_resource < 20 or current_space_available < 8):
		emit_signal("insufficient_resources")
	else:
		emit_signal("deploy_building_academy")
		self.hide()
		for child in self.get_children():
			child.hide()
			for stuff in child.get_children():
				stuff.hide()


func _on_Tree_Building_Button_pressed():
	if (current_space_available < 2):
		emit_signal("insufficient_resources")
	else:
		emit_signal("deploy_building_tree")
		self.hide()
		for child in self.get_children():
			child.hide()
			for stuff in child.get_children():
				stuff.hide()


func _on_VillageScreen_update_village_status(resource):
	current_water_resource = resource[0]
	current_food_resource = resource[1]
	current_ore_resource = resource[2]
	current_cement_resource = resource[3]


func _on_VillageScreen_update_space_constraints_in_bldg_menu(space):
	current_space_available = space
