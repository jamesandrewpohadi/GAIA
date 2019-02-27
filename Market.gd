extends Node2D

var status = ""
const GameListItem = preload("GameListItem.tscn")
#onready var social = get_parent()

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
				addGameItem(category + str(i), category, str(10), "Sell")
		"buy":
			for i in range(10):
				print(i)
				addGameItem(category + str(i), category, str(10), "Buy")

func clearList():
	#for i in $ItemList/ScrollContainer/VScrollBar.get_children():
    #i.queue_free()
	pass
	
func addGameItem(name, category, amount, button_text):
	var gameItem = GameListItem.instance()
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
	$ItemList/ScrollContainer/VBoxContainer.add_child(gameItem)

func _on_Sell_pressed():
	status = "sell"
	$Items.show()

func _on_Buy_pressed():
	status = "buy"
	$Items.show()

func _on_Ores_pressed():
	setList("Ore")
	$ItemList.show()


func _on_Foods_pressed():
	setList("Food")
	$ItemList.show()


func _on_Water_pressed():
	setList("Water")
	$ItemList.show()


func _on_Cements_pressed():
	setList("Cement")
	$ItemList.show()


func _on_Academies_pressed():
	setList("Academy")
	$ItemList.show()


func _on_Trees_pressed():
	setList("Tree")
	$ItemList.show()
