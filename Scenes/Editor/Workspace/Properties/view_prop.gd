extends PropBase


# Nodes:
onready var _zoom_edit := $VLayout/ZoomEdit/SpinBox
var camera : DisplayCamera


# Called when the node enters the scene tree for the first time.
func _ready():
	_zoom_edit.set_script(StrictSpinBox)
	yield(self, "node_recieved") # Ensures that screen is loaded first before running code below
	# warning-ignore:RETURN_VALUE_DISCARDED
	camera.connect("zooming", self, "_on_Camera_zooming")
	_zoom_edit.set_value(camera.zoom.x * 100)
	_zoom_edit.step = camera.zoom_rate * 100
	_zoom_edit.min_value = _zoom_edit.step


func _on_Zoom_value_changed(value):
	camera.zoom.x = value * 0.01
	camera.zoom.y = value * 0.01


func _on_Camera_zooming(value):
	_zoom_edit.set_value(value.x * 100) # Using width (x) but height (y) also applies. 
