extends Camera2D
class_name DisplayCamera

#Object var:
onready var zoom_camera = CameraZoom2D.new(self, "zoom_in", "zoom_out", false, 0.125)


func _input(event):
	zoom_camera.handle_input(event)
#	var state = zoom_camera.state()
#	if state == 1 or state == 2:
#		print(zoom)
