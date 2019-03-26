extends Node2D

var status = ""
const GameListItem = preload("res://Scenes/Social/GameListItem.tscn")
onready var social = get_parent()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func setList(category):
	clearList()
	match status:
		"sell":
			for i in range(10):
				print(i)
				addGameItem(category + str(i), category, str(10), "Sell", $ItemList/ScrollContainer/VBoxContainer)
		"buy":
			for i in range(10):
				print(i)
				addGameItem(category + str(i), category, str(10), "Buy", $ItemList/ScrollContainer/VBoxContainer)

func setShopList():
	clearList()
	for i in range(5):
		addGameItem("Ore" + str(i), "Ore", str(10), "Cancel", $ShopList/ScrollContainer/VBoxContainer)
	for i in range(5):
		addGameItem("Food" + str(i), "Food", str(10), "Cancel", $ShopList/ScrollContainer/VBoxContainer)
	for i in range(5):
		addGameItem("Cement" + str(i), "Cement", str(10), "Cancel", $ShopList/ScrollContainer/VBoxContainer)

func clearList():
	for i in $ItemList/ScrollContainer/VBoxContainer.get_children():
		i.queue_free()
	#pass
	
func addGameItem(name, category, amount, button_text, node):
	var gameItem = GameListItem.instance()
	# todo: query from the firebase regarding the item information
	
	gameItem.get_node("Name").text = name
	gameItem.get_node("Category").text = category
	gameItem.get_node("Amount").text = amount
	gameItem.get_node("Button").text = button_text
	match status:
		"sell":
			var sell_func = funcref(gameItem, "sell")
			gameItem.dict_func = {
				my_func = sell_func
			}
		"buy":
			var buy_func = funcref(gameItem, "buy")
			gameItem.dict_func = {
				my_func = buy_func
			}
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


func _on_Trees_pressed():
	setList("Tree")
	social.view.push_back(get_node("ItemList"))
	$ItemList.show()


func _on_Add_pressed():
	social.view.push_back(get_node("Items"))
	$Items.show()
