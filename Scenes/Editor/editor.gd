extends PanelContainer


# Next objective:
# Save it as json then zip it with images. If a better option exist, that'll be nice
# When opening, 

# CS-objects
var zipper_script = load("res://Scripts/zipper.cs")
onready var Zipper = zipper_script.new()

# Nodes:
onready var ViewerNode := $Docker/Viewer
onready var Properties := $Docker/Properties
onready var OpenFileDialog := $NativeDialogOpenFile
onready var UILock := $UILock
onready var SizeWarning := $Notifs/Margin/HLayout/SizeWarning

# Private var:
export var _editor_version := "1.0"
export var _min_window_size := Vector2(545,393)
var _data_buffer := {}
var _event_object
var _last_focused


# Called when the node enters the scene tree for the first time.
func _ready():
	OS.min_window_size = _min_window_size
	Properties.load_requirements(ViewerNode)
	
#	Zipper.Zip("C:\\Users\\Nif\\Downloads\\TestCompress\\File", "C:\\Users\\Nif\\Downloads\\TestCompress", "Test.fvd")
#	Zipper.Unzip("C:\\Users\\Nif\\Downloads\\TestCompress\\Test.fvd", "C:\\Users\\Nif\\Downloads\\TestCompress\\Extracted")


func save_project():
	var data = {
		"editor_ver":_editor_version,
		"project_name":"",
		"author":"",
		"icon_path":"",
		"background":{},
		"sprite":{}
		}
	data["project_name"] = "tester" # not yet implemented
	data["background"] = Properties.background_prop.get_data()
	data["sprite"] = Properties.atlas_prop.get_data()
	_data_buffer = data # data buffer to be removed when json file path added to direct save
	print(data)


# Note: make a func that checks the dictionary for missing key and add them with default val.
func load_project():
	# data_buffer to be removed when json file path added to directly load from save file
	Properties.background_prop.set_data(_data_buffer["background"])
	Properties.atlas_prop.set_data(_data_buffer["sprite"])

# DEPRECATED USE AS REFERENCE
func _on_MenuBar_save_pressed():
	save_project()

# DEPRECATED USE AS REFERENCE
func _on_MenuBar_open_file_pressed():
	OpenFileDialog.show()
	UILock.visible = true


func _on_Properties_open_file_pressed(object, filter):
	_event_object = object
	OpenFileDialog.title = "Select an Image File"
	OpenFileDialog.filters = filter
	UILock.visible = true
	_last_focused = get_focus_owner()
	UILock.grab_focus()
	OpenFileDialog.show()


func _on_Properties_file_size_warning():
	SizeWarning.popup()


func _on_NativeDialogOpenFile_files_selected(files):
	UILock.visible = false
	if _last_focused != null:
		_last_focused.grab_focus()
		_last_focused = null
	# Checks if object event came from Properties tab.
	if _event_object is PropBase and _event_object.has_method("set_selected_file"):
		if !files.empty():
			_event_object.set_selected_file(files[0])
	_event_object = null

# DEPRECATED USE AS REFERENCE
func _on_MenuBar_new_file_pressed():
	load_project()



