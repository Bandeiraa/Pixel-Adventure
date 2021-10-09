extends GridContainer

func _ready() -> void:
	SaveFile.load_data()
	load_info()
	for button in get_children():
		button.connect("pressed", self, "on_button_pressed", [button.name])
		
		
func load_info() -> void:
	for key in SaveFile.data_dictionary.level_list.keys():
		if SaveFile.data_dictionary.level_list[key] == true:
			get_node(key).disabled = false
			
			
func on_button_pressed(target_button: String) -> void:
	InterfaceSingleton.fade(target_button.to_lower())
