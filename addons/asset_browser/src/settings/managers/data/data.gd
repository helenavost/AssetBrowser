@tool
class_name AssetBrowserDataManager extends AssetBrowser

static var root_page:ABPSettingsPage
static var current_page:ABPSettingsPage

func set_val(k, v):
	if current_page != null:
		current_page.set_val(k,v)
		save()

func save():
	if root_page != null:
		ResourceSaver.save(root_page, "res://addons/asset_browser/cache/main_data.tres")

func get_val(k):
	if current_page != null:
		return current_page.get_val(k)
