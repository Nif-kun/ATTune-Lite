extends VBoxContainer

# Signals
signal open_file_pressed(object, filter)

# Nodes:
onready var view_prop := $ScrollBox/VLayout/ViewProp
onready var screen_prop := $ScrollBox/VLayout/ScreenProp
onready var background_prop := $ScrollBox/VLayout/BackgroundProp
onready var atlas_prop := $ScrollBox/VLayout/AtlasProp
onready var widget_prop := $ScrollBox/VLayout/WidgetProp
onready var scroll_box := $ScrollBox


func _ready():
	scroll_box.scroll_vertical = 0


func load_requirements(viewer : Viewer):
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
