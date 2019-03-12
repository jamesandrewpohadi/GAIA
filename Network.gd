extends Node

var host = '127.0.0.1'
var port = 5000
var player_name
var player_id
var peer
onready var main = get_parent()

func _ready():
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")

func _on_Join(host, port, name):
	peer = NetworkedMultiplayerENet.new()
	peer.create_client(host, int(port))
	get_tree().set_network_peer(peer)
	player_id = str(get_tree().get_network_unique_id())

func _on_Host(host, name):
	peer = NetworkedMultiplayerENet.new()
	peer.create_server(int(port),5)
	get_tree().set_network_peer(peer)
	player_id = str(get_tree().get_network_unique_id())

func login(name, password):
	pass
	
func _player_connected(id):
	$Display.text += '\n ' + str(id) + ' has joined'
	
func _player_disconnected(id):
	$Display.text += '\n ' + str(id) + ' has left'
	
func _connected_ok():
	
	print('You have joined the room')
	rpc('check_exist', player_name, int(player_id))
	
func retry(player_name, id):
	rpc('check_exist', player_name, int(id))
	
remote func check_exist(name, id):
	if name == player_name:
		rpc_id(id, "rejected")
	else:
		main.welcome.hide()
		rpc_id(id, "accepted")
		
remote func rejected():
	main.notification.respond("Error", "Player with name " + player_name + " is already in the game", "Retry")

remote func accepted():
	main.welcome.hide()