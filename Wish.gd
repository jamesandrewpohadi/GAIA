extends Node2D

const GameListItem = preload("GameListItem.tscn")
onready var social = get_parent()

func _ready():
	generateItemList("Ore")

func addGlobal(name):
	var global = GameListItem.instance()
	global.get_node("Name").text = name
	$Main/ScrollContainer/VBoxContainer.add_child(global)
	
func generateItemList(category):
	match category:
		"Ore":
			for i in range(5):
				addGlobal("Ore " + str(i))
		"Food":
			for i in range(5):
				addGlobal("Ore " + str(i))
		"Water":
			for i in range(5):
				addGlobal("Ore " + str(i))
		"Cement":
			for i in range(5):
				addGlobal("Ore " + str(i))
		

func _on_Button_pressed():
	social.view.push_back(get_node("ItemCategories"))
	$ItemCategories.show()
