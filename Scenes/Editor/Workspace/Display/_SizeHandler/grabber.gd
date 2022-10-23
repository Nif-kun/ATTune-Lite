extends ColorRect


signal pressed(is_pressed, id)


#Export var:
export var id := -1


# Private var:
var _is_pressed := false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _gui_input(event):
	if event.is_action("mouse_left"):
		_is_pressed = !_is_pressed
		emit_signal("pressed", _is_pressed, id)
