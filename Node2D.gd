extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func init():
	var socket = PacketPeerUDP.new()
	socket.set_dest_address("127.0.0.1",4242)
	socket.put_packet("Your message here".to_ascii())
	print("Exiting application")
	self.quit()