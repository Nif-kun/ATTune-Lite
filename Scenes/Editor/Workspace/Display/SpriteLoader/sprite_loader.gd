extends Control
class_name SpritePlayer


#Nodes
onready var _sprite := $Sprite
onready var _timer := $Timer


#Public var:
export var texture : Texture
export var h_frames := 0
export var v_frames := 0
export var start_frame := 0
export var end_frame := 0
export var speed := 1.0


#Private var:
var _frame_buffer


# Called when the node enters the scene tree for the first time.
func _ready():
	_sprite.position = rect_size / 2 #center at start.
	# warning-ignore:RETURN_VALUE_DISCARDED
	connect("resized", self, "_resized")
	_sprite.texture = texture
	_sprite.hframes = h_frames
	_sprite.vframes = v_frames
	_sprite.frame = start_frame
	_timer.wait_time = speed
	_timer.start()
	_frame_buffer = start_frame


func _resized():
	if _sprite != null:
		_sprite.position = rect_size / 2 #keep centered


func _on_Timer_timeout():
	_sprite.frame = _frame_buffer
	if _frame_buffer < end_frame:
		_frame_buffer += 1
	else:
		_frame_buffer = start_frame
