extends VBoxContainer

# Signals
signal open_file_pressed(object, filter)
signal file_size_warning

# Nodes:
onready var ViewProp := $ScrollBox/VLayout/ViewProp
onready var ScreenProp := $ScrollBox/VLayout/ScreenProp
onready var BackgroundProp := $ScrollBox/VLayout/BackgroundProp
onready var AtlasProp := $ScrollBox/VLayout/AtlasProp
onready var WidgetProp := $ScrollBox/VLayout/WidgetProp
onready var ScrollBox := $ScrollBox


func _ready():
	ScrollBox.scroll_vertical = 0


func load_requirements(viewer : Viewer):
	ViewProp.camera = viewer.camera
	ViewProp.emit_signal("node_recieved")
	ScreenProp.screen = viewer.screen
	ScreenProp.viewbox = viewer.viewbox
	ScreenProp.emit_signal("node_recieved")
	BackgroundProp.DisplayNode = viewer.display
	BackgroundProp.emit_signal("node_recieved")
	AtlasProp.DisplayNode = viewer.display
	AtlasProp.emit_signal("node_recieved")


func _on_open_file_pressed(object, filter):
	emit_signal("open_file_pressed", object, filter)


func _on_file_size_warning():
	emit_signal("file_size_warning")
