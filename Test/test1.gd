extends "res://addons/gut/test.gd"

var database = preload("res://Scenes/Social/Database.tscn")
var network = preload("res://Scenes/Social/Network.tscn")
var server
var client
var data

func before_each():
	data = database.instance()
	add_child(data)

func after_each():
	data.queue_free()

func test_query1():
	data.query("users/jaexp/GRO")
	yield(data,"done")
	assert_eq(data.res,1000,"query from firebase")

func test_put1():
	data.put("test",'{"health":100}')
	yield(data,"done")
	assert_eq(data.res.health, 100, "store value to database")
	
func test_put_query_consistency():
	data.put("test",'{"health":100}')
	yield(data,"done")
	data.query("test/health")
	yield(data,"done")
	assert_eq(data.res, 100, "query after store == value")

func test_login1():
	data.login("jaexp.bots@gmail.com","test1234")
	yield(data,"done")
	print(data.res)
	assert_true(data.res["registered"], 
	"crrect credentials == true")
	
func test_login2():
	data.login("jaexp.bots@gmail.com","test123")
	yield(data,"done")
	print(data.res)
	assert_eq(data.res["error"]["code"],400,
	"wrong password, hence error code 404")
	
func test_server1():
	server = network.instance()
	add_child(server)
	server._on_Host("127.0.0.1","server")
	assert_true(server.is_network_master(),"server is the network master")
	server.queue_free()
	
func test_client1():
	server = network.instance()
	add_child(server)
	server._on_Host("127.0.0.1","server")
	client = network.instance()
	add_child(client)
	client._on_Join("127.0.0.1",5000,"client")
	assert_true(client.get_tree().get_network_unique_id()!=1,
	"id = 1 only reserved for server")
	server.queue_free()
	client.queue_free()
	