@tool
class_name ABPSettingsList extends Resource

var order_list:Array = []
var resource_lib:Dictionary = {}

func clear_order():
	order_list.clear()

func append_new(v):
	order_list.append(v)

func set_res(k, r):
	resource_lib[k] = r

func get_res(k):
	if resource_lib.has(k):
		return resource_lib[k]

func remove_res(k):
	if resource_lib.has(k):
		resource_lib.erase(k)
