extends Label

func _ready():
	pass


func _on_ResourceMenu_waterResourceCount(resource):
	self.text = str(resource)
	self.update()
