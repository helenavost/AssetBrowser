@tool
extends EditorPlugin

var settings_tab
var main_data:ABPSettingsPage


func _enter_tree():
	load_main_data()
	
	settings_tab = preload("./src/settings/root/root.tscn").instantiate()
	add_control_to_container(EditorPlugin.CONTAINER_PROJECT_SETTING_TAB_RIGHT, settings_tab)
	settings_tab.start()
	
func load_main_data():
	if ResourceLoader.exists("res://addons/asset_browser/cache/main_data.tres"):
		print("Load main data")
		main_data = ResourceLoader.load("res://addons/asset_browser/cache/main_data.tres")
	else:
		print("Main data not found, recreate and save!")
		main_data = ABPSettingsPage.new()
		main_data.mark = "loaded"
		ResourceSaver.save(main_data, "res://addons/asset_browser/cache/main_data.tres")
	
	AssetBrowserDataManager.root_page = main_data
	
func _exit_tree():
	remove_control_from_container(EditorPlugin.CONTAINER_PROJECT_SETTING_TAB_RIGHT, settings_tab)
	main_data = null
	AssetBrowserDataManager.current_page = null
	AssetBrowserDataManager.root_page = null
	
func _get_plugin_name():
	return "Asset browser"
