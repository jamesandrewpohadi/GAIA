extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const MAX_POINTS = 10 # maximum number of touch points.

##########################################################################
# VARIABLES
var events = [] 								# array containing all points touched on the screen

var pressed
var pressed2
var mousepos
var mousepos2
var leftcontrol
var rightcontrol

func _ready():
#	set_process_unhandled_input(true)	
	leftcontrol = get_child(0)
	rightcontrol = get_child(2)
	set_process_input(true)
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass


func _input(event):
	if event is InputEventMouseButton:
		mousepos = event.position
		if rightcontrol.get_rect().has_point(mousepos):
			if event.is_pressed(): #leftmousebutton
	#			touch_points[event.index].idx = event.index				# event index (used for study/debug)
				mousepos = event.position
				pressed=true
	#			events[0] = event
				get_tree().set_input_as_handled()
				rightcontrol._input(event)
#			else:
#				pressed=false
	pressed = false
#			events[0] = null
#	elif event is InputEventMouseMotion:
#		mousepos = event.position
#		if pressed:
##			events[1] = event 
#			get_tree().set_input_as_handled()
#			if leftcontrol.get_rect().has_point(mousepos):
#				leftcontrol.get_child(0)._input(event)
			
func _unhandled_input(event):
	if event is InputEventMouseButton:
		mousepos2 = event.position
		if rightcontrol.get_rect().has_point(mousepos2):
			pressed2=true
	if event is InputEventMouseMotion:
		mousepos2 = event.position
		if pressed2:
#			events[1] = event 
			get_tree().set_input_as_handled()
			if leftcontrol.get_rect().has_point(mousepos2):
				leftcontrol.get_child(0)._input(event)
	
	
			
	
#	update()
		
			
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
