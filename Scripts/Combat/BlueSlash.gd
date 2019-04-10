extends Area2D

var direction = 1

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$Duration.start()
	pass
	
func set_slash_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true

func _physics_process(delta):
		$AnimatedSprite.play("Slash")

func _on_BlueSlash_body_entered(body):
	if "Mob" in body.name:
		body.rpc("dead")
		$Duration.start()
		#Player = get_parent()
		#Player.shotlimit += 1
	else:
		$Duration.start()

func _on_Duration_timeout():
	queue_free()