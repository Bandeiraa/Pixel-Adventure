extends Interactable

func on_body_entered(body: Object) -> void:
	if body.is_in_group("Player") and can_interact:
		body.get_node("Stats").update_health(damage, self.global_position)
		can_interact = false
		timer.set_wait_time(invulnerability_time)
		timer.start()


func on_timer_timeout() -> void:
	can_interact = true
