extends Container
var dungeonMenu
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var player_id
signal on_lobby_entered
var networknode

func _ready():
	networknode = get_tree().get_root().get_node("Main/Network")
	dungeonMenu = get_node("DungeonMenu")
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_DungeonButton_pressed():
	dungeonMenu.show()
	pass # replace with function body


func _on_CloseButton_pressed():
	dungeonMenu.hide()
	pass # replace with function body


func _on_SoloButton_pressed():
	dungeonMenu.hide()
	hide()
	queue_free()
	var stageOne = load('res://Scenes/Combat/StageOne.tscn').instance()
	var player = load('res://Scenes/Combat/Player.tscn').instance()
	player.position=Vector2(50,500)
	player.set_network_master(get_tree().get_network_unique_id()) #set unique id as master
	stageOne.add_child(player)
	get_tree().get_root().get_node("Main").add_child(stageOne)




func _on_Exit_pressed():
	get_parent().get_parent().village.show()
	get_parent().hide()
	get_parent().queue_free()



func _on_CoOpButton_pressed():
	if(networknode.lobbyingame==true):
		get_node("DungeonMenu/AcceptDialog").popup()
	else:
		player_id = get_tree().get_network_unique_id()
		networknode = get_tree().get_root().get_node("Main/Network")
		networknode._player_lobby_entered(player_id)
		dungeonMenu.hide()
		hide()
		var stageOneMulti = load('res://Scenes/Combat/GameLobby.tscn').instance()
		get_tree().get_root().get_node("Main").add_child(stageOneMulti)
		queue_free()
		pass # replace with function body
