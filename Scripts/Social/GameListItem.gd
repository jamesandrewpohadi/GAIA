extends ColorRect

var dict_func
var unit_price
var status
var database = load("res://Scenes/Social/Database.tscn").instance()
var amount
var price
onready var main = get_tree().get_root().get_node("Main")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	add_child(database)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func sell():
	print("sell")
	var new_amount = int($Amount.text)
	var new_price = int($Price.text)
	var difference = new_amount-amount
	database.query("users/" + main.network.player_name + "/game/resources/"+$Name.text.to_lower())
	yield(database,"done")
	print("users/" + main.network.player_name + "/game/resources/"+$Name.text.to_lower())
	var update = database.res - difference
	if (update<0):
		$EditAmount.text = str(amount)
		$Amount.text = str(amount)
		$EditPrice.text = str(price)
		$Price.text = str(price)
		return null
	print(update)
	database.put("users/" + main.network.player_name + "/game/resources",'{"'+$Name.text.to_lower()+'":'+str(update)+'}')
	yield(database,"done")
	database.put("game/market/"+$Name.text.to_lower()+"/"+main.network.player_name,'{"amount":'+$Amount.text+',"price":'+$Price.text+'}')
	yield(database,"done")
	amount = new_amount
	price = new_price
	$Amount.text = str(amount)
	$Price.text = str(price)
	
func buy():
	var amount_left = int($Amount.text)-int($EditAmount.text)
	database.query("users/" + main.network.player_name + "/game/currency")
	yield(database,"done")
	var update = database.res - int($Price.text)
	if (update<0):
		return null
	database.put("users/" + main.network.player_name + "/game",'{"currency":'+str(update)+'}')
	yield(database,"done")
	#update sellers market
	database.put("game/market/"+$Category.text.to_lower()+"/"+$Name.text+ "/",'{"amount":'+str(amount_left)+',"price":'+str(amount_left*unit_price)+'}')
	yield(database,"done")
	#update my resources
	database.query("users/" + main.network.player_name + "/game/resources/"+$Category.text.to_lower())
	yield(database,"done")
	update = database.res + int($EditAmount.text)
	print(main.network.player_name)
	database.put("users/" + main.network.player_name + "/game/resources/",'{"'+$Category.text.to_lower()+'":'+str(update)+'}')
	yield(database,"done")
	#update seller's money
	database.query("users/" + $Name.text + "/game/currency")
	yield(database,"done")
	update = database.res + int($Price.text)
	database.put("users/" + $Name.text + "/game/",'{"currency":'+str(update)+'}')
	yield(database,"done")
	#update my money
	
	yield(database,"done")
	if (amount_left == 0):
		hide()
		queue_free()
	else:
		$Amount.text = str(amount_left)
		database.put("users/" + $Name.text + "/game/",'{"currency":'+str(update)+'}')
		yield(database,"done")
		
func wish():
	database.put("users/"+main.network.player_name+"/game/wish",'{"'+$Name.text.to_lower()+'":'+$EditAmount.text+'}')
	yield(database,"done")

func _on_Button_pressed():
	dict_func.my_func.call_func()


func _on_EditAmount_text_changed(new_text):
	match status:
		"buy":
			if (int(new_text)>int($Amount.text)):
				$EditAmount.text = $Amount.text
			else:
				$Price.text = str(int(new_text)*unit_price)
		"sell":
			$Amount.text = new_text


func _on_EditPrice_text_changed(new_text):
	$Price.text = new_text


func _on_EditPrice_text_entered(new_text):
	match status:
		"buy":
			pass
		"sell":
			database.put("game/market/"+$Name.text.to_lower()+"/"+$Category.text,'{"amount":'+$EditAmount.text+',"price":'+$EditPrice.text+'}')
			yield(database,"done")


func _on_EditAmount_text_entered(new_text):
	match status:
		"buy":
			pass
		"sell":
			database.put("game/market/"+$Name.text.to_lower()+"/"+$Category.text,'{"amount":'+$EditAmount.text+',"price":'+$EditPrice.text+'}')
