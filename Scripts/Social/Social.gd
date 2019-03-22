extends Node2D
onready var main = get_parent()
const GlobalListItem = preload("res://Scenes/Social/GlobalListItem.tscn")
const FriendListItem = preload("res://Scenes/Social/FriendListItem.tscn")
onready var view = [get_node(".")]

func _ready():
	$Interact/Friends.hide()
	#for i in range(20):
	#	addGlobal(i, "Global " + str(i))
	#	addFriend(i, "Friend " + str(i))
	#print(main.network.player_info)
	#for peer_id in main.network.player_info:
	#	addGlobal(peer_id, main.network.player_info[peer_id]["name"])

func update():
	for child in $Interact/Global/List.get_children():
		child.hide()
		child.queue_free()
	for peer_id in main.network.player_info:
		addGlobal(peer_id, main.network.player_info[peer_id]["name"])
		

func addGlobal(id, name):
	var global = GlobalListItem.instance()
	global.get_node("Label").text = name
	global.get_node("Button").text = "Add Friend"
	#friend.get_node("ContaLevel").text = contaLevel
	#friend.get_node("YggLevel").text = yggLevel
	#friend.get_node("HeroLevel").text = heroLevel
	#friend.get_node("Rank").text = rank
	global.ref = get_node(".")
	global.id = id
	$Interact/Global/List.add_child(global)
	
func addFriend(id, name):
	var friend = FriendListItem.instance()
	friend.get_node("Label").text = name
	friend.get_node("Button").text = "Chat"
	#friend.get_node("ContaLevel").text = contaLevel
	#friend.get_node("YggLevel").text = yggLevel
	#friend.get_node("HeroLevel").text = heroLevel
	#friend.get_node("Rank").text = rank
	friend.name = name
	friend.id = id
	$Interact/Friends/List.add_child(friend)

func _on_ButtonGlobal_pressed():
	$Interact/Friends.hide()
	$Interact/Global.show()

func _on_ButtonFriends_pressed():
	$Interact/Global.hide()
	$Interact/Friends.show()


func _on_Back_pressed():
	if (view.size() > 1):
		var curr_node = view.pop_back()
		curr_node.hide()
	else:
		hide()


func _on_Wish_pressed():
	view.push_back(get_node("Wish"))
	$Wish.show()


func _on_Interact_pressed():
	view.push_back(get_node("Interact"))
	$Interact.show()


func _on_Market_pressed():
	view.push_back(get_node("Market"))
	$Market.show()
