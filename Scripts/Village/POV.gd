extends Node

var position = Vector2()
var SCALE = 10
signal move_camera

func _ready():
	pass


func _on_SwipeDetector_swiped(direction):
	position.x += direction.x * SCALE
	position.y += direction.y * SCALE
	emit_signal("move_camera", position)
	
