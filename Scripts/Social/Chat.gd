extends Node2D

onready var network = get_parent().get_node("Network")
var recipient_id
var chats = {}

func _ready():
	pass
	
func _process(delta):
	if recipient_id != null:
		$Messages.text = chats[int(recipient_id)]
	

func _on_MessageInput_text_entered(message):
	$MessageInput.text = ''
	rpc('display_message', recipient_id, network.player_id, network.player_name, message)
	

	
sync func display_message(id, sender_id, sender, message):
	if get_tree().is_network_server():
		print(sender+": "+ message)
		if (sender_id == network.player_id):
			chats[int(recipient_id)] += '\nYou' + ' : ' + message
			#rpc_id(id, "display_message", id, sender_id, sender, message)
		else:
			if (int(id) == int(network.player_id)):
				if (!chats.has(int(sender_id))):
					chats[int(sender_id)] = ""
				chats[int(sender_id)] += '\n' + sender + ' : ' + message
			#else:
				#rpc_id(id, "display_message", id, sender_id, sender, message)
				
			#$Messages.text += '\n' + sender + ' : ' + message
			
	else:
		print(sender+": "+ message)
		if (int(id) == int(network.player_id)):
			print("other send")
			if (!chats.has(int(sender_id))):
				chats[int(sender_id)] = ""
			chats[int(sender_id)] += '\n' + sender + ' : ' + message
			#$Messages.text += '\n' + sender + ' : ' + message
		elif (int(sender_id) == int(network.player_id)):
			print("I send")
			chats[int(recipient_id)] += '\nYou' + ' : ' + message
	print(chats)


func _on_Back_pressed():
	hide()
	
func initiate(name):
	$Panel/Name.text = name
