extends Panel
signal host(host)
onready var main = get_parent()
onready var player_name = $InputName.text
onready var password = $Password.text
onready var host = $InputHost.text
onready var port = $InputPort.text

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	pass
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


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
			if (main.network.peer == null):
				main.network._on_Join(host, port, player_name)
			else:
				main.network.retry(player_name, main.network.player_id)
				
	
	
