extends PropBase

# Signals:
signal open_file_pressed(object, filter)

# Nodes:
onready var _texture_edit := $VLayout/GridContainer/TextureEdit/LineEdit
onready var _hframe_edit := $VLayout/GridContainer/HFrameEdit
onready var _vframe_edit := $VLayout/GridContainer/VFrameEdit
onready var _start_frame_edit := $VLayout/GridContainer/StartFrameEdit
onready var _end_frame_edit := $VLayout/GridContainer/EndFrameEdit
onready var _speed_edit := $VLayout/GridContainer/SpeedEdit
onready var _loop_check := $VLayout/GridContainer/LoopCheck
onready var _play_button := $VLayout/PlayButton
#var atlas_player # AtlasPlayer type; Unable to set due to Godot inconsistency with set_custom_type()
var display : Display

# Private var:
export var _texture_file_filter := ["*.png, *.jpg, *.jpeg, *.svg ; Supported Images", "*.jpg ; JPG Images", "*.jpeg ; JPEG Images", "*.png ; PNG Images", "*.svg ; SVG Images"]


# Called when the node enters the scene tree for the first time.
func _ready():
	ShortLib.set_script_all([_hframe_edit, _vframe_edit, _start_frame_edit, _end_frame_edit, _speed_edit], StrictSpinBox)
	_start_frame_edit.max_value = (_hframe_edit.value * _vframe_edit.value)
	_end_frame_edit.max_value = (_hframe_edit.value * _vframe_edit.value)
	yield(self, "node_recieved") # Ensures that screen is loaded first before running code below
	_setup_atlas_player()
	# warning-ignore:RETURN_VALUE_DISCARDED
	display.connect_atlas_player("stopped", self, "_on_AtlasPlayer_stopped")


func _setup_atlas_player():
	display.set_atlas_texture(ShortLib.load_texture(_texture_edit.text))
	display.set_hframe(_hframe_edit.value)
	display.set_vframe(_vframe_edit.value)
	display.set_start_frame(_start_frame_edit.value)
	display.set_end_frame(_end_frame_edit.value)
	display.set_speed(_speed_edit.value)
	display.set_loop(_loop_check.pressed)


func set_data(data:Dictionary):
	_texture_edit.text = data["texture"]
	_hframe_edit.value = data["hframe"]
	_vframe_edit.value = data["vframe"]
	_start_frame_edit.value = data["start_frame"]
	_end_frame_edit.value = data["end_frame"]
	_speed_edit.value = data["speed"]
	_loop_check.pressed = data["loop"]
	_setup_atlas_player() 


func get_data():
	return {
		"texture":_texture_edit.text,
		"hframe":_hframe_edit.value,
		"vframe":_vframe_edit.value,
		"start_frame":_start_frame_edit.value,
		"end_frame":_end_frame_edit.value,
		"speed":_speed_edit.value,
		"loop":_loop_check.pressed
	}


func _on_TextureEdit_text_changed(text):
	var texture = ShortLib.load_texture(text)
	if texture != null:
		display.set_atlas_texture(texture)
		_play_button.disabled = false
	else:
		display.set_atlas_texture(null)
		_play_button.disabled = true


func _on_open_file_pressed():
	_play_button.pressed = false
	emit_signal("open_file_pressed", self, _texture_file_filter)


func set_selected_file(path):
	_texture_edit.text = path
	_texture_edit.emit_signal("text_changed", path)


func _on_HFrameEdit_value_changed(value):
	display.set_hframe(value)
	_start_frame_edit.max_value = (_hframe_edit.value * _vframe_edit.value)
	_end_frame_edit.max_value = (_hframe_edit.value * _vframe_edit.value)


func _on_VFrameEdit_value_changed(value):
	display.set_vframe(value)
	_start_frame_edit.max_value = (_hframe_edit.value * _vframe_edit.value)
	_end_frame_edit.max_value = (_hframe_edit.value * _vframe_edit.value)


func _on_StartFrameEdit_value_changed(value):
	display.set_start_frame(value)
	_end_frame_edit.min_value = value


func _on_EndFrameEdit_value_changed(value):
	display.set_end_frame(value)


func _on_SpeedEdit_value_changed(value):
	display.set_speed(value)


func _on_LoopCheck_toggled(button_pressed):
	_play_button.pressed = false
	display.set_loop(button_pressed)


func _on_PlayButton_toggled(button_pressed):
	if button_pressed:
		_play_button.text = "Stop"
		display.start()
	else:
		_play_button.text = "Start"
		display.stop()


func _on_AtlasPlayer_stopped():
	_play_button.pressed = false
