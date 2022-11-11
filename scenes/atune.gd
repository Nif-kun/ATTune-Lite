extends PanelContainer

# Scenes
export var editor_scene  = preload("res://scenes/editor/Editor.tscn")
export var editor_web_scene = preload("res://scenes/editor/EditorWeb.tscn")

# Public
enum Export { DEFAULT = 0, WEB = 1, MOBILE = 2 }
export(Export) var export_type = Export.DEFAULT


# Called when the node enters the scene tree for the first time.
func _ready():
	match export_type:
		Export.DEFAULT:
			add_child(editor_scene.instance())
		Export.WEB:
			add_child(editor_web_scene.instance())
