extends HTTPRequest

onready var main = get_parent()
signal done

var root = "https://gaia-f511d.firebaseio.com/"
var res

func login(mail, password):
	var response = request('https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyCrphpoB8N9n52mf1E6V5vVbNTkaaS_V-Q', ['Content-Type: application/json'], false, HTTPClient.METHOD_POST, '{"email":"' + mail +'","password":"' + password + '","returnSecureToken":true}')
	yield(self, "done")
	return res
	
func query(tree):
	var response = request("https://gaia-f511d.firebaseio.com/" + tree + ".json", [], false)
	yield(self, "done")
	return res
	
func put(tree, data):
	var response = request("https://gaia-f511d.firebaseio.com/" + tree + ".json", [], false,HTTPClient.METHOD_PUT, data)
	yield(self, "done")
	return res

func _ready():
	#query("users/gaia/GRO")
	#yield(self, "done")
	#print(res)
	pass

func push():
	return "clear"

func _on_Database_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	res = json.result
	emit_signal("done")
	#print(json.result)
