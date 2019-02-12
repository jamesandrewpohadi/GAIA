extends TextureRect
signal host(host)
var network
onready var host = $InputHost.text
onready var port = $InputPort.text

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	print(11)
	network = get_parent().get_node("Network")
	print(network)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Host_pressed():
	network._on_Host(host, port)
	network.player_name = $InputName.text

func _on_Join_pressed():
	network._on_Join(host, port)
	network.player_name = $InputName.text
