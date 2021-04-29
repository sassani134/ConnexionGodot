extends Node

var credentials = null
var accessToken = null
var client = null
var uid = null
var expiry = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func resetCredentials():
	credentials = null
	accessToken = null
	client = null
	expiry = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
