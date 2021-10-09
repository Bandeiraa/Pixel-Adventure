extends CanvasLayer

onready var wait_time: Label = get_node("WaitTime")
onready var interface_buttons: HBoxContainer = get_node("InterfaceButtons")

var countdown: float 
var can_compute_time: bool = false

onready var parent: Object = get_parent()

var current: String = ""
var previous: String = ""
var next: String = ""

func _ready() -> void:
	connect_signals()
	if OS.get_name() == "Android":
			get_node("MobileButtons").show()
			
			
func connect_signals() -> void:
	for button in interface_buttons.get_children():
		button.connect("pressed", self, "on_button_pressed", [button.name])
		
		
func _process(delta: float) -> void:
	if can_compute_time:
		compute_time(delta)
		
		
func compute_time(delta: float) -> void:
	countdown -= delta
	var minutes = "%02d" % [countdown/60]
	var seconds = "%02d" % [int(ceil(countdown)) % 60]
	if seconds == "00":
		minutes = "0" + str(int(minutes) + 1)
		
	wait_time.text = minutes + ":" + seconds
		
		
func start_timer(total_time) -> void:
	can_compute_time = true
	wait_time.visible = true
	countdown = total_time
	
	
func check_button(level_list: Array) -> void:
	var button_list: Array = ["Previous", "Next"]
	for index in level_list.size():
		if level_list[index] == "":
			interface_buttons.get_node(button_list[index]).disabled = true
		else:
			interface_buttons.get_node(button_list[index]).disabled = false
			
	interface_buttons.show()
	
	
func on_button_pressed(button_type: String) -> void:
	match button_type:
		"Restart":
			change_scene(current)
				
		"Previous":
			change_scene(previous)
			
		"Next":
			change_scene(next)
				
				
func change_scene(scene: String) -> void:
	SaveFile.load_data()
	if scene == next and SaveFile.data_dictionary.level_list[current] != true:
		return
		
	stop_timer()
	InterfaceSingleton.fade(scene)
	
	
func stop_timer() -> void:
	parent.phase_timer.stop()
	interface_buttons.hide()
	can_compute_time = false
	wait_time.visible = false
