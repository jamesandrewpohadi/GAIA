extends HTTPRequest

onready var main = get_parent()

var root = "https://gaia-f511d.firebaseio.com/"

func login(mail, password):
	var response = request('https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyCrphpoB8N9n52mf1E6V5vVbNTkaaS_V-Q', ['Content-Type: application/json'], false, HTTPClient.METHOD_POST, '{"email":"' + mail +'","password":"' + password + '","returnSecureToken":true}')
	return response
	
func query(tree):
	var response = request("https://gaia-f511d.firebaseio.com/" + tree + ".json", [], false)
	return response
	
func put(tree, data):
	var response = request("https://gaia-f511d.firebaseio.com/" + tree + ".json", [], false,HTTPClient.METHOD_PUT, data)
	return response

func _ready():
	pass

func push():
	return "clear"

func _on_Database_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)
