extends ColorRect

var dict_func
var unit_price
var status
var database = load("res://Scenes/Social/Database.tscn").instance()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	add_child(database)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func sell():
	database.put("game/market/"+$Name.text.to_lower()+"/"+$Category.text,'{"amount":'+str(0)+',"price":'+str(0)+'}')
	
func buy():
	
	var amount_left = int($Amount.text)-int($EditAmount.text)
	database.put("game/market/"+$Category.text.to_lower()+"/"+$Name.text,'{"amount":'+str(amount_left)+',"price":'+str(amount_left*unit_price)+'}')
	print("game/market"+$Category.text.to_lower()+"/"+$Name.text.to_lower())
	print('{"amount":'+str(amount_left)+',"price":'+str(amount_left*unit_price)+'}')
	yield(database,"done")
	if (amount_left == 0):
		hide()
		queue_free()
	else:
		$Amount.text = str(amount_left)

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
	database.put("game/market/"+$Name.text.to_lower()+"/"+$Category.text,'{"amount":'+$EditAmount.text+',"price":'+$EditPrice.text+'}')
	yield(database,"done")


func _on_EditAmount_text_entered(new_text):
	match status:
		"buy":
			pass
		"sell":
			database.put("game/market/"+$Name.text.to_lower()+"/"+$Category.text,'{"amount":'+$EditAmount.text+',"price":'+$EditPrice.text+'}')
