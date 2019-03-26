extends TileMap

func _ready():
	self.visible = false
	



func _on_Building_ProgBar_building_complete():
	self.visible = true
