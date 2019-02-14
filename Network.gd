extends Node

var host = '127.0.0.1'
var port = 5000
var player_id
var player_name
onready var welcome = get_parent().get_node('Welcome')
onready var social = get_parent().get_node('Social')

func _ready():
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")

func _on_Join(host, port):
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(host, int(port))
	get_tree().set_network_peer(peer)
	player_id = str(get_tree().get_network_unique_id())

func _on_Host(host, port):
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(int(port),5)
	get_tree().set_network_peer(peer)
	player_id = str(get_tree().get_network_unique_id())
	
func _player_connected(id):
	$Display.text += '\n ' + str(id) + ' has joined'
	
func _player_disconnected(id):
	$Display.text += '\n ' + str(id) + ' has left'
	
func _connected_ok():
	welcome.hide()
	
	print('You have joined the room')
	rpc('add_player', player_name, player_id)
	
remote func add_player(name, id):
	welcome.hide()
	print(player + ' has joined the room')
