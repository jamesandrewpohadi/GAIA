extends Panel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var ListItem = preload("GiftListItem.tscn")
var listIndex = 0

func addItem(value):
	var item = ListItem.instance()
	listIndex+=1
	item.get_node("number").text=str(listIndex)
	item.get_node("itemName").text=value
	item.rect_min_size=Vector2(320,30)
	$ScrollContainer/ItemList.add_child(item)
	

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	
	for i in range(20):
		addItem("test Gift Item")
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
