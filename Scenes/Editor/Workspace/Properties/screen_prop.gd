extends PanelContainer


# Nodes:
onready var width_edit := $VLayout/VLayout/SizeEdit/WidthEdit
onready var height_edit := $VLayout/VLayout/SizeEdit/HeightEdit
var screen : Screen


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


func _on_HeightEdit_value_changed(value):
	screen.rect_size.y = value
	screen.rect_position.y = (NodeBridge.display.viewbox.rect_size.y / 2) - (value / 2)
