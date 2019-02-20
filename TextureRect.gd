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
	main.network._on_Host(host, player_name)
	main.network.player_name = player_name

func _on_Join_pressed():
	player_name = $InputName.text
	main.network.player_name = player_name
	if (main.network.peer == null):
		main.network._on_Join(host, port, player_name)
	else:
		main.network.retry(player_name, main.network.player_id)
	
