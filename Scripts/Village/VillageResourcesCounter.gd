extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var oreResource = 100
var waterResource = 100
var cementResource = 100
var foodResource = 100
signal update_oreResource
signal update_waterResource
signal update_cementResource
signal update_foodResource
signal response_to_upgrade_request
signal update_bldgmenu_resources
signal max_level_reached
var isLoggedin = false
var upgradeReq = 100


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func _ready():
	emit_signal("update_waterResource", waterResource)
	emit_signal("update_foodResource", foodResource)
	emit_signal("update_cementResource", cementResource)
	emit_signal("update_oreResource", oreResource)

func _on_OreBuilding_resourceCount(ores):
	oreResource += ores
	emit_signal("update_oreResource",oreResource)
	


func _on_WaterBuilding_resourceCount(water):
	waterResource += water
	emit_signal("update_waterResource",waterResource)


func _on_FoodBuilding_resourceCount(food):
	foodResource += food
	emit_signal("update_foodResource",foodResource)


func _on_CementBuilding_resourceCount(cement):
	cementResource += cement
	emit_signal("update_cementResource",cementResource)



func _on_YggdrasilMenu_request_to_upgrade_yggdrasil():
	if(oreResource < upgradeReq or foodResource < upgradeReq or cementResource < upgradeReq or waterResource<upgradeReq):
		emit_signal("response_to_upgrade_request",false)
	else:
		if(self.get_parent().get_parent().yggdrasilLevel >= 2):
			emit_signal("max_level_reached")
		else:
			oreResource -= upgradeReq
			waterResource -= upgradeReq
			foodResource -= upgradeReq
			cementResource -= upgradeReq
			print("minus resource for upgrade")
			emit_signal("update_waterResource",waterResource)
			emit_signal("update_foodResource", foodResource)
			emit_signal("update_cementResource", cementResource)
			emit_signal("update_oreResource", oreResource)
			emit_signal("response_to_upgrade_request", true)



func _on_WaterBuilding_deduct_resources_for_water_bldg():
	oreResource -= 10
	cementResource -= 10
	emit_signal("update_cementResource",cementResource)
	emit_signal("update_oreResource",oreResource)

func _on_FoodBuilding_deduct_resources_for_food_bldg():
	waterResource -= 20 
	foodResource -= 20
	cementResource -= 10
	emit_signal("update_waterResource",waterResource)
	emit_signal("update_foodResource",foodResource)
	emit_signal("update_cementResource",cementResource)


func _on_OreBuilding_deduct_resources_for_ore_bldg():
	cementResource -=40
	foodResource -= 50
	waterResource -= 50
	emit_signal("update_waterResource",waterResource)
	emit_signal("update_foodResource",foodResource)
	emit_signal("update_cementResource",cementResource)



func _on_CementBuilding_deduct_resources_for_cement_bldg():
	cementResource -= 10
	foodResource -= 10
	waterResource -= 10
	emit_signal("update_waterResource",waterResource)
	emit_signal("update_foodResource",foodResource)
	emit_signal("update_cementResource",cementResource)

	


func _on_AcademyBuilding_deduct_resources_for_academy_bldg():
	cementResource -= 30
	foodResource -= 50
	waterResource -= 50
	oreResource -= 20
	emit_signal("update_waterResource",waterResource)
	emit_signal("update_foodResource",foodResource)
	emit_signal("update_cementResource",cementResource)
	emit_signal("update_oreResource",oreResource)
	


func _on_VillageScreen_firebase_update_resources(resourceArray):
	cementResource = resourceArray[0]
	foodResource = resourceArray[1]
	oreResource = resourceArray[2]
	waterResource = resourceArray[3]
	emit_signal("update_waterResource",waterResource)
	emit_signal("update_foodResource",foodResource)
	emit_signal("update_cementResource",cementResource)
	emit_signal("update_oreResource",oreResource)
	emit_signal("update_bldgmenu_resources",resourceArray)


