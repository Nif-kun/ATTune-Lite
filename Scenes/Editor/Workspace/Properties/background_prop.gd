extends PropBase


# Note:
# > texture prop should have option to strch_mode


# Nodes:
onready var _color_edit := $VLayout/BGEdit/ColorEdit
onready var _texture_edit := $VLayout/BGEdit/TextureEdit/LineEdit
onready var _file_dialog := $CanvasLayer/FileDialog
var color_bg : ColorRect
var texture_bg : TextureRect


# Private var:
var _texture_file_filter := ["*.jpg ; JPG Images", "*.jpeg ; JPEG Images", "*.png ; PNG Images", "*.svg ; SVG Images"]


# Called when the node enters the scene tree for the first time.
func _ready():
	_file_dialog.set_filters(_texture_file_filter)
	yield(self, "node_recieved") # Ensures that screen is loaded first before running code below
	color_bg.color = _color_edit.color 


func _on_ColorEdit_color_changed(color):
	color_bg.color = color


func _on_TextureEdit_text_changed(text):
	if File.new().file_exists(text):
		var texture : Texture = load(text)
		texture_bg.texture = texture
	else:
		texture_bg.texture = null


func _on_TextureButton_pressed():
	_file_dialog.popup_centered(OS.window_size / 2)


func _on_FileDialog_file_selected(path):
	_texture_edit.text = path
	_texture_edit.emit_signal("text_changed", path)
