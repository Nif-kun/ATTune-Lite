extends PanelContainer

signal open_file_pressed
signal export_file_pressed
signal save_pressed


#Nodes
onready var new_file_dialog := $CanvasLayer/PopupNewFile


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_File_item_pressed(id):
	match id:
		0: _new_file_pressed()
		1: emit_signal("open_file_pressed")
		2: emit_signal("export_file_pressed")
		3: emit_signal("save_pressed")


func _new_file_pressed():
	new_file_dialog.popup_centered_minsize(Vector2(100,50))
