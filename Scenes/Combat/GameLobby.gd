extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var Playerinfo
var Playernames

var IconTexture = preload("res://icon.png")
var networknode
func _ready():
	print(self.get_path())
	if(get_tree().get_network_unique_id()!=1):
		$StartButton.hide()
	networknode = get_tree().get_root().get_node("Main/Network")
	print("Players in combat are:" + str(networknode.players_incombat))
	for peer_id in networknode.players_incombat:
		Playerinfo = networknode.players_incombat[peer_id]
		Playernames = Playerinfo["name"]
		$ItemList.add_item(Playernames,IconTexture)
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func update_lobby():
	$ItemList.clear()
	for peer_id in networknode.players_incombat:
		Playerinfo = networknode.players_incombat[peer_id]
		Playernames = Playerinfo["name"]
		$ItemList.add_item(Playernames,IconTexture)
	
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


remote func _on_StartButton_pressed():
	networknode.lobbyingame = true
	print(str(get_tree().get_network_unique_id())+" received onStartButton rpc")
	if get_tree().is_network_server():
		# Send my info to new player
		for peer_id in networknode.players_incombat:
			if(peer_id!=1):
				rpc_id(peer_id, "_on_StartButton_pressed")
	# Change scene
	var world = load("res://Scenes/Combat/MultiStageOne.tscn").instance()
	get_parent().add_child(world)

	var player_scene = preload("res://Scenes/Combat/Player.tscn")
	
	for p_id in networknode.players_incombat:
		
		var player = player_scene.instance()
		
		
		player.set_name(str("Player")+str(p_id)) # Use unique ID as node name
		
		player.position=Vector2(50+rand_range(0,20),500+rand_range(0,20))
		player.set_network_master(p_id) #set unique id as master

#		if p_id == get_tree().get_network_unique_id():
#			# If node for this peer id, set name
#			player.set_player_name(player_name)
#		else:
#			# Otherwise set name from peer
#			player.set_player_name(players[p_id])

		world.add_child(player)
		print("Player " + str(p_id) + " added in the game")
	
	hide()
	queue_free()

#	if not get_tree().is_network_server():
#		# Tell server we are ready to start
#		rpc_id(1, "ready_to_start", get_tree().get_network_unique_id())
#	elif players.size() == 0:
#		post_start_game()
	
		# Send the info of existing players
	pass # replace with function body


func _on_ExitButton_pressed():
	rpc("_goodbye_lobby",get_tree().get_network_unique_id())
	self.hide()
	var mapScreen = load('res://Scenes/Combat/MapScreen.tscn').instance()
	get_tree().get_root().get_node("Main").add_child(mapScreen)
	queue_free()
	pass # replace with function body
	
sync func _goodbye_lobby(player_id):
	networknode.rpc("erase_player_incombat",player_id)
	print(networknode.players_incombat)
	if(get_tree().get_network_unique_id()!=player_id):
		update_lobby()
	
