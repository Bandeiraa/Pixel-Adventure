extends Control

onready var animation: AnimationPlayer = get_node("Animation")
onready var menu_container: HBoxContainer = get_node("MenuContainer")
onready var settings_container: HBoxContainer = get_node("SettingsContainer")
onready var vcontainer: VBoxContainer = get_node("LevelsContainer")
onready var levels_container: GridContainer = vcontainer.get_node("Grid")
onready var volume_button: TextureButton = settings_container.get_node("Volume")
onready var level_button: TextureButton = menu_container.get_node("Level")

var volume_status: bool = true
var normal_audio_volume: int = 0
var mute_audio_volume: int = -40

func _ready() -> void:
	var file: File = File.new()
	if file.file_exists(SaveFile.save_path):
		level_button.disabled = false
		
	for button in get_tree().get_nodes_in_group("Button"):
		button.connect("pressed", self, "on_button_pressed", [button.name])
		
		
func on_animation_finished(anim_name):
	if anim_name == "begin":
		animation.play("show_button")
		
		
func on_button_pressed(button_type: String) -> void:
	match button_type:
		"Play":
			InterfaceSingleton.fade("level1")
			
		"Volume":
			volume_status = !volume_status
			if volume_status:
				volume_button.texture_normal = load("res://assets/interface/button/volume/on.png")
				volume_button.texture_pressed = load("res://assets/interface/button/volume/on_pressed.png")
				Bgm.volume_db = normal_audio_volume
			else:
				volume_button.texture_normal = load("res://assets/interface/button/volume/off.png")
				volume_button.texture_pressed = load("res://assets/interface/button/volume/off_pressed.png")
				Bgm.volume_db = mute_audio_volume
				
		"Settings":
			menu_container.visible = !menu_container.visible
			settings_container.visible = !settings_container.visible
			
		"Level":
			vcontainer.visible = true
			menu_container.visible = !menu_container.visible
			
		"Back":
			menu_container.visible = !menu_container.visible
			vcontainer.visible = false
			settings_container.visible = false
			
		"Quit":
			get_tree().quit()
