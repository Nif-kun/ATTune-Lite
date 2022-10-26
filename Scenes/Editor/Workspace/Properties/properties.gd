extends ScrollContainer


# Nodes:
onready var _view_prop := $VLayout/ViewProp
onready var _screen_prop := $VLayout/ScreenProp
onready var _background_prop := $VLayout/BackgroundProp
onready var _sprite_prop := $VLayout/SpriteProp
onready var _widget_prop := $VLayout/WidgetProp


func load_requirements(display : Display):
	_view_prop.camera = display.camera
	_view_prop.emit_signal("node_recieved")
	_screen_prop.screen = display.screen
	_screen_prop.viewbox = display.viewbox
	_screen_prop.emit_signal("node_recieved")
	_background_prop.color_bg = display.screen.color_bg
	_background_prop.texture_bg = display.screen.texture_bg
	_background_prop.emit_signal("node_recieved")
	_sprite_prop.sprite_player = display.screen.sprite_player
	_sprite_prop.emit_signal("node_recieved")
