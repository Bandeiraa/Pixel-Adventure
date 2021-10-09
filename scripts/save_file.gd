extends Node

var save_path: String = "user://save.dat"

var data_dictionary: Dictionary = {
	level_list = {
		"level1": false,
		"level2": false,
		"level3": false,
		"level4": false,
		"level5": false,
		"level6": false,
		"level7": false,
		"level8": false,
		"level9": false,
		"level10": false
	}
}

func save_data() -> void:
	var file: File = File.new()
	var error = file.open(save_path, File.WRITE)
	if error == OK:
		file.store_var(data_dictionary)
		file.close()
		
		
func load_data() -> void:
	var file: File = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error == OK:
			data_dictionary = file.get_var()
			file.close()
