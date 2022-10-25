extends PanelContainer


# Note:
# > texture prop should have option to strch_mode


# Nodes:
onready var color_edit := $VLayout/BGEdit/ColorEdit
onready var texture_edit := $VLayout/BGEdit/TextureEdit/LineEdit
onready var file_dialog := $CanvasLayer/FileDialog
var color_bg : ColorRect
var texture_bg : TextureRect


# Private var:
var texture_file_filter := ["*.jpg ; JPG Images", "*.jpeg ; JPEG Images", "*.png ; PNG Images", "*.svg ; SVG Images"]


# Called when the node enters the scene tree for the first time.
func _ready():
	yield(NodeBridge, "display_loaded") # Ensures that screen is loaded first before running code below
	color_bg = NodeBridge.display.screen.color_bg
	texture_bg = NodeBridge.display.screen.texture_bg
	color_bg.color = color_edit.color 


func _on_ColorEdit_color_changed(color):
	color_bg.color = color


func _on_TextureEdit_text_changed(text):
	var file = File.new()
	if file.file_exists(text):
		var texture : Texture = load(text)
		texture_bg.texture = texture
	else:
		texture_bg.texture = null


func _on_TextureButton_pressed():
	file_dialog.popup_centered(OS.window_size / 2)
	file_dialog.set_filters(texture_file_filter)


func _on_FileDialog_file_selected(path):
	texture_edit.text = path
	texture_edit.emit_signal("text_changed", path)
