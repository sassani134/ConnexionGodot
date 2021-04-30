extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")
	print("OK done")



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var response = parse_json(body.get_string_from_utf8())
	print(headers)
	print(response_code)
	if response_code == 200:
		get_tree().change_scene("res://Scenes/Login.tscn")


func _on_deconectButton_pressed():
	var headers = ["Content-Type: application/json","uid:" +Global.uid,"client:" +Global.client, "access-token:"+ Global.accessToken]
	var error = $HTTPRequest.request("http://127.0.0.1:3000/auth/sign_out",headers, true, HTTPClient.METHOD_DELETE)
	if error != OK:
		push_error(" An error occured in  the HTTP request")
