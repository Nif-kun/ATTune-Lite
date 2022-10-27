extends PropBase


# Nodes:
onready var _texture_edit := $VLayout/GridContainer/TextureEdit/LineEdit
onready var _hframe_edit := $VLayout/GridContainer/HFrameEdit
onready var _vframe_edit := $VLayout/GridContainer/VFrameEdit
onready var _start_frame_edit := $VLayout/GridContainer/StartFrameEdit
onready var _end_frame_edit := $VLayout/GridContainer/EndFrameEdit
onready var _speed_edit := $VLayout/GridContainer/SpeedEdit
onready var _file_dialog := $CanvasLayer/FileDialog
onready var _loop_check := $VLayout/GridContainer/LoopCheck
onready var _play_button := $VLayout/PlayButton
var sprite_player : SpritePlayer


# Private var:
var _texture_file_filter := ["*.jpg ; JPG Images", "*.jpeg ; JPEG Images", "*.png ; PNG Images", "*.svg ; SVG Images"]


# Called when the node enters the scene tree for the first time.
func _ready():
	ShortLib.set_script_all([_hframe_edit, _vframe_edit, _start_frame_edit, _end_frame_edit, _speed_edit], StrictSpinBox)
	_start_frame_edit.max_value = (_hframe_edit.value * _vframe_edit.value) - 1
	_end_frame_edit.max_value = (_hframe_edit.value * _vframe_edit.value) - 1
	_file_dialog.filters = _texture_file_filter
	yield(self, "node_recieved") # Ensures that screen is loaded first before running code below
	_setup_sprite_player()
	# warning-ignore:RETURN_VALUE_DISCARDED
	sprite_player.connect("stopped", self, "_on_SpritePlayer_stopped")


func _setup_sprite_player():
	sprite_player.set_texture(ShortLib.load_texture(_texture_edit.text))
	sprite_player.set_hframe(_hframe_edit.value)
	sprite_player.set_vframe(_vframe_edit.value)
	sprite_player.set_start_frame(_start_frame_edit.value)
	sprite_player.set_end_frame(_end_frame_edit.value)
	sprite_player.set_speed(_speed_edit.value)
	sprite_player.loop(_loop_check.pressed)


func set_data(data:Dictionary):
	_texture_edit.text = data["texture"]
	_hframe_edit.value = data["hframe"]
	_vframe_edit.value = data["vframe"]
	_start_frame_edit.value = data["start_frame"]
	_end_frame_edit.value = data["end_frame"]
	_speed_edit.value = data["speed"]
	_loop_check.pressed = data["loop"]
	_setup_sprite_player() 


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
#		var image : Image = texture.get_data()
#		image.resize(100,100)
#		print(image)
#		var ttx = ImageTexture.new()
#		ttx.create_from_image(image)
#		print(ttx)
		sprite_player.set_texture(texture)
		_play_button.disabled = false
	else:
		sprite_player.set_texture(null)
		_play_button.disabled = true


func _on_TextureButton_pressed():
	_play_button.pressed = false
	_file_dialog.popup_centered(OS.window_size / 2)


func _on_FileDialog_file_selected(path):
	_texture_edit.text = path
	_texture_edit.emit_signal("text_changed", path)


func _on_HFrameEdit_value_changed(value):
	sprite_player.set_hframe(value)
	_start_frame_edit.max_value = (_hframe_edit.value * _vframe_edit.value) - 1
	_end_frame_edit.max_value = (_hframe_edit.value * _vframe_edit.value) - 1


func _on_VFrameEdit_value_changed(value):
	sprite_player.set_vframe(value)
	_start_frame_edit.max_value = (_hframe_edit.value * _vframe_edit.value) - 1
	_end_frame_edit.max_value = (_hframe_edit.value * _vframe_edit.value) - 1


func _on_StartFrameEdit_value_changed(value):
	sprite_player.set_start_frame(value)
	_end_frame_edit.min_value = value


func _on_EndFrameEdit_value_changed(value):
	sprite_player.set_end_frame(value)


func _on_SpeedEdit_value_changed(value):
	sprite_player.set_speed(value)


func _on_LoopCheck_toggled(button_pressed):
	_play_button.pressed = false
	sprite_player.loop(button_pressed)


func _on_PlayButton_toggled(button_pressed):
	if button_pressed:
		_play_button.text = "Stop"
		sprite_player.start()
	else:
		_play_button.text = "Start"
		sprite_player.stop()


func _on_SpritePlayer_stopped():
	_play_button.pressed = false
