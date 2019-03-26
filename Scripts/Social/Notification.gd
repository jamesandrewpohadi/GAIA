extends Node2D

onready var main = get_parent()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func respond(node, title, message, action):
	node.add_child(self)
	$respond/Title.text = title
	$respond/Message.text = message
	$respond/Button.text = action
	$respond.show()


func _on_ButtonRespond_pressed():
	$respond.hide()
	queue_free()
