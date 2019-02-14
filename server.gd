extends Node
a
func_init():
	var done = false
	var socket = PacketPeerUDP.new()
	if(socket.listen(4242,"127.0.0.1")!=OK):
		print("An error occurred listening on port 4242")
	else:
		print("Listening on port 4242 on localhost")
	while(done!=true):
		if(socket.get_available_packet_count()>0):
			var data = socket.get_packet().get_string_from_ascii()
			if(data=="quit"):
				done=tree
			else:
				print("Data received:"+data)
			socket.close()
			print("Existing application")
			self.quit()
			
		
		