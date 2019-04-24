extends Node
var foodResource 
var oreResource 
var waterResource 
var cementResource 
var resourceArray
var yggdrasilLevel 
var yggdrasilContamination 
var yggdrasilSpace 
var yggdrasilArray
var villagerArray
var foodBldglvl 
var waterBldglvl 
var cementBldglvl 
var oreBldglvl 
var acadBldglvl 
var treeBldglvl 
var villagerLevel 
var isLoggedin = false
var playerName
var startTimeisSaved = false
var startTime
onready var main = get_parent()
onready var database = load("res://Scenes/Social/Database.tscn").instance()
var network
var firebaseUpdated = false
# class member variables go here, for example:
# var a = 2
# var b = "textvar"
signal update_village_status
signal update_villager_status
signal update_space_constraints_in_bldg_menu
signal firebase_update_resources
signal firebase_update_yggdrasil
signal firebase_update_villagers
signal firebase_update_waterBldg
signal firebase_update_foodBldg
signal firebase_update_oreBldg
signal firebase_update_cementBldg
signal firebase_update_acadBldg
signal firebase_update_treeBldg
signal build_request
signal update_village_screen

func _ready():
	database = load("res://Scenes/Social/Database.tscn").instance()
	main = get_tree().get_root().get_node("Main")
	network = main.get_node("Network")
	add_child(database)
	"""
	waterResource = $Wrapper/VillageResourcesCounter.waterResource
	foodResource = $Wrapper/VillageResourcesCounter.foodResource
	oreResource = $Wrapper/VillageResourcesCounter.oreResource
	cementResource = $Wrapper/VillageResourcesCounter.cementResource
	yggdrasilLevel = $Wrapper/YggdrasilStatus.yggdrasilLevel
	yggdrasilContamination = $Wrapper/YggdrasilStatus.contaminationLevel
	yggdrasilSpace = $Wrapper/YggdrasilStatus.spaceinVillage
	villagerLevel = $Wrapper/Villagers.villagerLevel
	foodBldglvl = $Wrapper/FoodBuilding.foodBuildingLevel
	waterBldglvl = $Wrapper/WaterBuilding.waterBuildingLevel
	cementBldglvl = $Wrapper/CementBuilding.cementBuildingLevel
	oreBldglvl = $Wrapper/OreBuilding.oreBuildingLevel
	acadBldglvl = $Wrapper/AcademyBuilding.academyBuildingLevel
	treeBldglvl = $Wrapper/TreeBuilding.treeBuildingLevel
	
	resourceArray = [waterResource,foodResource,oreResource,cementResource]
	"""
func _process(delta):
	if isLoggedin == true:
		if startTimeisSaved == false:
			startTime = OS.get_unix_time()
			startTimeisSaved = true
		if ((OS.get_unix_time() - startTime) >= 300):
			firebaseUpdated = true
			update_firebase()
			startTimeisSaved = false
		else:
			if startTimeisSaved == false:
				startTime = OS.get_unix_time()
				startTimeisSaved = true
			if ((OS.get_unix_time() - startTime) >= 300):
				update_firebase()
				startTimeisSaved = false
		"""
		waterResource = $Wrapper/VillageResourcesCounter.waterResource
		foodResource = $Wrapper/VillageResourcesCounter.foodResource
		oreResource = $Wrapper/VillageResourcesCounter.oreResource
		cementResource = $Wrapper/VillageResourcesCounter.cementResource
		yggdrasilLevel = $Wrapper/YggdrasilStatus.yggdrasilLevel
		yggdrasilContamination = $Wrapper/YggdrasilStatus.contaminationLevel
		yggdrasilSpace = $Wrapper/YggdrasilStatus.spaceinVillage
		villagerLevel = $Wrapper/Villagers.villagerLevel
		foodBldglvl = $Wrapper/FoodBuilding.foodBuildingLevel
		waterBldglvl = $Wrapper/WaterBuilding.waterBuildingLevel
		cementBldglvl = $Wrapper/CementBuilding.cementBuildingLevel
		oreBldglvl = $Wrapper/OreBuilding.oreBuildingLevel
		acadBldglvl = $Wrapper/AcademyBuilding.academyBuildingLevel
		"""
	else:
		waterResource = 0
		foodResource = 0
		oreResource = 0
		cementResource = 0
		yggdrasilLevel = 0
		yggdrasilContamination = 0
		yggdrasilSpace = 0
		villagerLevel = 0
		foodBldglvl = 0
		waterBldglvl = 0
		cementBldglvl = 0
		oreBldglvl = 0
		acadBldglvl = 0
	"""
	waterResource = $Wrapper/VillageResourcesCounter.waterResource
	foodResource = $Wrapper/VillageResourcesCounter.foodResource
	oreResource = $Wrapper/VillageResourcesCounter.oreResource
	cementResource = $Wrapper/VillageResourcesCounter.cementResource
	yggdrasilLevel = $Wrapper/YggdrasilStatus.yggdrasilLevel
	yggdrasilContamination = $Wrapper/YggdrasilStatus.contaminationLevel
	yggdrasilSpace = $Wrapper/YggdrasilStatus.spaceinVillage
	villagerLevel = $Wrapper/Villagers.villagerLevel
	foodBldglvl = $Wrapper/FoodBuilding.foodBuildingLevel
	waterBldglvl = $Wrapper/WaterBuilding.waterBuildingLevel
	cementBldglvl = $Wrapper/CementBuilding.cementBuildingLevel
	oreBldglvl = $Wrapper/OreBuilding.oreBuildingLevel
	acadBldglvl = $Wrapper/AcademyBuilding.academyBuildingLevel
	"""


