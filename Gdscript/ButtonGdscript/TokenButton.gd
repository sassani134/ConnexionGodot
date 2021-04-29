extends Button

func _ready():
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")
	print("OK done")


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	#It works but if we click a second time to fast it bug.
	var response = parse_json(body.get_string_from_utf8())
	print(headers)
	print(response_code)
	if response_code == 200:
		if headers != Global.credentials:
			Global.credentials = headers
			Global.accessToken = headers[7].split(" ")[1]
			Global.client = headers[9].split(" ")[1]
			Global.uid = headers[11].split(" ")[1]
			Global.expiry = headers[10].split(" ")[1]


func _on_TokenButton_pressed():
	var headers = ["Content-Type: application/json","uid:" +Global.uid,"client:" +Global.client, "access-token:"+ Global.accessToken]
	var error = $HTTPRequest.request("http://127.0.0.1:3000/auth/validate_token",headers, true, HTTPClient.METHOD_GET)
	if error != OK:
		push_error(" An error occured in  the HTTP request")
