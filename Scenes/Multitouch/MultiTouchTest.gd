##########################################################################
#
# MultiTouch Screen DEMO for Godot Engine 2.x
# code by GregBUG (Gianluca D'Angelo) (C) 2017
# commends, suggestions to gregbug@gmail.com
#
# MultiTouch Screen Demo v1.00
# L'Aquila, 30 Gennaio 2017 - ITALY
#
##########################################################################

extends Node2D
##########################################################################
# CONSTANS
const MAX_POINTS = 10 # maximum number of touch points.

##########################################################################
# VARIABLES
var touch_points = [] 								# array containing all points touched on the screen
var fingers = 0 setget set_fingers					# setter for show fingers number on screen
#var txt_ball = preload("res://assets/ball.png")		# preload our ball texture
var default_font = null								# point to godot standard font
var lbl_points = null								# point to fingers label text

##########################################################################
# init scene when ready...
func _ready():
	set_process_unhandled_input(true)									# process user input
	lbl_points = get_node("lbl_punti_tocco/lbl_points")					# cache label point node
	default_font = get_node("lbl_punti_tocco").get_font("")				# get current font
	
	# allocate array for touch_points
	for _ in range(MAX_POINTS):
		touch_points.append(
			{
				pos =  Vector2(),										# finger position
			 	pressed = false,										# is pressed ?
				idx = -1												# finger touch index
			}
		)

##########################################################################
# draw fingers points on screen
func _draw():
	#var i = 0
	var draw_lines = true
	# draw points
	for point in touch_points:
		if point.pressed:
			# DRAW LINES #################################################
			# start drawing lines only if 2 or more fingers are on the screen
			if (fingers > 1):
				# draw only if needed...
				if (draw_lines): # && (i < MAX_POINTS):
					# set start line point (current point)
					var startpoint = point.pos
					# check array points
					for k in range(0, MAX_POINTS-1):
						# draw only if pressed
						if touch_points[k].pressed:
							# draw line from current point to next one...
							draw_line(startpoint, touch_points[k].pos, Color(1,1,1,1))
							# make current point the next one and go on...
							startpoint = touch_points[k].pos
							#continue
						# lines designed so don't redraw again...
						draw_lines = false
			# DRAW POINTS ################################################
			draw_texture(txt_ball, Vector2(point.pos.x-24, point.pos.y-24))
			draw_string(default_font, Vector2(point.pos.x-24, point.pos.y-24), str(point.idx))
		#i += 1
	self.fingers = fingers
##########################################################################
# handle unhzndled inputs (better for full screen)
func _unhandled_input(event):
	# user "drag" finger over screen... update position...
	if (event.type == InputEvent.SCREEN_DRAG):
		touch_points[event.index].pos = event.pos
	# user tap the screenm so take finger position, index add finger count
	if (event.type == InputEvent.SCREEN_TOUCH):
		if event.pressed:
			touch_points[event.index].idx = event.index				# event index (used for study/debug)
			touch_points[event.index].pos = event.pos				# update position
			touch_points[event.index].pressed = event.pressed		# update "pressed" flag
			fingers += 1											# increases fingers count
		else:
			# user lifts the finger from the screen decrase finger counter and update
			# "pressed" flag
			fingers -= 1											# decrements fingers count
			touch_points[event.index].pressed = false				# update pressed flag
	# draw point and connection lines...
	update()
	
##########################################################################
# write how many fingers are tapping the screen
func set_fingers(value):
	fingers = value
	if fingers > 0:
		lbl_points.set_text(str(fingers))
	else:
		lbl_points.set_text("0")