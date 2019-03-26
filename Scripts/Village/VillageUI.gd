extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
signal open_build_menu
signal open_resource_menu
signal open_yggdrasil_menu
signal open_villager_menu

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Build_pressed():
	#emit signal when Build button is pressed
	emit_signal("open_build_menu")
 # replace with function body


func _on_Resources_pressed():
	emit_signal("open_resource_menu")
	 # replace with function body


func _on_Yggdrasil_button_pressed():
	emit_signal("open_yggdrasil_menu")


func _on_Villager_button_pressed():
	emit_signal("open_villager_menu")
