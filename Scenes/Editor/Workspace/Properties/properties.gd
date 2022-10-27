extends ScrollContainer


# Nodes:
onready var view_prop := $VLayout/ViewProp
onready var screen_prop := $VLayout/ScreenProp
onready var background_prop := $VLayout/BackgroundProp
onready var sprite_prop := $VLayout/SpriteProp
onready var widget_prop := $VLayout/WidgetProp


func load_requirements(display : Display):
	scroll_vertical = 0
	view_prop.camera = display.camera
	view_prop.emit_signal("node_recieved")
	screen_prop.screen = display.screen
	screen_prop.viewbox = display.viewbox
	screen_prop.emit_signal("node_recieved")
	background_prop.color_bg = display.screen.color_bg
	background_prop.texture_bg = display.screen.texture_bg
	background_prop.emit_signal("node_recieved")
	sprite_prop.sprite_player = display.screen.sprite_player
	sprite_prop.emit_signal("node_recieved")
