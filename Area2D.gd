extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var dropname = "MonsterDrop"
var motion = Vector2()
var time = 0
var initpositiony
var looted = false

func _ready():
	print("Loot Entered")
	# Called when the node is added to the scene for the first time.
	# Initialization here
	initpositiony = self.position.y
	
	pass
	
func _physics_process(delta):
	time+=delta
	self.position.y = initpositiony - 10*sin(2*time)

	pass


func _on_MonsterDrop_body_entered(body):
		if "Player" in body.name:
			if looted == false:
				for nodes in get_parent().get_children():
					if "Player" in nodes.name:
						nodes.loot(dropname)
						print("looted")
				queue_free()
				looted = true
