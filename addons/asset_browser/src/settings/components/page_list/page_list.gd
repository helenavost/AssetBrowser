@tool
extends AssetBrowserComponent

@export var key:String
@export_file var template_file

var settings_list:ABPSettingsList
var selected_index:int = -1

func _ready():
	load_item_list()
	connect_button_events()
	connect_list_events()
	fill_list()

func load_item_list():
	var s = data_manager.get_val(key)
	
	if s is ABPSettingsList:
		settings_list = s
	else:
		settings_list = ABPSettingsList.new()
		data_manager.set_val(key, settings_list)

func fill_list():
	for single_key in settings_list.order_list:
		if settings_list.resource_lib.has(single_key):
			var index = $ListItems.add_item(single_key)
			$ListItems.set_item_metadata(index, settings_list.resource_lib[single_key])

################################################################################
## Add / Edit / Remove
################################################################################

func connect_button_events():
	$Ctrls/Add.pressed.connect(add_was_pressed)
	$Ctrls/Edit.pressed.connect(edit_was_pressed)
	$Ctrls/Remove.pressed.connect(remove_was_pressed)
	
func add_was_pressed():
	var index = $ListItems.add_item($Ctrls/TitleEnter.text)
	var new_page_settings = ABPSettingsPage.new()
	
	$ListItems.set_item_metadata(index, new_page_settings)
	settings_list.set_res($Ctrls/TitleEnter.text, new_page_settings)
	
	update_list_order()
	data_manager.save()
	
	$Ctrls/TitleEnter.text = ""
	
func edit_was_pressed():
	#var k = $ListItems.get_item_text(selected_index)
	var p = $ListItems.get_item_metadata(selected_index)
	
	if p is ABPSettingsPage:
		pages_manager.open_page(template_file, p)

func remove_was_pressed():
	var title = $ListItems.get_item_text(selected_index)
	settings_list.remove_res(title)
	update_list_order()

func update_list_order():
	settings_list.clear_order()
	
	for single in range(0, $ListItems.item_count):
		settings_list.append_new($ListItems.get_item_text(single))
		
################################################################################
## List
################################################################################

func connect_list_events():
	$ListItems.item_activated.connect(item_was_activated)
	$ListItems.item_selected.connect(item_was_selected)

func item_was_activated(i:int):
	selected_index = i
	edit_was_pressed()
	
func item_was_selected(i:int):
	selected_index = i
