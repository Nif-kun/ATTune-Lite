extends PanelContainer


# Nodes:
var camera : DisplayCamera
var screen : Screen
var color_bg : ColorRect
var texture_bg : TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	yield(NodeBridge, "display_loaded") # Ensures that screen is loaded first before running code below
	camera = NodeBridge.display.camera
	screen = NodeBridge.display.screen
	color_bg = screen.color_bg
	texture_bg = screen.texture_bg
	print(color_bg)
	print(texture_bg)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
