extends Node2D
onready var main = get_parent()
const GlobalListItem = preload("GlobalListItem.tscn")
const FriendListItem = preload("FriendListItem.tscn")
onready var view = [get_node(".")]

func _ready():
	$Interact/Friends.hide()
	print(view)
	for i in range(20):
		addGlobal(i, "Global " + str(i))
		addFriend(i, "Friend " + str(i))

func addGlobal(id, name):
	var global = GlobalListItem.instance()
	global.get_node("Label").text = name
	global.get_node("Button").text = "Add Friend"
	#friend.get_node("ContaLevel").text = contaLevel
	#friend.get_node("YggLevel").text = yggLevel
	#friend.get_node("HeroLevel").text = heroLevel
	#friend.get_node("Rank").text = rank
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
	#friend.id = id
	$Interact/Friends/List.add_child(friend)

func _on_ButtonGlobal_pressed():
	$Interact/Friends.hide()
	$Interact/Global.show()

func _on_ButtonFriends_pressed():
	$Interact/Global.hide()
	$Interact/Friends.show()


func _on_Back_pressed():
	var curr_node = view.pop_back()
	curr_node.hide()


func _on_Wish_pressed():
	view.push_back(get_node("Wish"))
	$Wish.show()


func _on_Interact_pressed():
	view.push_back(get_node("Interact"))
	$Interact.show()


func _on_Market_pressed():
	view.push_back(get_node("Market"))
	$Market.show()
