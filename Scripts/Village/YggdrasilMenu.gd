extends Control
signal open_yggdrasil_menu
func _ready():
	pass


func _on_VillageUI_open_yggdrasil_menu():
	emit_signal("open_yggdrasil_menu")
	 # replace with function body
