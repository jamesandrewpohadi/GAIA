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


func _ready():
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
			firebase_update()
			startTimeisSaved = true
		if ((OS.get_unix_time() - startTime) >= 60):
			firebase_update()
			startTimeisSaved = false
			print("updateFirebase")
	else:
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


func _on_YggdrasilStatus_update_village_system(yggdrasilStatus):
	#yggdrasilContamination = yggdrasilStatus[0]
	#yggdrasilLevel = yggdrasilStatus[1]
	#yggdrasilSpace = yggdrasilStatus[2]
	#Edit this part! Need to update properly
	pass
	


func _on_VillageUI_open_resource_menu():
	pass # replace with function body


func _on_Combat_pressed():
	var map = load('res://Scenes/Combat/MapScreen.tscn').instance()
	hide()
	get_parent().add_child(map)


func _on_Social_pressed():
	main.social.show()


func _on_Network_login_success(player_name):
	isLoggedin = true
	playerName = player_name

	
func firebase_update():
	database.query("users/"+playerName+"/game")
	yield(database,"done")
	var data = database.res
	yggdrasilLevel = int(data["level"]) 
	yggdrasilContamination = int(data["contamination"])
	print("yggdrasilContamination: ", yggdrasilContamination)
	yggdrasilSpace = int(data["space"])
	villagerLevel = int(data["villagerLevel"])
	database.query("users/"+playerName+"/game/buildings")
	yield(database,"done")
	data = database.res
	acadBldglvl = int(data["academyBuilding"])
	cementBldglvl = int(data["cementBuilding"])
	foodBldglvl = int(data["foodBuilding"])
	oreBldglvl = int(data["oreBuilding"])
	treeBldglvl = int(data["treeBuilding"])
	waterBldglvl = int(data["waterBuilding"])
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
	villagerArray = [villagerLevel,yggdrasilContamination]
	emit_signal("firebase_update_resources",resourceArray)
	emit_signal("firebase_update_villagers",villagerArray)
	emit_signal("firebase_update_yggdrasil",yggdrasilArray)
	emit_signal("firebase_update_acadBldg",acadBldglvl)
	emit_signal("firebase_update_waterBldg",waterBldglvl)
	emit_signal("firebase_update_oreBldg",oreBldglvl)
	emit_signal("firebase_update_foodBldg",foodBldglvl)
	emit_signal("firebase_update_cementBldg",cementBldglvl)
	
func update_firebase():
	pass
	