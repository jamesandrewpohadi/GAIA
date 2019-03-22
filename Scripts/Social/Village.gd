extends Node2D

onready var main = get_parent()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Social_pressed():
	print(1)
	main.social.show()


func _on_Combat_pressed():
	var map = load('res://Scenes/Combat/MapScreen.tscn').instance()
	add_child(map)
	
