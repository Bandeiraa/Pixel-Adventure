extends Node2D

onready var camera: Camera2D = get_node("Camera")
onready var phase_timer: Timer = get_node("Timer")
onready var checkpoint: Area2D = get_node("Checkpoint")
onready var start: Area2D = get_node("Start")
onready var interface: CanvasLayer = get_node("Interface")

const PLAYER = preload("res://scenes/player/mask_dude.tscn")

export(int) var time_to_complete

export(String) var previous_level = ""
export(String) var next_level = ""

export(Vector2) var player_start_position = Vector2(20, 112.115)

onready var level_name: String = self.name.to_lower()
onready var max_fall_height: float = get_node("MaxFallHeight").position.y

var player_ref: Object = null
var can_reload: bool = true

func _ready() -> void:
	camera.move_to_spawn()
	connect_signals()
	
	
func connect_signals() -> void:
	var _start = start.connect("start", self, "start_countdown")
	var _camera = camera.connect("spawn_player", self, "spawn_player")
	var _timer = phase_timer.connect("timeout", self, "on_timer_timeout")
	
	
func spawn_player() -> void:
	var player: Object = PLAYER.instance()
	add_child(player)
	player.global_position = player_start_position
	player_ref = player
	
	
func start_countdown() -> void:
	phase_timer.set_wait_time(time_to_complete)
	phase_timer.start()
	interface.start_timer(time_to_complete)
	level_ref()
	
	
func level_ref() -> void:
	interface.previous = previous_level
	interface.current = level_name
	interface.next = next_level
	interface.check_button([previous_level, next_level])
	
	
func on_timer_timeout() -> void:
	fade(player_ref.global_position, "")
	
	
func fade(camera_position: Vector2, type: String) -> void:
	camera.set_current(camera_position)
	interface.stop_timer()
	can_reload = false
	if type == "Next_Level":
		save_data()
		InterfaceSingleton.fade(next_level)
		return
		
	InterfaceSingleton.fade(level_name)
	
	
func save_data() -> void:
	SaveFile.data_dictionary.level_list[level_name] = true
	SaveFile.save_data()
	
	
func _process(_delta: float) -> void:
	if player_ref != null and can_reload:
		if player_ref.position.y > max_fall_height:
			fade(player_ref.global_position, "")
			can_reload = false
