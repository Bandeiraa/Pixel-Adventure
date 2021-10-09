extends CanvasLayer

onready var animation: AnimationPlayer = get_node("Animation")

func fade(target_level: String) -> void:
	animation.play("Fade")
	yield(get_tree().create_timer(1.0), "timeout")
	var _change_scene = get_tree().change_scene("res://scenes/level/" + target_level + ".tscn")
