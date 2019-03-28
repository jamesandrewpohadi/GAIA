extends Node2D

onready var network = get_parent().get_node("Network")
var recipient_id
var chats = {}
var ListItem
var listIndex = 0
var database

func _ready():
	ListItem = preload("res://Scenes/Social/GiftListItem.tscn")
	database = load("res://Scenes/Social/Database.tscn").instance()
	add_child(database)
	
func _process(delta):
	if recipient_id != null:
		$Messages.text = chats[int(recipient_id)]
		
func generateWishList(name):
	for child in $Panel2/ScrollContainer/ItemList.get_children():
		child.hide()
	database.query("users/"+name+"/game/wish")
	yield(database,"done")
	var data = database.res
	for category in data.keys():
		print(category)
		addItem(name,category,data[category])
	
func addItem(name, category, amount):
	var item = ListItem.instance()
	item.r_name = name
	item.get_node("Number").text = str(amount)
	item.get_node("GiftAmount").text = str(amount)
	item.get_node("ItemName").text=category
	$Panel2/ScrollContainer/ItemList.add_child(item)

func _on_MessageInput_text_entered(message):
	$MessageInput.text = ''
	rpc('display_message', recipient_id, network.player_id, network.player_name, message)
	

	
sync func display_message(id, sender_id, sender, message):
	if get_tree().is_network_server():
		print(sender+": "+ message)
		if (sender_id == network.player_id):
			chats[int(recipient_id)] += '\nYou' + ' : ' + message
			#rpc_id(id, "display_message", id, sender_id, sender, message)
		else:
			if (int(id) == int(network.player_id)):
				if (!chats.has(int(sender_id))):
					chats[int(sender_id)] = ""
				chats[int(sender_id)] += '\n' + sender + ' : ' + message
			#else:
				#rpc_id(id, "display_message", id, sender_id, sender, message)
				
			#$Messages.text += '\n' + sender + ' : ' + message
			
	else:
		print(sender+": "+ message)
		if (int(id) == int(network.player_id)):
			print("other send")
			if (!chats.has(int(sender_id))):
				chats[int(sender_id)] = ""
			chats[int(sender_id)] += '\n' + sender + ' : ' + message
			#$Messages.text += '\n' + sender + ' : ' + message
		elif (int(sender_id) == int(network.player_id)):
			print("I send")
			chats[int(recipient_id)] += '\nYou' + ' : ' + message
	print(chats)


func _on_Back_pressed():
	hide()
	
func initiate(name):
	$Panel/Name.text = name
