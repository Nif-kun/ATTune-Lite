extends Control
class_name SpritePlayer

signal started
signal stopped


#Nodes
onready var _sprite := $Sprite
onready var _timer := $Timer


#Private var:
var _frame_buffer := 0
var _loop := false
var _start_frame := 0
var _end_frame := 0
var _auto_scale := true
var _sprite_size_buffer := Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	_sprite.position = rect_size / 2 #center at start.
	# warning-ignore:RETURN_VALUE_DISCARDED
	connect("resized", self, "_resized")


func _resized():
	if _sprite != null:
		_sprite.position = rect_size / 2 #keep centered
	if _auto_scale:
		_resize_sprite()


func _resize_sprite():
	if get_texture() != null:
		print(_sprite_size_buffer)
		if _sprite_size_buffer.x > rect_size.x or _sprite_size_buffer.y > rect_size.y: # condition used later when auto and manual resize occurs
			if (_sprite_size_buffer.x - rect_size.x) > (_sprite_size_buffer.y - rect_size.y): # If width is bigger
				#apply rect_size.x (width) to sprite_size and wow var to height
				_sprite.scale.x = (rect_size.x / 100) * 0.1
				_sprite.scale.y = (((_sprite_size_buffer.y / _sprite_size_buffer.x) * rect_size.x) / 100 ) * 0.1
			else:
				_sprite.scale.y = (rect_size.y * 100) * 0.1
				_sprite.scale.x = (((_sprite_size_buffer.x / _sprite_size_buffer.y) * rect_size.y) / 100 ) * 0.1


func set_texture(value:Texture):
	_sprite.texture = value
	if value != null:
		_sprite_size_buffer.x = value.get_size().x / get_hframe()
		_sprite_size_buffer.y = value.get_size().y / get_vframe()


func get_texture() -> Texture:
	return _sprite.texture


func set_auto_scale(value):
	_auto_scale = value


func get_auto_scale() -> bool:
	return _auto_scale

 
func set_hframe(value):
	_sprite.hframes = value
	if get_texture() != null:
		_sprite_size_buffer.x = get_texture().get_size().x / value


func get_hframe() -> int:
	return _sprite.hframes


func set_vframe(value):
	_sprite.vframes = value
	if get_texture() != null:
		_sprite_size_buffer.y = get_texture().get_size().y / value


func get_vframe() -> int:
	return _sprite.vframes


func set_start_frame(value):
	_start_frame = value
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
	_loop = value


func start():
	if _sprite.texture != null and _end_frame > _start_frame:
		_timer.start()
		emit_signal("started")


func stop():
	_timer.stop()
	_sprite.frame = _start_frame
	_frame_buffer = _start_frame


func _on_Timer_timeout():
	if _end_frame > _start_frame:
		if _frame_buffer < (get_vframe() * get_hframe()):
			_sprite.frame = _frame_buffer
			if _frame_buffer < _end_frame:
				_frame_buffer += 1
			else:
				_frame_buffer = _start_frame
				if !_loop:
					_timer.stop()
					emit_signal("stopped")
		else:
			_frame_buffer = _start_frame
