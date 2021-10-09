extends Camera2D

onready var tween: Tween = get_node("CameraTween")

export(int) var y_value

var can_move_camera: bool = false

func _process(_delta) -> void:
	if Input.is_action_just_pressed("ui_down") and can_move_camera:
		move_camera(y_value)
	elif Input.is_action_just_pressed("ui_up") and can_move_camera:
		move_camera(-y_value)
		
		
func move_camera(value: int) -> void:
	can_move_camera = false
	var _interpolate_to = tween.interpolate_property(self, "offset", Vector2(0, 0), Vector2(0, value), .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	var _interpolate_from = tween.interpolate_property(self, "offset", Vector2(0, value), Vector2(0, 0), .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 2.0)
	var _start_tween = tween.start()


func on_tween_finished() -> void:
	can_move_camera = true
