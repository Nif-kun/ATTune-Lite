extends GridContainer


# Private Nodes:
var _parent_node 

# Enums: 
enum ResizeState {
	NONE = 0
	WIDTH = 1
	HEIGHT = 2
	FULL = 3
}
enum ResizeSide {
	NONE = 0
	TOP_LEFT = 1
	TOP = 2
	TOP_RIGHT = 3
	LEFT = 4
	RIGHT = 5
	BOTTOM_LEFT = 6
	BOTTOM = 7
	BOTTOM_RIGHT = 8
}

# Private var:
var _is_pressed := false
var _mouse_pos_buffer := Vector2.ZERO
var _resize_state = ResizeState.NONE
var _resize_side = ResizeSide.NONE
var _rect_size_buffer := Vector2.ZERO

# Public var:
var max_rect_size := Vector2.ZERO setget set_max_rect_size, get_max_rect_size


# Called when the node enters the scene tree for the first time.
func _ready():
	_parent_node = get_parent()


# Setget for [max_rect_size]:
func set_max_rect_size(value):
	max_rect_size = value

func get_max_rect_size() -> Vector2:
	return max_rect_size


# Private setter for [resize_state]
func _set_resize_state(id):
	if id == 4 or id == 5:
		_resize_state = ResizeState.WIDTH
	elif id == 2 or id == 7:
		_resize_state = ResizeState.HEIGHT
	elif id != 0:
		_resize_state = ResizeState.FULL
	else:
		_resize_state = ResizeState.NONE


# Handles pressed signal from "grabber" nodes.
#Note: id must reflect the same format as ResizeSide enum.
func _on_grabber_pressed(pressed, id):
	if _parent_node != null:
		_rect_size_buffer = _parent_node.rect_size
		_is_pressed = pressed
		if pressed:
			_mouse_pos_buffer = _parent_node.get_local_mouse_position()
			_set_resize_state(id)
			_resize_side = id
		else:
			_resize_state = ResizeState.NONE


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if _is_pressed and _parent_node != null:
		match _resize_state:
			ResizeState.WIDTH:
				var new_width = _rect_size_buffer.x + (get_local_mouse_position().x - _mouse_pos_buffer.x)
				if _resize_side == ResizeSide.LEFT:
					_parent_node.rect_size.x = abs(_parent_node.get_global_mouse_position().x - _rect_size_buffer.x * 2)
#					_parent_node.rect_global_position.x = rect_size.x 
#					print("size ", abs(get_global_mouse_position().x - _rect_size_buffer.x * 2))
#					print("pos ", get_global_mouse_position().x)
				if _resize_side == ResizeSide.RIGHT:
					_parent_node.rect_size.x = _parent_node.get_local_mouse_position().x
			ResizeState.HEIGHT:
				var new_height = _rect_size_buffer.y + (get_local_mouse_position().y - _mouse_pos_buffer.y)
				if max_rect_size != Vector2.ZERO and max_rect_size.y > new_height:
					rect_size.y = new_height



