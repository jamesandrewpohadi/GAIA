extends Panel
signal host(host)
onready var main = get_parent()
onready var player_name = $InputName.text
onready var password = $Password.text
onready var host = $InputHost.text
onready var PORT_SERVER = 1507
onready var PORT_CLIENT = 1509
onready var socketUDP = PacketPeerUDP.new()

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	print(IP.get_local_addresses())
	print("1.2.3.4".split("."))
	for ip in IP.get_local_addresses():
		var paths = ip.split(".")
		if (paths.size() == 4):
			if !(paths[0] == "169" || paths[0] == "192" || paths[3] == "1"):
				$InputHost.text = ip
				print(ip)
				break 

func _process(delta):
	if socketUDP.get_available_packet_count() > 0:
		var array_bytes = socketUDP.get_packet()
		print("msg server: " + array_bytes.get_string_from_ascii())

func _on_Host_pressed():
	player_name = $InputName.text
	password = $Password.text
	if (player_name == ""):
		var notif = load("res://Scenes/Social/Notification.tscn").instance()
		notif.respond(self,"Email is empty","Email must not be empty","Retry")
	elif (password == ""):
		var notif = load("res://Scenes/Social/Notification.tscn").instance()
		notif.respond(self,"Password is empty","Password must not be empty","Retry")
	var db = load("res://Scenes/Social/Database.tscn").instance();
	add_child(db)
	db.query("users/"+player_name+"/mail")	
	yield(db,"done")
	var mail = db.res
	if (db.res == null):
		var notif = load("res://Scenes/Social/Notification.tscn").instance()
		notif.respond(self,"Login Error","You haven't registered yet","Retry")
	else:
		db.login(mail,password)
		yield(db,"done")
		var res = db.res
		if ("error" in res):
			print("error")
		elif ("registered" in res):
			print("succeed")
			main.network.player_name = player_name
			main.network._on_Host(host, player_name)
			main.welcome.hide()
			
			
			#main.database.login(player_name, password)

func _on_Join_pressed():
	player_name = $InputName.text
	password = $Password.text
	if (player_name == ""):
		var notif = load("res://Scenes/Social/Notification.tscn").instance()
		notif.respond(self,"Email is empty","Email must not be empty","Retry")
	elif (password == ""):
		var notif = load("res://Scenes/Social/Notification.tscn").instance()
		notif.respond(self,"Password is empty","Password must not be empty","Retry")
	var db = load("res://Scenes/Social/Database.tscn").instance();
	add_child(db)
	db.query("users/"+player_name+"/mail")	
	yield(db,"done")
	var mail = db.res

	if (db.res == null):
		var notif = load("res://Scenes/Social/Notification.tscn").instance()
		notif.respond(self,"Login Error","You haven't registered yet","Retry")
	else:
		db.login(mail,password)
		yield(db,"done")
		var res = db.res
		if ("error" in res):
			var notif = load("res://Scenes/Social/Notification.tscn").instance()
			notif.respond(self,"Login Error","Login error","Retry")
		elif ("registered" in res):
			print("succeed")
			main.network.player_name = player_name
			main.network._on_Join($InputHost.text, 5000, player_name)
				
	
	


func _on_Broadcast_pressed():
	print(socketUDP.set_dest_address("10.12.255.255", PORT_SERVER))
	var stg = "hi server!"
	var pac = stg.to_ascii()
	socketUDP.put_packet(pac)
	print("send!")