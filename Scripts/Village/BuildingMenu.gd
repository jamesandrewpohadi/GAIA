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

var current_food_resource = 0
var current_water_resource = 0
var current_cement_resource = 0
var current_ore_resource = 0 
var current_space_available = 0


signal spend_resource
signal check_resources
#signal update_resources_count_bldgmenu
func _ready():
	#upon initialization, hide building menu
	for child in self.get_children():
		for stuff in child.get_children():
			stuff.hide()
	# Called when the node is added to the scene for the first time.
	# Initialization here
	#pass

func _process(delta):
	#emit_signal("update_resources_count_bldgmenu")
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	pass


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
	emit_signal("check_resources", [10,20,0,20,2,"food"])
	#response signal to trigger deployment
	#if (current_food_resource < 20 or current_water_resource < 20 or current_cement_resource < 10 or current_space_available<2):


func _on_Water_Building_Button_pressed():
	emit_signal("check_resources", [10,10,0,0,2,"water"])


func _on_Ore_Building_Button_pressed():
	emit_signal("check_resources", [40,50,20,50,8,"ore"])



func _on_Cement_Building_Button_pressed():
	emit_signal("check_resources", [10,10,0,10,2,"cement"])


func _on_Academy_Building_Button_pressed():
	emit_signal("check_resources", [30,50,20,50,8,"academy"])


func _on_Tree_Building_Button_pressed():
	emit_signal("check_resources", [0,0,0,0,2,"tree"])



func _on_VillageResourcesCounter_update_bldgmenu_resources(resource):
	current_cement_resource = resource[0]
	current_food_resource = resource[1]
	current_ore_resource = resource[2]
	current_water_resource = resource[3]
	

func _on_YggdrasilStatus_update_bldgmenu_space(space):
	current_space_available = space
	

func _on_VillageScreen_build_request(checkArray):
	if(checkArray[0] == true and str(checkArray[1]) == "food"):
		emit_signal("deploy_building_food")
		self.hide()
		for child in self.get_children():
			child.hide()
			for stuff in child.get_children():
				stuff.hide() # replace with function body
	elif (checkArray[0] == true and str(checkArray[1]) == "water"):
		emit_signal("deploy_building_water")
		self.hide()
		for child in self.get_children():
			child.hide()
			for stuff in child.get_children():
				stuff.hide()
	elif (checkArray[0] == true and str(checkArray[1]) == "ore"):
		emit_signal("deploy_building_ore")
		self.hide()
		for child in self.get_children():
			child.hide()
			for stuff in child.get_children():
				stuff.hide()
	elif (checkArray[0] == true and str(checkArray[1]) == "cement"):
		emit_signal("deploy_building_cement")
		self.hide()
		for child in self.get_children():
			child.hide()
			for stuff in child.get_children():
				stuff.hide()
	elif (checkArray[0] == true and str(checkArray[1]) == "academy"):
		emit_signal("deploy_building_academy")
		self.hide()
		for child in self.get_children():
			child.hide()
			for stuff in child.get_children():
				stuff.hide()
	elif (checkArray[0] == true and str(checkArray[1]) == "tree"):
		emit_signal("deploy_building_tree")
		self.hide()
		for child in self.get_children():
			child.hide()
			for stuff in child.get_children():
				stuff.hide()
	else:
		emit_signal("insufficient_resources")
