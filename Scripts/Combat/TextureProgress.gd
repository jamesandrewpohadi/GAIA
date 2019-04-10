extends TextureProgress

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var playernode

func _ready():
	playernode = get_node(get_parent().get_parent().get_path())
	on_Player_on_health_changed(playernode.health)
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func on_Player_on_health_changed(healthvalue):
	value = healthvalue*20
	pass # replace with function body
