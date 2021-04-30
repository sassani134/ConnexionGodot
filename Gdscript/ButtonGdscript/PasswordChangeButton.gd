extends Button

func _ready():
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	if response_code == 200:
		Global.credentials = headers
		Global.accessToken = headers[7].split(" ")[1]
		Global.client = headers[9].split(" ")[1]
		Global.uid = headers[11].split(" ")[1]
		Global.expiry = headers[10].split(" ")[1]
		$Label.text = "You have succefuly change your password"
		$Label.add_color_override("font_color", Color(0,1,0))
		$Label.visible = true
	else:
		$Label.text = "Something went wrong with the password please retry"
		$Label.add_color_override("font_color", Color(1,0,0))
		$Label.visible = true

func _on_PasswordChangeButton_pressed():
	if get_tree().get_root().get_node("Logged/VBoxContainer/PasswordLineEdit").get_text() != get_tree().get_root().get_node("Logged/VBoxContainer/PasswordLineEdit2").get_text():
		$Label.text = "passwords must be identical"
		$Label.add_color_override("font_color", Color(1,0,0))
		$Label.visible = true
		return
	var headers = ["Content-Type: application/json","uid:" +Global.uid,"client:" +Global.client, "access-token:"+ Global.accessToken]
	var body = {"password":get_tree().get_root().get_node("Logged/VBoxContainer/PasswordLineEdit").get_text(),"password_confirmation":get_tree().get_root().get_node("Logged/VBoxContainer/PasswordLineEdit2").get_text()}
	body = JSON.print(body)
	var error = $HTTPRequest.request("http://127.0.0.1:3000/auth/password",headers, true, HTTPClient.METHOD_PUT, body)
	if error != OK:
		push_error(" An error occured in  the HTTP request")
