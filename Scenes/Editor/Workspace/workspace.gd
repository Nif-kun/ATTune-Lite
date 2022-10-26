extends HBoxContainer


# Note:
# 	I'd like to properly explain that the code structure does not fully follow
#	the common up-down data transfer. Instead, it gets the Display's object ref.
#	Afterwards, it is sent to an autoload named NodeBridge.
#	Any node needing the Display node must grab it directly from the NodeBridge.
#	However, they must first yield until the display_loaded signal is emitted.
#	I chose this to avoid the tedious repeat of up-down transfer.
#	Any value change are immediately applied to the taget node.
#
# Warning: 
#	Due to this structure, it requires nodes to yield until Display nodes are loaded.


# Nodes:
onready var _display := $Display
onready var _properties := $Properties


# Called when the node enters the scene tree for the first time.
func _ready():
	_properties.load_requirements(_display)
