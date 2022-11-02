class_name ShortLib
# Description: shortcut library for certain functions to shorten code and avoid repetitions.


static func set_script_all(objects, script):
	for x in objects:
		x.set_script(script)


static func load_texture(path) -> Texture:
	if File.new().file_exists(path):
		var image := Image.new()
		var image_texture := ImageTexture.new()
		var err = image.load(path)
		if err:
			push_warning("ShortLib[WRN]: image could not be loaded, file is either not an image type, corrupted, or restricted. (Substituting return value with null.)")
			return null
		image_texture.create_from_image(image)
		return image_texture
	push_warning("ShortLib[WRN]: file does not exist! (Substituting return value with null.)")
	return null


static func invert_float(start:float, end:float, value:float) -> float:
	return (start + end) - value


static func invert_int(start:int, end:int, value:int) -> int:
	return (start + end) - value


static func get_greater(x, y) -> float:
	if x > y:
		return x
	return y
