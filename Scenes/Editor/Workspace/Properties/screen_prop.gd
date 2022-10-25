extends PanelContainer

# Note:
# label for size should be checked on a match case and apply value accordingly, something something lmao


# Nodes:
onready var size_preset := $VLayout/VLayout/SizePreset
onready var width_edit := $VLayout/VLayout/SizeEdit/WidthEdit
onready var height_edit := $VLayout/VLayout/SizeEdit/HeightEdit
var screen : Screen


# Private var:
enum SizePreset {
	CUSTOM = 0,
	
}
const custom_label := "Custom"
var width_buffer := 0
var height_buffer := 0


# Called when the node enters the scene tree for the first time.
func _ready():
	yield(NodeBridge, "display_loaded") # Ensures that screen is loaded first before running code below
	screen = NodeBridge.display.screen
	width_edit.set_min(screen.rect_min_size.x)
	height_edit.set_min(screen.rect_min_size.y)
	width_edit.set_value(screen.rect_size.x)
	height_edit.set_value(screen.rect_size.y)


func _on_WidthEdit_value_changed(value):
	screen.rect_size.x = value
	screen.rect_position.x = (NodeBridge.display.viewbox.rect_size.x / 2) - (value / 2)
	width_buffer = screen.rect_size.x
	size_preset.text = custom_label+" "+"("+str(width_buffer)+" x "+str(height_buffer)+")"


func _on_HeightEdit_value_changed(value):
	screen.rect_size.y = value
	screen.rect_position.y = (NodeBridge.display.viewbox.rect_size.y / 2) - (value / 2)
	height_buffer = screen.rect_size.y
	size_preset.text = custom_label+" "+"("+str(width_buffer)+" x "+str(height_buffer)+")"
