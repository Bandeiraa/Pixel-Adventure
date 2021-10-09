extends Interactable

export(int) var jump_impulse

func on_body_entered(body: Object) -> void:
	if body.is_in_group("Player") and can_interact:
		can_interact = false
		animation.play("Jump")
		body.velocity.y = jump_impulse
		timer.set_wait_time(invulnerability_time)
		timer.start()
		
		
func on_timer_timeout() -> void:
	can_interact = true


func on_animation_finished(anim_name) -> void:
	if anim_name == "Jump":
		animation.play("Idle")
