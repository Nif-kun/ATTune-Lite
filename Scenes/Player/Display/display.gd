extends PanelContainer
class_name Display

# Nodes
onready var _color_bg := $ColorBG
onready var _texture_bg := $TextureBG
onready var _atlas_player := $AtlasPlayer

# Exports
export var color_bg := Color.white setget set_bg_color, get_bg_color
export var texture_bg : Texture setget set_bg_texture, get_bg_texture
export var atlas_texture : Texture setget set_atlas_texture, get_atlas_texture
export var hframe := 1 setget set_hframe, get_hframe
export var vframe := 1 setget set_vframe, get_vframe
export var start_frame := 1 setget set_start_frame, get_start_frame
export var end_frame := 1 setget set_end_frame, get_end_frame
export var speed := 1.0 setget set_speed, get_speed
export var loop := true setget set_loop, get_loop
export var auto_start := false setget set_auto_start, get_auto_start


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# AtlasPlayer get
func connect_atlas_player(signal_string:String, object, method:String):
	_atlas_player.connect(signal_string, object, method)


# ColorBG setget
func set_bg_color(color:Color):
	_color_bg.color = color

func get_bg_color() -> Color:
	return _color_bg.color


# TextureBG setget
func set_bg_texture(texture:Texture):
	_texture_bg.texture = texture

func get_bg_texture() -> Texture:
	return _texture_bg.texture


# AtlasTexture setget
func set_atlas_texture(texture:Texture):
	_atlas_player.set_atlas_texture(texture)

func get_atlas_texture() -> Texture:
	return _atlas_player.get_atlas_texture()


# HFrame setget
func set_hframe(value:int):
	_atlas_player.set_hframe(value)

func get_hframe() -> int:
	return _atlas_player.get_hframe()


# VFrame setget
func set_vframe(value:int):
	_atlas_player.set_vframe(value)

func get_vframe():
	return _atlas_player.get_vframe()


# StartFrame setget
func set_start_frame(value:int):
	_atlas_player.set_start_frame(value)

func get_start_frame() -> int:
	return _atlas_player.get_start_frame()


# EndFrame setget
func set_end_frame(value:int):
	_atlas_player.set_end_frame(value)

func get_end_frame() -> int:
	return _atlas_player.get_end_frame()


# Speed setget
func set_speed(value:float):
	_atlas_player.set_speed(value)

func get_speed() -> float:
	return _atlas_player.get_speed()


# Loop setget
func set_loop(flag:bool):
	_atlas_player.set_loop(flag)

func get_loop() -> bool:
	return _atlas_player.get_loop()


# Autostart setget
func set_auto_start(flag:bool):
	_atlas_player.set_auto_start(flag)

func get_auto_start() -> bool:
	return _atlas_player.get_auto_start()

# AtlasPlayer start/stop
func start_atlas_player():
	_atlas_player.start()

func stop_atlas_player():
	_atlas_player.stop()
