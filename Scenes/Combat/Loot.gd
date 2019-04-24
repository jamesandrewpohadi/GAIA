extends Container

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	pass

func _on_Player_on_loot(dropname):
	for nodes in self.get_children():
		if dropname+"Text" in nodes.name:
#			("Debugging loot")
			var dropcount = int(nodes.text)
			dropcount += 1
			nodes.text = str(dropcount)
	pass # replace with function body
