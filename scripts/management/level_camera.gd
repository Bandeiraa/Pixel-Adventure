extends Camera2D

signal spawn_player

onready var tween: Tween = get_node("CameraTween")

func move_to_spawn() -> void:
	yield(get_tree().create_timer(1.5), "timeout")
	var _interpolate_to = tween.interpolate_property(self, "position", position, Vector2(20, 112.115), 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	var _start_tween = tween.start()
	
	
func on_tween_completed():
	emit_signal("spawn_player")


func set_current(camera_position: Vector2):
	global_position = camera_position
	current = true
