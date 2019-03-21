extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
signal deploy_building_food
signal deploy_building_water
signal deploy_building_ore
signal deploy_building_academy
signal deploy_building_cement
signal deploy_building_tree


signal spend_resource
func _ready():
	#upon initialization, hide building menu
	for child in self.get_children():
		for stuff in child.get_children():
			stuff.hide()
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

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
	emit_signal("deploy_building_food")
	self.hide()
	for child in self.get_children():
		child.hide()
		for stuff in child.get_children():
			stuff.hide() # replace with function body

func _on_Water_Building_Button_pressed():
	emit_signal("deploy_building_water")
	self.hide()
	for child in self.get_children():
		child.hide()
		for stuff in child.get_children():
			stuff.hide()

func _on_Ore_Building_Button_pressed():
	emit_signal("deploy_building_ore")
	self.hide()
	for child in self.get_children():
		child.hide()
		for stuff in child.get_children():
			stuff.hide()
			



func _on_Cement_Building_Button_pressed():
	emit_signal("deploy_building_cement")
	self.hide()
	for child in self.get_children():
		child.hide()
		for stuff in child.get_children():
			stuff.hide()


func _on_Academy_Building_Button_pressed():
	emit_signal("deploy_building_academy")
	self.hide()
	for child in self.get_children():
		child.hide()
		for stuff in child.get_children():
			stuff.hide()


func _on_Tree_Building_Button_pressed():
	emit_signal("deploy_building_tree")
	self.hide()
	for child in self.get_children():
		child.hide()
		for stuff in child.get_children():
			stuff.hide()
