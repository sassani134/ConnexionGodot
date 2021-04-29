extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LoginButton_pressed():
	get_tree().change_scene("res://Login.tscn")
	pass # Replace with function body.


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var response = parse_json(body.get_string_from_utf8())
	print(headers)
	print(response_code)
	
	if $VBoxContainer/PasswordLineEdit != $VBoxContainer/PasswordLineEdit2.get_text():
		$VBoxContainer/ErrorLabel.text ="Passwords have to be the same"
		$VBoxContainer/ConnexionFailedLabel.visible = true
		$VBoxContainer/ConnexionFailedLabel.visible = false
		$VBoxContainer/ConnexionFailedLabel.visible = true
	elif response_code == 200 || 201:
		$VBoxContainer/ErrorLabel.text ="Account succefuly created"
		$VBoxContainer/ErrorLabel.visible = true
		$VBoxContainer/ErrorLabel.visible = false
		$VBoxContainer/ErrorLabel.visible = true
	else:
		$VBoxContainer/ErrorLabel.text ="Something went wrong"
		$VBoxContainer/ConnexionFailedLabel.visible = true
		$VBoxContainer/ConnexionFailedLabel.visible = false
		$VBoxContainer/ConnexionFailedLabel.visible = true
		pass
	pass # Replace with function body.


func _on_SignUpButton_pressed():
	var headers = ["Content-Type: application/json"]
	var body = {"email":$VBoxContainer/UserNameLineEdit.get_text(),
	"password":$VBoxContainer/PasswordLineEdit.get_text(),
	"password_confirmation":$VBoxContainer/PasswordLineEdit2.get_text()}
	body = JSON.print(body)
	var error = $HTTPRequest.request("http://127.0.0.1:3000/",headers, true, HTTPClient.METHOD_POST, body)
	if error != OK:
		push_error(" An error occured in the HTTP request")
	pass # Replace with function body.
