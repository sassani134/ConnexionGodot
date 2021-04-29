extends Control

func _ready():
	#Set the Label text with the user information
	$VBoxContainer/NameLabel.text = str("Hello ", Global.uid)

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		print("uid:"+Global.uid)
		print("client:"+ Global.client)
		print("access Token " +Global.accessToken)
		
