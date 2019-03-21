extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var oreResource = 0
var waterResource = 0
var cementResource = 0
var foodResource = 0

signal update_oreResource
signal update_waterResource
signal update_cementResource
signal update_foodResource


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


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

