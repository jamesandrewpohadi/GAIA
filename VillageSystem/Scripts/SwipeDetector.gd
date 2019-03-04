extends Node

signal swiped(direction)#initialize swipe
signal swiped_canceled(start_position)#when swipe times out or gets cancelled

export(float, 1.0, 1.5) var MAX_DIAGONAL_SLOPE = 1.3 # detects if swipe is diagonal

onready var timer = $Timer
var swipe_start_position = Vector2()

func _input(event):
	if not event is InputEventScreenTouch:
		return
	
	if event.pressed:
		_start_detection(event.position)
	elif not timer.is_stopped():
		_end_detection(event.position)
		
		
		
func _start_detection(position):
	swipe_start_position = position
	timer.start()
	
	
func _end_detection(position):
	timer.stop()
	var direction = (position - swipe_start_position).normalized()
	if abs(direction.x) + abs(direction.y) >= MAX_DIAGONAL_SLOPE:
		return
	if abs(direction.x) > abs(direction.y):
		emit_signal('swiped', Vector2(-sign(direction.x), 0.0)) # why use -sign? when u swipe right, u move camera to left! That's why you need to invert the sign
	else:
		emit_signal('swiped', Vector2(0.0, -sign(direction.y)))

func _on_Timer_timeout():
	emit_signal('swiped_canceled' , swipe_start_position)
