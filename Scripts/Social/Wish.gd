extends Node2D

const GameListItem = preload("res://Scenes/Social/GameListItem.tscn")
onready var social = get_parent()
onready var main
onready var database

func _ready():
	database = load("res://Scenes/Social/Database.tscn").instance()
	main = get_tree().get_root().get_node("Main")
	add_child(database)
	#generateItemList("Ore")

func addGlobal(name):
	var global = GameListItem.instance()
	global.get_node("Name").text = name
	$Main/ScrollContainer/VBoxContainer.add_child(global)
	
func showWishList():
	for child in get_node("Main/ScrollContainer/VBoxContainer").get_children():
		child.hide()
		child.queue_free()
	for category in ["Academy","Cement","Food","Ore","Water"]:
		database.query("users/"+main.network.player_name+"/game/wish/"+category.to_lower())
		yield(database, "done")
		var data = database.res
		addGameItem(category, database.res, "Update", get_node("Main/ScrollContainer/VBoxContainer"))

func _on_Button_pressed():
	social.view.push_back(get_node("ItemCategories"))
	$ItemCategories.show()
	
func addGameItem(category, amount,button_text, node):
	var gameItem = GameListItem.instance()
	# todo: query from the firebase regarding the item information
	gameItem.get_node("Name").text = category
	gameItem.get_node("Category").hide()
	gameItem.get_node("Amount").hide()
	gameItem.get_node("Price").hide()
	gameItem.get_node("Button").text = button_text
	gameItem.get_node("EditAmount").text = str(amount)
	gameItem.get_node("EditPrice").hide()
	gameItem.status = "sell"
	var sell_func = funcref(gameItem, "wish")
	gameItem.dict_func = {
		my_func = sell_func
	}
	node.add_child(gameItem)