func _on_YggdrasilStatus_update_village_system(yggdrasilStatus):
	#Might be able to ignore this command
	if isLoggedin == false:
		yggdrasilContamination = yggdrasilStatus[0]
		yggdrasilLevel = yggdrasilStatus[1]
		yggdrasilSpace = yggdrasilStatus[2]
				
	#Edit this part! Need to update properly
	#Test if this works
	


func _on_VillageUI_open_resource_menu():
	pass # replace with function body


func _on_Combat_pressed():
	firebase_update()
	main.get_node("Village").stop()
	main.get_node("Combat").play()
	var map = load('res://Scenes/Combat/MapScreen.tscn').instance()
	get_parent().add_child(map)
	hide()


func _on_Social_pressed():
	main.get_node("Village").stop()
	main.get_node("Market").play()
	main.social.show()


func _on_Network_login_success(player_name):
	print("login ticheng")
	isLoggedin = true
	playerName = player_name
	firebase_update()

	
func firebase_update():
	database.query("users/"+main.network.player_name+"/game/")
	yield(database,"done")
	var data = database.res
	print("Data is :", data)
	yggdrasilLevel = int(data["level"])
	yggdrasilContamination = int(data["contamination"])
	yggdrasilSpace = int(data["space"])
	villagerLevel = int(data["villagerLevel"])
	database.query("users/"+main.network.player_name+"/game/buildings")
	yield(database,"done")
	data = database.res
	acadBldglvl = int(data["academyBuilding"])
	cementBldglvl = int(data["cementBuilding"])
	foodBldglvl = int(data["foodBuilding"])
	oreBldglvl = int(data["oreBuilding"])
	treeBldglvl = int(data["treeBuilding"])
	waterBldglvl = int(data["waterBuilding"])
	print("player_name: ", playerName)
	print("VillageScreen waterBldglvl: ", waterBldglvl)
	database.query("users/"+playerName+"/game/resources")
	yield(database,"done")
	data = database.res
	cementResource = int(data["cement"])
	foodResource = int(data["food"])
	oreResource = int(data["ore"])
	waterResource = int(data["water"])
	#Emit the updated stuff to required place
	resourceArray = [cementResource,foodResource,oreResource,waterResource]
	yggdrasilArray = [yggdrasilLevel,yggdrasilContamination,yggdrasilSpace]
	print("isLoggedin is: ", isLoggedin)
	villagerArray = [villagerLevel,yggdrasilContamination]
	print("Village Screen's villagerArray: ", villagerArray)
	emit_signal("firebase_update_resources",resourceArray)
	emit_signal("firebase_update_villagers",villagerArray)
	emit_signal("firebase_update_yggdrasil",yggdrasilArray)
	emit_signal("firebase_update_acadBldg",acadBldglvl)
	emit_signal("firebase_update_waterBldg",waterBldglvl)
	emit_signal("firebase_update_oreBldg",oreBldglvl)
	emit_signal("firebase_update_foodBldg",foodBldglvl)
	emit_signal("firebase_update_cementBldg",cementBldglvl)
	emit_signal("firebase_update_treeBldg", treeBldglvl)
	
