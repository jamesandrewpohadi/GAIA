extends ColorRect

var database
var r_name
var main

func _ready():
	database = load("res://Scenes/Social/Database.tscn").instance()
	main = get_tree().get_root().get_node("Main")
	add_child(database)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Button_pressed():
	print("give")
	database.query("users/"+r_name+"/game/resources/"+$ItemName.text.to_lower())
	yield(database,"done")
	var new_amount = database.res + int($GiftAmount.text)
	database.put("users/"+r_name+"/game/resources",'{"'+$ItemName.text.to_lower()+'":'+str(new_amount)+'}')
	yield(database,"done")
	database.query("users/"+main.network.player_name+"/game/resources/"+$ItemName.text.to_lower())
	yield(database,"done")
	new_amount = database.res - int($GiftAmount.text)
	database.put("users/"+main.network.player_name+"/game/resources",'{"'+$ItemName.text.to_lower()+'":'+str(new_amount)+'}')
	yield(database,"done")
	var remaining = int($Number.text)-int($GiftAmount.text)
	database.put("users/"+r_name+"/game/wish",'{"'+$ItemName.text.to_lower()+'":'+str(remaining)+'}')
	yield(database,"done")
	$Number.text = str(remaining)
	$GiftAmount.text = str(min(remaining,int($GiftAmount.text)))