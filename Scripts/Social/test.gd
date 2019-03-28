extends Node

func _ready():
	var database = load("res://Scenes/Social/Network.tscn").instance()
	
	# query
	# ======================================================
	database.query("game/maket/academy/jaexp")
	yield(database,"done")
	print(database.res) # return the result of the query
