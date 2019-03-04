extends Node

var touch_anterior = Vector2()
var primer_touch = false


func _ready():
	set_process_input(true)
	
func _input(event):
	if(event.type == InputEventScreenTouch):
		if(event.pressed):
			pass
			
	if(event.type == InputEventScreenDrag):
		if(!primer_touch):
			touch_anterior = event.relative_pos
			primer_drag = true
			
		else:
			var resultant = event.relative_pos*3 - touch_anterior
			get_tree().get_nodes_in_group("camera").set_pos(get_tree().get_nodes_in_group("camera").get_pos() + resultant)
			primer_touch = false
			
		get_tree().set_input_as_handled()
		
		
