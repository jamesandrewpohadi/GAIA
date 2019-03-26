extends Node2D

var status = ""
const GameListItem = preload("res://Scenes/Social/GameListItem.tscn")
onready var social = get_parent()
onready var database = load("res://Scenes/Social/Database.tscn").instance()
onready var main

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	main = get_tree().get_root().get_node("Main")
	add_child(database)
	

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	pass

func setList(category):
	clearList()
	match status:
		"sell":
			
			for category in ["Academy","Cement","Food","Ore","Water"]:
				database.query("game/market/"+category.to_lower()+"/"+main.network.player_name)
				yield(database, "done")
				var data = database.res
				addGameItem(category, main.network.name, str(data["amount"]), str(data["price"]), "Cancel", $ShopList/ScrollContainer/VBoxContainer)
		"buy":
			database.query("game/market/"+category.to_lower())
			yield(database, "done")
			var data = database.res
			print("game/market/"+category.to_lower())
			print(data)
			if (!data.empty()):
				for i in data.keys():
					if (i!=main.network.player_name):
						addGameItem(i, category, str(data[i]["amount"]), str(data[i]["price"]), "Buy", $ItemList/ScrollContainer/VBoxContainer)
#			for i in range(10):
#				addGameItem(category + str(i), category, str(10), "Buy", $ItemList/ScrollContainer/VBoxContainer)

func setShopList():
	clearList()
	for category in ["Academy","Cement","Food","Ore","Water"]:
		database.query("game/market/"+category.to_lower()+"/"+main.network.player_name)
		yield(database, "done")
		var data = database.res
		addGameItem(category, main.network.player_name, str(data["amount"]), str(data["price"]), "Cancel", $ShopList/ScrollContainer/VBoxContainer)
#	for i in range(5):
#		addGameItem("Ore" + str(i), "Ore", str(10), "Cancel", $ShopList/ScrollContainer/VBoxContainer)
#	for i in range(5):
#		addGameItem("Food" + str(i), "Food", str(10), "Cancel", $ShopList/ScrollContainer/VBoxContainer)
#	for i in range(5):
#		addGameItem("Cement" + str(i), "Cement", str(10), "Cancel", $ShopList/ScrollContainer/VBoxContainer)

func clearList():
	for i in $ItemList/ScrollContainer/VBoxContainer.get_children():
		i.queue_free()
	#pass
	
func addGameItem(name, category, amount, price,button_text, node):
	var gameItem = GameListItem.instance()
	# todo: query from the firebase regarding the item information
	gameItem.unit_price = int(price)/int(amount)
	gameItem.get_node("Name").text = name
	gameItem.get_node("Category").text = category
	gameItem.get_node("Amount").text = amount
	gameItem.get_node("Price").text = price
	gameItem.get_node("Button").text = button_text
	gameItem.get_node("EditAmount").text = amount
	gameItem.get_node("EditPrice").text = price
	match status:
		"sell":
			gameItem.status = "sell"
			var sell_func = funcref(gameItem, "sell")
			gameItem.dict_func = {
				my_func = sell_func
			}
		"buy":
			gameItem.status = "buy"
			var buy_func = funcref(gameItem, "buy")
			gameItem.dict_func = {
				my_func = buy_func
			}
			gameItem.get_node("EditPrice").hide()
	node.add_child(gameItem)

func _on_Sell_pressed():
	status = "sell"
	setShopList()
	social.view.push_back(get_node("ShopList"))
	$ShopList.show()

func _on_Buy_pressed():
	status = "buy"
	social.view.push_back(get_node("Items"))
	$Items.show()

func _on_Ores_pressed():
	setList("Ore")
	social.view.push_back(get_node("ItemList"))
	$ItemList.show()


func _on_Foods_pressed():
	setList("Food")
	social.view.push_back(get_node("ItemList"))
	$ItemList.show()


func _on_Water_pressed():
	setList("Water")
	social.view.push_back(get_node("ItemList"))
	$ItemList.show()


func _on_Cements_pressed():
	setList("Cement")
	social.view.push_back(get_node("ItemList"))
	$ItemList.show()


func _on_Academies_pressed():
	setList("Academy")
	social.view.push_back(get_node("ItemList"))
	$ItemList.show()


func _on_Add_pressed():
	social.view.push_back(get_node("Items"))
	$Items.show()
