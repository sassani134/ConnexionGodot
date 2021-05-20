extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")
	print("OK done")


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	if response_code == 200:
		Global.credentials = null
		Global.accessToken = null
		Global.client = null
		Global.uid = null
		Global.expiry = null
		get_tree().change_scene("res://Scenes/Login.tscn")
	pass # Replace with function body.


func _on_DeleteButton_pressed():
	var headers = ["Content-Type: application/json","uid:" +Global.uid,"client:" +Global.client, "access-token:"+ Global.accessToken]
	var error = $HTTPRequest.request("http://127.0.0.1:3000/auth/",headers, true, HTTPClient.METHOD_DELETE)
	if error != OK:
		push_error(" An error occured in  the HTTP request")
