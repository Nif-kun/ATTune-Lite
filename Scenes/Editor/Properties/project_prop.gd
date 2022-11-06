extends PropBase

# Signals
signal open_file_pressed(object, filter)

# Nodes
onready var IconTexture := $VLaout/Flex/Icon/Texture
onready var ProjectName := $VLaout/Flex/ProjectName
onready var Author := $VLaout/Flex/Author

# Private 
var _default_icon : Texture
var _icon_path := ""
var _project_name := ""
var _author := ""


# Called when the node enters the scene tree for the first time.
func _ready():
	if _default_icon == null:
		_default_icon = IconTexture.texture


func set_data(data:Dictionary):
	if _default_icon == null:
		_default_icon = IconTexture.texture
	_icon_path = data["icon_path"]
	var icon = ShortLib.load_texture(data["icon_path"])
	if icon != null:
		IconTexture.modulate = Color.white
		IconTexture.texture = icon
	_project_name = data["project_name"]
	ProjectName.text = data["project_name"]
	_author = data["author"]
	Author.text = Author.prefix+" "+data["author"]+" "+Author.suffix


func get_data() -> Dictionary:
	return {
		"project_name":_project_name,
		"author":_author,
		"icon_path":_icon_path
	}


func _on_Icon_pressed():
	emit_signal("open_file_pressed", self, _texture_file_filter)


func set_selected_file(path):
	var icon = ShortLib.load_texture(path)
	var file_size = ShortLib.get_file_size(path)
	if file_size > 3000000: # 3MB
		emit_signal("file_size_warning")
	if icon != null:
		IconTexture.modulate = Color.white
		IconTexture.texture = icon


func _on_ProjectName_text_changed(new_text):
	_project_name = new_text


func _on_Author_text_changed(new_text):
	_author = new_text
