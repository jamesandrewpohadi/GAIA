extends Node2D
onready var main = get_parent()
const GlobalListItem = preload("res://Scenes/Social/GlobalListItem.tscn")
const FriendListItem = preload("res://Scenes/Social/FriendListItem.tscn")
onready var view = [get_node(".")]
var database

func _ready():
	$Interact/Friends.hide()
	database = load("res://Scenes/Social/Database.tscn").instance()
	add_child(database)
	get_node("Interact/ButtonGlobal").grab_click_focus()
	for child in $Interact/Global/List.get_children():
		child.hide()
		child.queue_free()
	database.query("users")
	yield(database,"done")
	var i = 0
	var global_players = []
	for player in database.res.keys():
		print(player)
		global_players.append([player, database.res[player]["game"]["contamination"]])
	global_players.sort_custom(MyCustomSorter, "sort")
	for player in global_players:
		i+= 1
		addGlobal(player[0], i, player[1])

func update():
	for child in $Interact/Friends/List.get_children():
		child.hide()
		child.queue_free()
	
	for peer_id in main.network.player_info:
		if (peer_id != main.network.player_id):
			addFriend(peer_id, main.network.player_info[peer_id]["name"])
	
		

func addGlobal(name, rank, contamination):
	var global = GlobalListItem.instance()
	global.get_node("Label").text = name
	global.get_node("Button").hide()
	global.get_node("Rank").text = str(rank)
	global.get_node("Desc").text = "contamination: " + str(contamination)
	#friend.get_node("ContaLevel").text = contaLevel
	#friend.get_node("YggLevel").text = yggLevel
	#friend.get_node("HeroLevel").text = heroLevel
	#friend.get_node("Rank").text = rank
	global.ref = get_node(".")
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
		main.get_node("Village").play()
		main.get_node("Market").stop()
		hide()


func _on_Wish_pressed():
	view.push_back(get_node("Wish"))
	$Wish.showWishList()
	$Wish.show()


func _on_Interact_pressed():
	view.push_back(get_node("Interact"))
	$Interact.show()


func _on_Market_pressed():
	view.push_back(get_node("Market"))
	$Market.show()
	
class MyCustomSorter:
	static func sort(a,b):
		if a[1] < b[1]:
			return true
		else:
			return false