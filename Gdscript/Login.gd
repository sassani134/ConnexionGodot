extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")
	$VBoxContainer/ConnexionFailedLabel.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SignUpButton_pressed():
	get_tree().change_scene("res://SignUp.tscn")
	pass # Replace with function body.


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var response = parse_json(body.get_string_from_utf8())
	print(headers)
	print(response_code)
	if response_code == 200:
		Global.credentials = headers
		Global.accessToken = headers[7].split(" ")[1]
		Global.client = headers[9].split(" ")[1]
		Global.uid = headers[11].split(" ")[1]
		Global.expiry = headers[10].split(" ")[1]
		get_tree().change_scene("res://Scenes/Logged.tscn")
	else:
		$VBoxContainer/ConnexionFailedLabel.visible = true
		$VBoxContainer/ConnexionFailedLabel.visible = false
		$VBoxContainer/ConnexionFailedLabel.visible = true
		pass


func _on_LoginButton_pressed():
	var headers = ["Content-Type: application/json"]
	var body = {"email":$VBoxContainer/UserNameLineEdit.get_text(),"password":$VBoxContainer/PasswordLineEdit.get_text()}
	body = JSON.print(body)
	var error = $HTTPRequest.request("http://127.0.0.1:3000/auth/sign_in",headers, true, HTTPClient.METHOD_POST, body)
	if error != OK:
		push_error(" An error occured in  the HTTP request")
