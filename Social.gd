extends Node2D
onready var chat = get_parent().get_node("Chat")
const GlobalListItem = preload("GlobalListItem.tscn")
const FriendListItem = preload("FriendListItem.tscn")

func _ready():
	$Panel/Friends.hide()
	for i in range(20):
		addGlobal(i, "Global " + str(i))
		addFriend(i, "Friend " + str(i))

func addGlobal(id, name):
	var global = GlobalListItem.instance()
	global.get_node("Label").text = name
	global.get_node("Button").text = "Add Friend"
	global.id = id
	$Panel/Global/List.add_child(global)
	
func addFriend(id, name):
	var friend = FriendListItem.instance()
	friend.get_node("Label").text = name
	friend.get_node("Button").text = "Chat"
	friend.id = id
	$Panel/Friends/List.add_child(friend)

func _on_ButtonGlobal_pressed():
	$Panel/Friends.hide()
	$Panel/Global.show()

func _on_ButtonFriends_pressed():
	$Panel/Global.hide()
	$Panel/Friends.show()


func _on_Back_pressed():
	hide()
