@tool
extends AssetBrowserComponent

@export var key:String

var selected_index:int = -1

func _ready():
	if data_manager and pages_manager:
		connect_button_events()
		connect_list_events()
		fill_list()


func fill_list():
	var items = data_manager.get_val(key)
	
	if items is Array:
		for single_key in items:
			var index = $ListItems.add_item(single_key)

################################################################################
## Add / Edit / Remove
################################################################################

func connect_button_events():
	$Ctrls/Add.pressed.connect(add_was_pressed)
	$Ctrls/Remove.pressed.connect(remove_was_pressed)

func add_was_pressed():
	var type_to_add = $Ctrls/Types.text
	
	if check_for_repeat(type_to_add) == true:
		var index = $ListItems.add_item(type_to_add)
		update_data()

func remove_was_pressed():
	$ListItems.remove_item(selected_index)
	update_data()

func check_for_repeat(type_to_add):
	for single in range(0, $ListItems.item_count):
		if $ListItems.get_item_text(single) == type_to_add:
			return false
	
	return true

func update_data():
	var out = []
	
	for single in range(0, $ListItems.item_count):
		out.append($ListItems.get_item_text(single))
	
	data_manager.set_val(key, out)

################################################################################
## List
################################################################################

func connect_list_events():
	$ListItems.item_activated.connect(item_was_activated)
	$ListItems.item_selected.connect(item_was_selected)

func item_was_activated(i:int):
	selected_index = i
	
func item_was_selected(i:int):
	selected_index = i
