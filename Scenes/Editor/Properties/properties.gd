extends ScrollContainer

# Signals
signal open_file_pressed(object, filter)

# Nodes:
onready var view_prop := $VLayout/ViewProp
onready var screen_prop := $VLayout/ScreenProp
onready var background_prop := $VLayout/BackgroundProp
onready var atlas_prop := $VLayout/AtlasProp
onready var widget_prop := $VLayout/WidgetProp


func load_requirements(viewer : Viewer):
	scroll_vertical = 0
	view_prop.camera = viewer.camera
	view_prop.emit_signal("node_recieved")
	screen_prop.screen = viewer.screen
	screen_prop.viewbox = viewer.viewbox
	screen_prop.emit_signal("node_recieved")
	background_prop.display = viewer.display
	background_prop.emit_signal("node_recieved")
	atlas_prop.display = viewer.display
	atlas_prop.emit_signal("node_recieved")


func _on_open_file_pressed(object, filter):
	emit_signal("open_file_pressed", object, filter)
