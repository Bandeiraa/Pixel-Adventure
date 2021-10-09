extends Interactable

func on_body_entered(body: Object) -> void:
	if body.is_in_group("Player") and can_interact:
		body.fade_anim_name = "Disappearing"
		body.can_fade = true
		animation.play("Flag_Out")
		can_interact = false
