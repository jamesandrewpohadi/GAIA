extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var networknode

func _ready():
	set_network_master(get_tree().get_network_unique_id())
	networknode = get_tree().get_root().get_node("Main/Network")
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Button_pressed():
	$UI/ConfirmationDialog.show_modal(true)
	pass # replace with function body


func _on_ConfirmationDialog_confirmed():
	rpc("goodbye_combat",get_tree().get_network_unique_id())
	self.hide()
	for i in get_parent().get_children():
		if "Village" in i.name:
			i.show()
	
	
	self.queue_free()


func _on_GoBack_pressed():
	rpc("goodbye_combat",get_tree().get_network_unique_id())
	self.hide()
	for i in get_parent().get_children():
		if "Village" in i.name:
			i.show()
	
	
	self.queue_free()
	
sync func goodbye_combat(player_id):
	networknode.players_incombat.erase(player_id)
	if(get_tree().get_network_unique_id()!=player_id):
		for i in self.get_children():
			if str(player_id) in i.name:
				i.queue_free()
		
	
sync func try_again():
	networknode = get_tree().get_root().get_node("Main/Network")
	networknode._player_lobby_entered(get_tree().get_network_unique_id())
	var stageOneMulti = load('res://Scenes/Combat/GameLobby.tscn').instance()
	get_tree().get_root().get_node("Main").add_child(stageOneMulti)
	self.queue_free()
	
func _on_TryAgain_pressed():
	hide()
	rpc("try_again")
	pass
#	rpc("reload_scene")
#	if get_tree().is_network_server():
#		# Send my info to new player
#		for peer_id in networknode.players_incombat:
#			if(peer_id!=1):
#				rpc_id(peer_id, "_on_TryAgain_pressed")
#	# Change scene
#	var world = load("res://Scenes/Combat/MultiStageOne.tscn").instance()
#	get_parent().add_child(world)
#	self.hide()
#
#	var player_scene = load("res://Scenes/Combat/Player.tscn")
#
#	for p_id in networknode.players_incombat:
#		var player = player_scene.instance()
##
#		player.set_name(str("Player")+str(p_id)) # Use unique ID as node name
#		player.position=Vector2(50,500)
#		player.set_network_master(p_id) #set unique id as master
#
##		if p_id == get_tree().get_network_unique_id():
#			# If node for this peer id, set name
##			player.set_player_name(player_name)
##		else:
#			# Otherwise set name from peer
##			player.set_player_name(players[p_id])
#
#		world.add_child(player)
#	queue_free()

#sync func reload_scene():
#	get_tree().reload_current_scene()

func _on_GoBack2_pressed():
	rpc("goodbye_combat",get_tree().get_network_unique_id())
	self.hide()
	for i in get_parent().get_children():
		if "Village" in i.name:
			i.show()
	
	
	self.queue_free()


func _on_TryAgain2_pressed():
	hide()
	rpc("try_again")
	queue_free()
	pass
