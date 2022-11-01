extends PropBase

# Signals:
signal open_file_pressed(object, filter)

# Nodes:
onready var _color_edit := $VLayout/BGEdit/ColorEdit
onready var _texture_edit := $VLayout/BGEdit/TextureEdit/LineEdit
var color_bg : ColorRect
var texture_bg : TextureRect

# Private var:
export var _texture_file_filter := ["*.png, *.jpg, *.jpeg, *.svg ; Supported Images", "*.jpg ; JPG Images", "*.jpeg ; JPEG Images", "*.png ; PNG Images", "*.svg ; SVG Images"]


# Called when the node enters the scene tree for the first time.
func _ready():
	yield(self, "node_recieved") # Ensures that screen is loaded first before running code below
	color_bg.color = _color_edit.color 
	texture_bg.texture = ShortLib.load_texture(_texture_edit.text)


func set_data(data:Dictionary):
	_color_edit.color = data["color"]
	color_bg.color = data["color"]
	_texture_edit.text = data["texture"]
	texture_bg.texture = ShortLib.load_texture(data["texture"])


func get_data() -> Dictionary:
	return {
		"color":_color_edit.color,
		"texture":_texture_edit.text
	}


func _on_ColorEdit_color_changed(color):
	color_bg.color = color


func _on_TextureEdit_text_changed(text):
	texture_bg.texture = ShortLib.load_texture(text)


func _on_open_file_pressed():
	emit_signal("open_file_pressed", self, _texture_file_filter)


func set_selected_file(path):
	_texture_edit.text = path
	_texture_edit.emit_signal("text_changed", path)
