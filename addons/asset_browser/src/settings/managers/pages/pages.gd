@tool
class_name AssetBrowserPagesManager extends AssetBrowser

static var pages_container:Control
var opened_pages:Array = []

var current_node:Control

func register_page_container(c:Control):
	pages_container = c

func open_page(path, page_settings:ABPSettingsPage):
	clean_container()
	
	if current_node != null:
		current_node.queue_free()
		
	AssetBrowserDataManager.current_page = page_settings
	
	var m = load(path).instantiate()
	
	opened_pages.append({
		"path":path,
		"page":page_settings
	})
	
	current_node = m
	pages_container.add_child(m)
	

func go_back():
	clean_container()
	
	if current_node != null:
		current_node.queue_free()
	
	var b = opened_pages.pop_back()
	
	if b is Dictionary:
		AssetBrowserDataManager.current_page = b["page"]
		var m = load(b["path"]).instantiate()
		current_node = m
		pages_container.add_child(m)
	else:
		print("page manager error, b is not dictionry")

func clean_container():
	for single in pages_container.get_children():
		single.queue_free()
