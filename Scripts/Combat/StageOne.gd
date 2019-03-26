extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Button_pressed():
	$UI/ConfirmationDialog.show_modal(true)
	pass # replace with function body


func _on_ConfirmationDialog_confirmed():
	get_parent().get_parent().village.show()
	get_parent().hide()
	get_parent().queue_free()


func _on_GoBack_pressed():
	get_parent().get_parent().village.show()
	get_parent().hide()
	get_parent().queue_free()

func _on_TryAgain_pressed():
	var stageOne = load('res://Scenes/Combat/StageOne.tscn').instance()
	get_parent().add_child(stageOne)
	hide()
	queue_free()


#func _on_TryAgain2_pressed():
#	get_tree().reload_current_scene()
#	pass # replace with function body
#
#
#func _on_GoBack2_pressed():
#	get_parent().hide()
#	get_parent().queue_free()
#	pass # replace with function body