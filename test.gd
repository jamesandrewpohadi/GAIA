extends HTTPRequest

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	request("https://gaia-f511d.firebaseio.com/users.json", [], false)
	#request("https://gaia-f511d.firebaseio.com/users/james.json", ['{"user_id" : "jack", "text" : "Ahoy!"}'], false,HTTPClient.METHOD_PUT,'{"user_id" : "jack", "text" : "Ahoy!"}')
	#request('https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyCrphpoB8N9n52mf1E6V5vVbNTkaaS_V-Q', ['Content-Type: application/json'], false, HTTPClient.METHOD_POST, '{"email":"jamesandrewpohadi@gmail.com","password":"Aa281099","returnSecureToken":true}')
	
func _on_test_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)

func _ready1():
	var err = 0
	var http = HTTPClient.new() # Create the Client
	err = http.connect_to_host("https://gaia-f511d.firebaseio.com",80) # Connect to host/port
	assert(err == OK) # Make sure connection was OK
	while http.get_status() == HTTPClient.STATUS_CONNECTING or http.get_status() == HTTPClient.STATUS_RESOLVING:
		http.poll()
		print("Connecting..")
		OS.delay_msec(500)

	assert(http.get_status() == HTTPClient.STATUS_CONNECTED) # Could not connect
	var headers = [
	]
	err = http.request(HTTPClient.METHOD_GET, "", headers) # Request a page from the site (this one was chunked..)
	assert(err == OK) # Make sure all is OK
	while http.get_status() == HTTPClient.STATUS_REQUESTING:
		http.poll()
		print("Requesting..")
		OS.delay_msec(500)

	assert(http.get_status() == HTTPClient.STATUS_BODY or http.get_status() == HTTPClient.STATUS_CONNECTED) # Make sure request finished well.
	print("response? ", http.has_response()) # Site might not have a response.

	if http.has_response():
		headers = http.get_response_headers_as_dictionary() # Get response headers
		print("code: ", http.get_response_code()) # Show response code
		print("**headers:\\n", headers) # Show headers
		if http.is_response_chunked():
			print("Response is Chunked!")
		else:
			var bl = http.get_response_body_length()
			print("Response Length: ",bl)
		var rb = PoolByteArray() # Array that will hold the data
		while http.get_status() == HTTPClient.STATUS_BODY:
			http.poll()
			var chunk = http.read_response_body_chunk() # Get a chunk
			if chunk.size() == 0:
				OS.delay_usec(1000)
			else:
				rb = rb + chunk # Append to read buffer
		print("bytes got: ", rb.size())
		var text = rb.get_string_from_ascii()
		print("Text: ", text)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass



