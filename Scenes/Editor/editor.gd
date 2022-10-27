extends PanelContainer


# Nodes:
onready var _properties := $VBox/Workspace/Properties


# Private var:
export var _editor_version := "1.0"
var _buffer_data := {}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func save_project():
	var data = {
		"editor_ver":_editor_version,
		"project_name":"",
		"background":{},
		"sprite":{}
		}
	data["project_name"] = "tester" # not yet implemented
	data["background"] = _properties.background_prop.get_data()
	data["sprite"] = _properties.sprite_prop.get_data()
	_buffer_data = data
	print(data)


# Note: make a func that checks the dictionary for missing key and add them with default val.
func load_project():
	_properties.background_prop.set_data(_buffer_data["background"])
	_properties.sprite_prop.set_data(_buffer_data["sprite"])


func _on_MenuBar_save_pressed():
	save_project()


func _on_MenuBar_open_file_pressed():
	load_project()
