extends Popup


#Todo:
#>return contents:
#->images
#->audio

#Nodes
onready var file_dialog := $FileDialog
onready var file_dialog_btn := $Container/VFrame/Path/TextureButton
onready var path_input := $Container/VFrame/Path/LineEdit
onready var name_input := $Container/VFrame/Name

#Private Vars
var _images := []
var _audio := []
var _confirm_flag := [false, false] #[0 = name | 1 = path]
var _path = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	# warning-ignore:return_value_discarded
	file_dialog_btn.connect("pressed", self, "_on_file_dialog_btn_pressed")
	# warning-ignore:return_value_discarded
	path_input.connect("text_changed", self, "_on_path_changed")
	# warning-ignore:return_value_discarded
	name_input.connect("text_changed", self, "_on_name_changed")


func file_dialog_reposition():
	file_dialog.rect_position = (OS.window_size / 2) - (file_dialog.rect_size / 2)


func _on_name_changed(text):
	var clear = false
	if !_path.empty() and !text.empty():
		if !Directory.new().file_exists(_path+"/"+text):
			print("Project does not exist!")
			print(_path+"/"+text)
			_confirm_flag[0] = true #name
			clear = true
	_confirm_flag[0] = clear
	print(_confirm_flag[0])


func _on_path_changed(text):
	_path = text
	var clear = false
	if !_path.empty():
		if !Directory.new().dir_exists(_path):
			print("Dir does not exist!")
			print(_path)
			_confirm_flag[1] = true #path
			clear = true
	_confirm_flag[1] = clear
	print(_confirm_flag[1])


func _on_file_dialog_btn_pressed():
	file_dialog.popup_centered_minsize(Vector2(500,500))


func _on_FileDialog_dir_selected(dir):
	path_input.text = dir
	path_input.emit_signal("text_changed", dir)


func _collect_resource():
	pass
#make a way to read conents in dir and grab them


func _on_Confirm_pressed():
	dir_contents(_path)
	pass # Replace with function body.


func dir_contents(path):
	#ToDo:
	#Tell the need to find an empty folder
	#>Resource folder:
	#->images
	#->audio
	#>Check if resource folder exists; If not, make, including sub folders
	#>>Else: check if sub-folder has needed folders, if not make.
	#>>>Else: check if sub-folder has content, if within defined type, collect.
	
	print(_path)
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print("Found file: " + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
