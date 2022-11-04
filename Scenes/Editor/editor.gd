extends PanelContainer


# Next objective:
# Save it as json then zip it with images. If a better option exist, that'll be nice
# When opening, 


# Nodes:
onready var _viewer := $Docker/Viewer
onready var _properties := $Docker/Properties
onready var _open_file_dialog := $NativeDialogOpenFile
onready var _ui_lock := $UILock

# Private var:
export var _editor_version := "1.0"
export var _min_window_size := Vector2(545,393)
var _data_buffer := {}
var _event_object
var _last_focused


# Called when the node enters the scene tree for the first time.
func _ready():
	OS.min_window_size = _min_window_size
	_properties.load_requirements(_viewer)


func save_project():
	var data = {
		"editor_ver":_editor_version,
		"project_name":"",
		"background":{},
		"sprite":{}
		}
	data["project_name"] = "tester" # not yet implemented
	data["background"] = _properties.background_prop.get_data()
	data["sprite"] = _properties.atlas_prop.get_data()
	_data_buffer = data
	print(data)


# Note: make a func that checks the dictionary for missing key and add them with default val.
func load_project():
	_properties.background_prop.set_data(_data_buffer["background"])
	_properties.atlas_prop.set_data(_data_buffer["sprite"])


func _on_MenuBar_save_pressed():
	save_project()


func _on_MenuBar_open_file_pressed():
	_open_file_dialog.show()
	_ui_lock.visible = true


func _on_Properties_open_file_pressed(object, filter):
	_event_object = object
	_open_file_dialog.title = "Select an Image File"
	_open_file_dialog.filters = filter
	_ui_lock.visible = true
	_last_focused = get_focus_owner()
	_ui_lock.grab_focus()
	_open_file_dialog.show()


func _on_NativeDialogOpenFile_files_selected(files):
	_ui_lock.visible = false
	if _last_focused != null:
		_last_focused.grab_focus()
		_last_focused = null
	# Checks if object event came from Properties tab.
	if _event_object is PropBase and _event_object.has_method("set_selected_file"):
		if !files.empty():
			_event_object.set_selected_file(files[0])
	_event_object = null


func _on_MenuBar_new_file_pressed():
	load_project()
