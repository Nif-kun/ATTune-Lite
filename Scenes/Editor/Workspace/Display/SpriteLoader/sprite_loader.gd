extends Control
class_name SpritePlayer


#Nodes
onready var _sprite := $Sprite


# Called when the node enters the scene tree for the first time.
func _ready():
	_sprite.position = rect_size / 2 #center at start.
	# warning-ignore:RETURN_VALUE_DISCARDED
	connect("resized", self, "_resized")


func _resized():
	if _sprite != null:
		_sprite.position = rect_size / 2 #keep centered
