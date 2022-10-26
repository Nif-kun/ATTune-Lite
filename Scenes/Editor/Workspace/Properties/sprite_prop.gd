extends PropBase


# Nodes:
onready var _texture_edit := $VLayout/GridContainer/TextureEdit/LineEdit
onready var _hframe_edit := $VLayout/GridContainer/HFrameEdit
onready var _vframe_edit := $VLayout/GridContainer/VFrameLabel
onready var _start_frame_edit := $VLayout/GridContainer/StartFrameEdit
onready var _end_frame_edit := $VLayout/GridContainer/EndFrameEdit
onready var _speed_edit := $VLayout/GridContainer/SpeedEdit
var sprite_player : SpritePlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	yield(self, "node_recieved") # Ensures that screen is loaded first before running code below
	_texture_edit.text = sprite_player.get_texture().resource_pat # reverse: editor > screen
#	_hframe_edit.value = sprite_player


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
