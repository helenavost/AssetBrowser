@tool
extends AssetBrowserComponent

@export var caption:String


func _ready():
	$Button.pressed.connect(was_pressed)
	$Button.text = caption


func was_pressed():
	pages_manager.go_back()
