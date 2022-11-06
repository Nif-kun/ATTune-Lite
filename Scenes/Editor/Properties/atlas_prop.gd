extends PropBase

# Signals:
signal open_file_pressed(object, filter)

# Nodes:
onready var TextureEdit := $VLayout/Grid/TextureEdit/LineEdit
onready var HFrameEdit := $VLayout/Grid/HFrameEdit
onready var VFrameEdit := $VLayout/Grid/VFrameEdit
onready var StartFrameEdit := $VLayout/Grid/StartFrameEdit
onready var EndFrameEdit := $VLayout/Grid/EndFrameEdit
onready var SpeedEdit := $VLayout/Grid/SpeedEdit
onready var LoopCheck := $VLayout/Grid/LoopCheck
onready var PlayButton := $VLayout/PlayButton
#var atlas_player # AtlasPlayer type; Unable to set due to Godot inconsistency with set_custom_type()
var DisplayNode : Display


# Called when the node enters the scene tree for the first time.
func _ready():
	ShortLib.set_script_all([HFrameEdit, VFrameEdit, StartFrameEdit, EndFrameEdit, SpeedEdit], StrictSpinBox)
	StartFrameEdit.max_value = (HFrameEdit.value * VFrameEdit.value)
	EndFrameEdit.max_value = (HFrameEdit.value * VFrameEdit.value)
	yield(self, "node_recieved") # Ensures that screen is loaded first before running code below
	_setup_atlas_player()
	# warning-ignore:RETURN_VALUE_DISCARDED
	DisplayNode.connect_atlas_player("stopped", self, "_on_AtlasPlayer_stopped")


func _setup_atlas_player(emitted_ready:bool=false):
	DisplayNode.set_atlas_texture(ShortLib.load_texture(TextureEdit.text, emitted_ready))
	DisplayNode.set_hframe(HFrameEdit.value)
	DisplayNode.set_vframe(VFrameEdit.value)
	DisplayNode.set_start_frame(StartFrameEdit.value)
	DisplayNode.set_end_frame(EndFrameEdit.value)
	DisplayNode.set_speed(SpeedEdit.value)
	DisplayNode.set_loop(LoopCheck.pressed)


func set_data(data:Dictionary):
	TextureEdit.text = data["texture"]
	HFrameEdit.value = data["hframe"]
	VFrameEdit.value = data["vframe"]
	StartFrameEdit.value = data["start_frame"]
	EndFrameEdit.value = data["end_frame"]
	SpeedEdit.value = data["speed"]
	LoopCheck.pressed = data["loop"]
	_setup_atlas_player(true) 


func get_data():
	return {
		"texture":TextureEdit.text,
		"hframe":HFrameEdit.value,
		"vframe":VFrameEdit.value,
		"start_frame":StartFrameEdit.value,
		"end_frame":EndFrameEdit.value,
		"speed":SpeedEdit.value,
		"loop":LoopCheck.pressed
	}


func _on_TextureEdit_text_changed(text):
	var texture = ShortLib.load_texture(text)
	var file_size = ShortLib.get_file_size(text)
	if file_size > 3000000: # 3MB
		emit_signal("file_size_warning")
	if texture != null:
		DisplayNode.set_atlas_texture(texture)
		PlayButton.disabled = false
	else:
		DisplayNode.set_atlas_texture(null)
		PlayButton.disabled = true


func _on_open_file_pressed():
	PlayButton.pressed = false
	emit_signal("open_file_pressed", self, _texture_file_filter)


func set_selected_file(path):
	TextureEdit.text = path
	TextureEdit.emit_signal("text_changed", path)


func _on_HFrameEdit_value_changed(value):
	DisplayNode.set_hframe(value)
	StartFrameEdit.max_value = (HFrameEdit.value * VFrameEdit.value)
	EndFrameEdit.max_value = (HFrameEdit.value * VFrameEdit.value)


func _on_VFrameEdit_value_changed(value):
	DisplayNode.set_vframe(value)
	StartFrameEdit.max_value = (HFrameEdit.value * VFrameEdit.value)
	EndFrameEdit.max_value = (HFrameEdit.value * VFrameEdit.value)


func _on_StartFrameEdit_value_changed(value):
	DisplayNode.set_start_frame(value)
	EndFrameEdit.min_value = value


func _on_EndFrameEdit_value_changed(value):
	DisplayNode.set_end_frame(value)


func _on_SpeedEdit_value_changed(value):
	DisplayNode.set_speed(value)


func _on_LoopCheck_toggled(button_pressed):
	PlayButton.pressed = false
	DisplayNode.set_loop(button_pressed)


func _on_PlayButton_toggled(button_pressed):
	if button_pressed:
		PlayButton.text = "Stop"
		DisplayNode.start()
	else:
		PlayButton.text = "Start"
		DisplayNode.stop()


func _on_AtlasPlayer_stopped():
	PlayButton.pressed = false