func update_firebase():
	print("updating firebase in progress")
	emit_signal("update_village_screen")
	database.put("users/"+playerName+"/game/buildings",'{"academyBuilding":'+str(acadBldglvl)+'}')
	yield(database,"done")
	database.put("users/"+playerName+"/game/buildings",'{"cementBuilding":'+str(cementBldglvl)+'}')
	yield(database,"done")
	database.put("users/"+playerName+"/game/buildings",'{"foodBuilding":'+str(foodBldglvl)+'}')
	yield(database,"done")
	database.put("users/"+playerName+"/game/buildings",'{"oreBuilding":'+str(oreBldglvl)+'}')
	yield(database,"done")
	database.put("users/"+playerName+"/game/buildings",'{"treeBuilding":'+str(treeBldglvl)+'}')
	yield(database,"done")
	database.put("users/"+playerName+"/game/buildings",'{"waterBuilding":'+str(waterBldglvl)+'}')
	yield(database,"done")
	database.put("users/"+playerName+"/game/resources", '{"cement":'+str(cementResource)+'}')
	yield(database,"done")
	database.put("users/"+playerName+"/game/resources", '{"food":'+str(foodResource)+'}')
	yield(database,"done")
	database.put("users/"+playerName+"/game/resources", '{"ore":'+str(oreResource)+'}')
	yield(database,"done")
	database.put("users/"+playerName+"/game/resources", '{"water":'+str(waterResource)+'}')
	yield(database,"done")
	database.put("users/"+playerName+"/game", '{"contamination":'+str(yggdrasilContamination)+'}')
	yield(database,"done")
	database.put("users/"+playerName+"/game", '{"level":'+str(yggdrasilLevel)+'}')
	yield(database,"done")
	database.put("users/"+playerName+"/game", '{"space":'+str(yggdrasilSpace)+'}')
	yield(database,"done")
	database.put("users/"+playerName+"/game", '{"villagerLevel":'+str(villagerLevel)+'}')
	yield(database,"done")
	print("update firebase completed!")
	print("food building is level: ", foodBldglvl)
	
	
func _on_SaveButton_pressed():
	update_firebase()


func _on_YggdrasilStatus_notify_upgrade_success():
	yggdrasilLevel = 2


func _on_BuildingMenu_update_resources_count_bldgmenu():
	firebase_update()
	resourceArray = [cementResource,foodResource,oreResource,waterResource]
	emit_signal("firebase_update_resources",resourceArray)
	#emit_signal("update_space_constraints_in_bldg_menu", yggdrasilSpace)


func _on_BuildingMenu_check_resources(resourceArray):
	print("Checking")
	print("resourceArray: ", resourceArray)
	if ( cementResource < resourceArray[0] or foodResource < resourceArray[1] or oreResource < resourceArray[2] or waterResource < resourceArray[3] or yggdrasilSpace < resourceArray[4]):
		emit_signal("build_request",[false, resourceArray[5]])
	else:
		emit_signal("build_request",[true,resourceArray[5]])


func _on_Villagers_updateVillageScreen(villagersLevel):
	villagerLevel = villagersLevel


func _on_YggdrasilStatus_updateVillageScreen(yggdrasilstatus):
	yggdrasilLevel = yggdrasilstatus[0]
	yggdrasilContamination = yggdrasilstatus[1]
	yggdrasilSpace = yggdrasilstatus[2]


func _on_VillageResourcesCounter_updateVillageScreen(resources):
	cementResource = resources[0]
	foodResource = resources[1]
	oreResource = resources[2]
	waterResource = resources[3]


func _on_TreeBuilding_updateVillageScreen(treelvl):
	treeBldglvl = treelvl


func _on_AcademyBuilding_updateVillageScreen(acadlvl):
	acadBldglvl = acadlvl



func _on_CementBuilding_updateVillageScreen(cementlvl):
	cementBldglvl = cementlvl


func _on_OreBuilding_updateVillageScreen(orelvl):
	oreBldglvl = orelvl



func _on_FoodBuilding_updateVillageScreen(foodlvl):
	foodBldglvl = foodlvl


func _on_WaterBuilding_updateVillageScreen(waterlvl):
	waterBldglvl = waterlvl
