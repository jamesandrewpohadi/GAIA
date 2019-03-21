extends Control
signal open_villager_menu
signal update_villager_menu

func _ready():
	pass


func _on_VillageUI_open_villager_menu():
	emit_signal("open_villager_menu")


func _on_Villagers_updateVillagerMenu(villagerLevel):
	emit_signal("update_villager_menu",villagerLevel)
