@tool
class_name ABPSettingsPage extends Resource

var mark:String = ""
var data_lib:Dictionary = {}

func set_val(k, v):
	data_lib[k] = v

func get_val(k):
	if data_lib.has(k):
		return data_lib[k]
