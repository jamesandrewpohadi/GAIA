extends Control
signal open_yggdrasil_menu
signal update_yggdrasil_status #for contamination only
signal update_yggdrasil_status_ygglevel
signal update_yggdrasil_status_space
signal request_to_upgrade_yggdrasil
signal response_to_upgrade_yggdrasil

func _ready():
	pass


func _on_VillageUI_open_yggdrasil_menu():
	emit_signal("open_yggdrasil_menu")
	
	 # replace with function body




func _on_YggdrasilStatus_update_yggdrasil_menu(yggdrasilStatus):
	emit_signal("update_yggdrasil_status",yggdrasilStatus)
	emit_signal("update_yggdrasil_status_ygglevel",yggdrasilStatus[1])
	emit_signal("update_yggdrasil_status_space",yggdrasilStatus[2])
	

func _on_YggdrasilStatus_update_yggdrasil_menu_space(space):
	emit_signal("update_yggdrasil_status_space", space)
	


func _on_UpgradeButton_pressed():
	emit_signal("request_to_upgrade_yggdrasil")


func _on_VillageResourcesCounter_response_to_upgrade_request(ans):
	emit_signal("response_to_upgrade_yggdrasil",ans)