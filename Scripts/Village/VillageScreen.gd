extends Node2D

onready var main = get_parent()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	pass

func _on_Social_pressed():
	main.social.show()
	
func _on_Combat_pressed():
	var map = load('res://Scenes/Combat/MapScreen.tscn').instance()
	hide()
	get_parent().add_child(map)
