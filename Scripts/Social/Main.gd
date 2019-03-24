extends Node

onready var network = get_node("Network")
onready var village = get_node("VillageScreen")
onready var social = get_node("Social")
onready var chat = get_node("Chat")
onready var welcome = get_node("Welcome")
onready var notification = get_node("Notification")
onready var database = get_node("Database")

func _ready():
	#print(IP.get_local_addresses()[11])
	pass
	
