extends PopupDialog

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_YggdrasilStatus_notify_max_level_achieved():
	self.popup()


func _on_WaterBuilding_notify_max_level_achieved():
	self.popup()


func _on_FoodBuilding_notify_max_level_achieved():
	self.popup()


func _on_OreBuilding_notify_max_level_achieved():
	self.popup()

func _on_CementBuilding_notify_max_level_achieved():
	self.popup() 


func _on_AcademyBuilding_notify_max_level_achieved():
	self.popup() 


func _on_TreeBuilding_notify_max_level_achieved():
	self.popup() 


func _on_VillageResourcesCounter_max_level_reached():
	self.popup()
