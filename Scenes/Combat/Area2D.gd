extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var pressed

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Area2D_input_event(viewport, event, shape_idx):
	get_child(0)._unhandled_input(event)
	pass # replace with function body
