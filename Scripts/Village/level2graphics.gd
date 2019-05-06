extends TileMap

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	self.hide()
	



func _on_levelupprogbar_progbar_upgrade_complete():
	self.show()
