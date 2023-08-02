@tool
extends AssetBrowserComponent

@export var key_var:String
@export var prefix_text:String

func _ready():
	if data_manager and pages_manager:
		$SpinBox.value_changed.connect(text_was_changed)
		$SpinBox.value = filter_data(data_manager.get_val(key_var))

func filter_data(val):
	if val == null:
		return 0
	else:
		return val


func text_was_changed(val:float):
	data_manager.set_val(key_var, val)
