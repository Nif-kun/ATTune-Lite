extends Node # REQUIRED!
# Name: ShortLib
# Description: shortcut library for certain functions to shorten code and avoid repetitions.


func set_script_all(objects, script):
	for x in objects:
		x.set_script(script)
