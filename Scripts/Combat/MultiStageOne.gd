extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var main = get_tree().get_root().get_node("Main")
var networknode

func _ready():
	set_network_master(get_tree().get_network_unique_id())
	networknode = get_tree().get_root().get_node("Main/Network")
	for i in self.get_children():
		if "Boss" in i.name:
			i.set_network_master(1)
			i.health = i.health * networknode.players_incombat.size()
	for pstatus in $UI/PartyStatus.get_children():
		var pstatuspid = pstatus.get_network_master()
		for nodes in get_children():
			if "Player" in nodes.name:
				if nodes.get_network_master()==pstatuspid:
					var playerinfo = networknode.player_info[str(pstatuspid)]
					var playername = playerinfo["name"]
					pstatus.get_node("Playername").set_text(playername)
					pstatus.get_node("PlayerHealth").value = nodes.health*20
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	for pstatus in $UI/PartyStatus.get_children():
		var pstatuspid = pstatus.get_network_master()
		for nodes in get_children():
			if "Player" in nodes.name:
				if nodes.get_network_master()==pstatuspid:
					var playerinfo = networknode.player_info[str(pstatuspid)]
					var playername = playerinfo["name"]
					pstatus.get_node("Playername").set_text(playername)
					pstatus.get_node("PlayerHealth").value = nodes.health*20


func _on_Button_pressed():
	$UI/ConfirmationDialog.show_modal(true)
	pass # replace with function body


func _on_ConfirmationDialog_confirmed():
	queue_free()
	hide()
	rpc("goodbye_combat",get_tree().get_network_unique_id())

	for i in get_parent().get_children():
		if "Village" in i.name:
			i.show()
	
	



func _on_GoBack_pressed():
#	queue_free()
#	hide()
	rpc("goodbye_combat",get_tree().get_network_unique_id())
	main.get_node("Village").play()
	main.get_node("Combat").stop()
	main.village.show()
#	for i in get_parent().get_children():
#		if "Village" in i.name:
#			i.show()
	
sync func goodbye_combat(player_id):
	if(player_id==1):
		networknode.rpc("lobbynotingame")
	networknode.rpc("erase_player_incombat",player_id)
	print(networknode.players_incombat)
	for pstatus in $UI/PartyStatus.get_children():
		if pstatus.get_network_master()==player_id:
			pstatus.queue_free()
	if(get_tree().get_network_unique_id()!=player_id):
		for i in self.get_children():
			if str(player_id) in i.name:
				i.queue_free()
	else:
		queue_free()
		
	
sync func try_again():
	networknode = get_tree().get_root().get_node("Main/Network")
	networknode._player_lobby_entered(get_tree().get_network_unique_id())
	var stageOneMulti = load('res://Scenes/Combat/GameLobby.tscn').instance()
	get_tree().get_root().get_node("Main").add_child(stageOneMulti)
	networknode.lobbyingame = false
	self.queue_free()
	
func _on_TryAgain_pressed():
	main.get_node("Combat").play()
	main.get_node("Sad").stop()
	hide()
	rpc("try_again")
	pass


func _on_GoBack2_pressed():
#	queue_free()
	hide()
	rpc("goodbye_combat",get_tree().get_network_unique_id())
	main.get_node("Village").play()
	main.get_node("Combat").stop()
	main.village.show()
#	for i in get_parent().get_children():
#		if "Village" in i.name:
#			i.show()


func _on_TryAgain2_pressed():
	hide()
	rpc("try_again")
#	queue_free()
	pass
