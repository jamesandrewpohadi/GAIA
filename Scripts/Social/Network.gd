extends Node

#var host = '127.0.0.1'
var port = 5000
var player_name
var player_id
var lobbynode
var peer
var rejected = false
onready var main = get_parent()
onready var player_info = {}
onready var my_info={}

onready var players_incombat = {}
var lobbyingame = false
signal login_success

func _ready():
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("network_peer_connected", self, "_player_connected")
		
sync func lobbynotingame():
	lobbyingame = false
	

func _on_Join(host, port, name):
	print("on join")
	peer = NetworkedMultiplayerENet.new()
	peer.create_client(host, 5000)
	get_tree().set_network_peer(peer)
	player_id = str(get_tree().get_network_unique_id())
	my_info["name"] = player_name
	player_info[player_id] = my_info
	emit_signal("login_success", player_name)
	
func _on_Host(host, name):
	peer = NetworkedMultiplayerENet.new()
	peer.create_server(5000,5)
	get_tree().set_network_peer(peer)
	player_id = str(get_tree().get_network_unique_id())
	my_info["name"] = player_name
	player_info[player_id] = my_info
	emit_signal("login_success", player_name)
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
	if player_info.has(str(id)):
		player_info.erase(str(id))
	if players_incombat.has(id):
		players_incombat.erase(id)
	#$Display.text += '\n ' + str(id) + ' has left'
	print('\n ' + str(id) + ' has left')
	
func _connected_ok():
	print("you have connected to a server")
	rpc('register_player', int(player_id), my_info)
	
	
func retry(player_name, id):
	rpc('check_exist', player_name, int(id))
	main.welcome.hide()
	
remote func login_fail():
	var notif = load("res://Scenes/Social/Notification.tscn").instance()
	notif.respond(main.welcome,"Player exist","Player with name "+player_name+" already in the game.","Retry")
	
remote func login_succeed():
	main.welcome.hide()
	main.village.get_node("VillageCamera/CanvasLayer/VillageUI").show()
	
remote func register_player(id, info):
	# Store the info
	
	# If I'm the server, let the new guy know about existing players
	if get_tree().is_network_server():
		# Send my info to new player
		for peer_id in player_info:
			if (player_info[peer_id]["name"] == info["name"]):
				rpc_id(id,"login_fail")
				return
		rpc_id(id, "register_player", 1, my_info)	
		rpc_id(id, "login_succeed")
		print("client succeeed")
		# Send the info of existing players
		for peer_id in player_info:
			rpc_id(id, "register_player", peer_id, player_info[peer_id])
			rpc_id(int(peer_id), "register_player", id, info)
		
	player_info[str(id)] = info
	print(player_info)
	updatePeers()
	
func updatePeers():
	main.social.update()
	
func _player_lobby_entered(newlobby_id):
	if(get_tree().is_network_server()):
		if(!players_incombat.has(newlobby_id)):
			players_incombat[newlobby_id] = player_info[str(1)]
	else:
	#print(players_incombat)
		rpc("_inform_lobby",newlobby_id)
#	for peer_id in players_incombat:
#		rpc_id(

remote func _inform_lobby(newlobby_id):
	var infokey = str(newlobby_id)
	if(!players_incombat.has(newlobby_id)):
		players_incombat[newlobby_id] = player_info[infokey]
	if get_tree().is_network_server():
		# Send my info to new player
		rpc_id(newlobby_id, "_inform_lobby", 1)
		# Send the info of existing players
		for peer_id in players_incombat:
			rpc_id(newlobby_id, "_inform_lobby", peer_id)
			rpc_id(peer_id, "_inform_lobby", newlobby_id)
#	print("Player" + str(newlobby_id) + "has entered the lobby")
#	print(player_info)
	if(get_tree().get_root().get_node("Main/GameLobby")!=null):
		lobbynode = get_tree().get_root().get_node("Main/GameLobby")
		lobbynode.update_lobby()
	print(players_incombat)
	
sync func erase_player_incombat(player_id):
	if(players_incombat.has(player_id)):
		players_incombat.erase(player_id)
	

sync func check_exist(name, id):
	if (id != int(player_id)):
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