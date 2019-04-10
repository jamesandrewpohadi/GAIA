extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var pressed

func _ready():
#	set_process_unhandled_input(true)	
	set_process_input(false)
#	set_process_unhandled_input(false)
	# Called when the node is added to the scene for the first time.
	# Initialization here
#	for i in range(MAX_POINTS):
#		touch_points.append(
#			{
#				pos =  Vector2(),										# finger position
#			 	pressed = false,										# is pressed ?
#				idx = -1												# finger touch index
#			}
#		)
	
	pass

#func _input(event):
#	if event is InputEventMouseButton:
#		if event.is_pressed() && event.button_index==1: #leftmousebutton
##			touch_points[event.index].idx = event.index				# event index (used for study/debug)
#			event.position
#			pressed=true
##		else:
##			pressed=false
#	if event is InputEventMouseMotion:
#		if pressed:
#			make_input_local(event)
#			self.get_child(0)._input(event)
#	pass
			

func _on_AreaAnalogLeft_gui_input(ev):
	if ev is InputEventMouseButton and ev.button_index == BUTTON_LEFT and ev.pressed:
		return
	pass
