class_name ShortLib
# Description: shortcut library for certain functions to shorten code and avoid repetitions.


static func set_script_all(objects, script):
	for x in objects:
		x.set_script(script)


static func load_texture(path:String, warn:bool=true) -> Texture:
	if File.new().file_exists(path):
		var image := Image.new()
		var image_texture := ImageTexture.new()
		var err = image.load(path)
		if err:
			if warn: push_warning("ShortLib[WRN]: image could not be loaded, file is either not an image type, corrupted, or restricted. (Substituting return value with null.)")
			return null
		image_texture.create_from_image(image)
		return image_texture
	if warn: push_warning("ShortLib[WRN]: file does not exist! (Substituting return value with null.)")
	return null


static func get_file_size(path:String, warn:bool=true) -> int:
	var file := File.new()
	if file.file_exists(path):
		# warning-ignore:return_value_discarded
		file.open(path, File.READ)
		var size : int = file.get_len()
		file.close()
		return size
	if warn: push_warning("ShortLib[WRN]: file does not exist! (Substituting return value with -1.)")
	return -1


static func get_file_name(path:String, warn:bool=true) -> String:
	if File.new().file_exists(path):
		var index_x = path.find_last("/")
		var index_y = path.find_last("\\")
		if index_x > -1:
			return path.substr(index_x+1)
		elif index_y > -1:
			return path.substr(index_y+1)
	if warn: push_warning("ShortLib[WRN]: file does not exist! (Substituting return value with empty string.)")
	return ""


static func get_file_extension(fileName:String) -> String:
	var index = fileName.find_last(".")
	return fileName.substr(index)


static func get_dir_files(path:String, include_dir:bool=false, warn:bool=true) -> PoolStringArray:
	var file_names : PoolStringArray = []
	var dir = Directory.new()
	var open_err = dir.open(path)
	if open_err == OK:
		dir.list_dir_begin()
		var file = dir.get_next()
		while file != "":
			if !dir.current_is_dir():
				file_names.append(file)
			elif include_dir:
				file_names.append(file)
			file = dir.get_next()
	elif warn:
		push_warning("ShortLib[WRN]: an error occurred when trying to access the path. ERR_CODE: "+open_err)
	return file_names


static func invert_float(start:float, end:float, value:float) -> float:
	return (start + end) - value


static func invert_int(start:int, end:int, value:int) -> int:
	return (start + end) - value


static func get_greater(x, y) -> float:
	if x > y:
		return x
	return y
