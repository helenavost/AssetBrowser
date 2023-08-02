@tool
extends ItemList

var drag_index:int = -1
var item_under_mouse:int = -1

################################################################################
## Drag and Drop
################################################################################

func _drop_data(at_position, data):
	item_under_mouse = get_item_at_position(at_position)
	
	if data.has("drag_item_index"):
		move_item(data["drag_item_index"], item_under_mouse)


func _can_drop_data(at_position, data):
	item_under_mouse = get_item_at_position(at_position)
	
	if data.has("drag_item_index") and data["drag_item_index"] != item_under_mouse:
		return true
	else:
		return false
	

func _get_drag_data(at_position):
	var item_index = get_item_at_position(at_position)
	var title = get_item_text(item_index)
	drag_index = item_index
	
	return {
		"drag_item_index":item_index
	}
	
