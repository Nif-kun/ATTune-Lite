extends Control
class_name SpritePlayer


#Nodes
onready var _sprite := $Sprite
onready var _timer := $Timer


#Private var:
var _frame_buffer := 0
var _loop := false
var _play := false
var _end_frame := 0


# Called when the node enters the scene tree for the first time.
func _ready():
	_sprite.position = rect_size / 2 #center at start.
	# warning-ignore:RETURN_VALUE_DISCARDED
	connect("resized", self, "_resized")


func _resized():
	if _sprite != null:
		_sprite.position = rect_size / 2 #keep centered


func set_texture(value):
	_sprite.texture = value


func get_texture() -> Texture:
	return _sprite.texture


func set_hframe(value):
	_sprite.hframes = value


func get_hframe() -> int:
	return _sprite.hframes


func set_vframe(value):
	_sprite.vframes = value


func get_vframe() -> int:
	return _sprite.vframes


func set_start_frame(value):
	_frame_buffer = value
	_sprite.frame = value


func get_start_frame() -> int:
	return _sprite.frame


func set_end_frame(value):
	_end_frame = value


func get_end_frame() -> int:
	return _end_frame


func set_speed(value):
	_timer.wait_time = value


func get_speed() -> float:
	return _timer.wait_time


func loop(value):
	_timer.one_shot = !value


func start():
	_timer.start()


func stop():
	_timer.stop()


func _on_Timer_timeout():
	_sprite.frame = _frame_buffer
	if _frame_buffer < _end_frame:
		_frame_buffer += 1
	else:
		_frame_buffer = _sprite.frame
