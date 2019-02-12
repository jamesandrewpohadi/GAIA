extends Node

onready var network = get_parent().get_node("Network")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_MessageInput_text_entered(message):
	$MessageInput.text = ''
	rpc('display_message', network.player_name, message)
	
sync func display_message(sender, message):
	if sender != network.player_name:
		$Messages.text += '\n' + sender + ' : ' + message
	else:
		$Messages.text += '\nYou' + ' : ' + message
