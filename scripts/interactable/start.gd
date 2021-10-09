extends Interactable

signal start

func on_body_entered(body: Object) -> void:
	if body.is_in_group("Player") and can_interact:
		animation.play("Start_Moving")
		emit_signal("start")
		can_interact = false
