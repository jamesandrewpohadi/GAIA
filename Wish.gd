extends Node2D

const GameListItem = preload("GameListItem.tscn")

func _ready():
	#for i in range(20):
		#addGlobal("Item " + str(i), "resources")
	pass

func addGlobal(name):
	var global = GameListItem.instance()
	global.get_node("Name").text = name
	$ItemList/ScrollContainer/VBoxContainer.add_child(global)
	
func generateItemList(category):
	match category:
		"Ore":
			for i in range(5):
				addGlobal("Ore " + i)
		"Food":
			for i in range(5):
				addGlobal("Ore " + i)
		"Water":
			for i in range(5):
				addGlobal("Ore " + i)
		"Cement":
			for i in range(5):
				addGlobal("Ore " + i)
		

func _on_Button_pressed():
	$ItemCategories.show()
