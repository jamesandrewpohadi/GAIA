extends Control
signal open_yggdrasil_menu
signal update_yggdrasil_status #for contamination only
signal update_yggdrasil_status_space

func _ready():
	pass


func _on_VillageUI_open_yggdrasil_menu():
	emit_signal("open_yggdrasil_menu")
	
	 # replace with function body




func _on_YggdrasilStatus_update_yggdrasil_menu(contaminationLevel):
	emit_signal("update_yggdrasil_status",contaminationLevel)

func _on_YggdrasilStatus_update_yggdrasil_menu_space(space):
	emit_signal("update_yggdrasil_status_space", space)
