extends Area2D
class_name Interactable

onready var timer: Timer = get_node("Timer")
onready var animation: AnimationPlayer = get_node("Animation")

export(float) var invulnerability_time
export(bool) var can_interact
export(int) var damage

func on_body_entered(_body: Object) -> void:
	pass
	
	
func on_animation_finished(_anim_name: String):
	pass # Replace with function body.


func on_timer_timeout():
	pass # Replace with function body.
