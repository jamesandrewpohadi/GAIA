extends Node

#var host = '127.0.0.1'
var port = 5000
var player_name
var player_id
var peer
var rejected = false
onready var main = get_parent()
onready var player_info = {}
onready var my_info={}

func _ready():
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("network_peer_connected", self, "_player_connected")

func _on_Join(host, port, name):
	print("on join")
	peer = NetworkedMultiplayerENet.new()
	peer.create_client(host, int(port))
	get_tree().set_network_peer(peer)
	player_id = str(get_tree().get_network_unique_id())
	my_info["name"] = player_name
	player_info[player_id] = my_info

func _on_Host(host, name):
	peer = NetworkedMultiplayerENet.new()
	peer.create_server(int(port),5)
	get_tree().set_network_peer(peer)
	player_id = str(get_tree().get_network_unique_id())
	my_info["name"] = player_name
	player_info[player_id] = my_info
	#main.welcome.hide()
	#main.village.get_node("VillageCamera/CanvasLayer/VillageUI").show()
	#main.village.is_village = true

func login(name, password):
	pass
	
func _player_connected(id):
	#$Display.text += '\n ' + str(id) + ' has joined'
	print("connect")
	print('\n ' + str(id) + ' has joined')
	
func _player_disconnected(id):
	#$Display.text += '\n ' + str(id) + ' has left'
	print('\n ' + str(id) + ' has left')
	
func _connected_ok():
	print("you have connected to a server")
	rpc('register_player', int(player_id), my_info)
	main.welcome.hide()
	#main.village.is_village = true
	main.village.get_node("VillageCamera/CanvasLayer/VillageUI").show()
	
func retry(player_name, id):
	rpc('check_exist', player_name, int(id))
	main.welcome.hide()
	
remote func register_player(id, info):
	# Store the info
	
	# If I'm the server, let the new guy know about existing players
	if get_tree().is_network_server():
		# Send my info to new player
		rpc_id(id, "register_player", 1, my_info)
		# Send the info of existing players
		for peer_id in player_info:
			rpc_id(id, "register_player", peer_id, player_info[peer_id])
			rpc_id(peer_id, "register_player", id, info)
	player_info[id] = info
	print(player_info)
	updatePeers()
	
func updatePeers():
	main.social.update()
	
sync func check_exist(name, id):
	if (id != player_id):
		print("check exist")
		print(player_name)
		print(name)
		if (name == player_name):
			print("reject")
			rpc_id(int(id), "rejected")
		else:
			print("accept")
			main.welcome.hide()
			rpc_id(int(id), "accepted")
		
remote func rejected():
	var notif = load("res://Scenes/Social/Notification.tscn").instance()
	notif.respond(self,"Login Error","You haven't registered yet","Retry")

remote func accepted():
	print("accepted")
	main.welcome.hide()
	main.village.get_node("VillageCamera/CanvasLayer/VillageUI").show()