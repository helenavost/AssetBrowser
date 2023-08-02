@tool
extends AssetBrowserComponent

@export var key_var:String
@export var placeholder:String

func _ready():
	if data_manager and pages_manager:
	#shared_data.call_edit.connect(init_edit)
		$LineEdit.text_changed.connect(text_was_changed)
		$LineEdit.text = str(data_manager.get_val(key_var))


func text_was_changed(new_text:String):
	#print("Text was changed: "+new_text)
	data_manager.set_val(key_var, new_text)

	#current_single.set(key_var, new_text)
