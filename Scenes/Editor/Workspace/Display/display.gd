extends PanelContainer
class_name Display


# Nodes:
onready var viewbox := $ViewBox
onready var viewport := $ViewBox/Viewport
onready var camera := $ViewBox/Viewport/Camera2D
onready var screen := $ViewBox/Viewport/Screen


# Called when the node enters the scene tree for the first time.
func _ready():
	viewport.size = viewbox.rect_size #this container should've fixed the sizing but Godot is retarded at times.
	camera.position = viewbox.rect_size / 2
	screen.rect_position = (viewbox.rect_size / 2 ) - (screen.rect_size / 2)
