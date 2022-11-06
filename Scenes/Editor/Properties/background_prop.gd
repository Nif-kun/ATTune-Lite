extends PropBase

# Signals:
signal open_file_pressed(object, filter)

# Nodes:
onready var ColorEdit := $VLayout/BGEdit/ColorEdit
onready var TextureEdit := $VLayout/BGEdit/TextureEdit/LineEdit
var DisplayNode : Display


# Called when the node enters the scene tree for the first time.
func _ready():
	yield(self, "node_recieved") # Ensures that screen is loaded first before running code below
	DisplayNode.set_bg_color(ColorEdit.color)
	DisplayNode.set_bg_texture(ShortLib.load_texture(TextureEdit.text, false))


func set_data(data:Dictionary):
	ColorEdit.color = data["color"]
	DisplayNode.set_bg_color(data["color"])
	TextureEdit.text = data["texture"]
	DisplayNode.set_bg_texture(ShortLib.load_texture(data["texture"]))


func get_data() -> Dictionary:
	return {
		"color":ColorEdit.color,
		"texture":TextureEdit.text
	}


func _on_ColorEdit_color_changed(color):
	DisplayNode.set_bg_color(color)


func _on_TextureEdit_text_changed(text):
	DisplayNode.set_bg_texture(ShortLib.load_texture(text))
	var file_size = ShortLib.get_file_size(text)
	if file_size > 3000000: # 3MB
		emit_signal("file_size_warning")


func _on_open_file_pressed():
	emit_signal("open_file_pressed", self, _texture_file_filter)


func set_selected_file(path):
	TextureEdit.text = path
	TextureEdit.emit_signal("text_changed", path)
