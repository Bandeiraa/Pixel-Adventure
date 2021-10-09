extends Interactable

func on_body_entered(body: Object) -> void:
	if body.is_in_group("Player") and can_interact:
		can_interact = false
		set_deferred("monitorable", false)
		body.get_node("Stats").update_health(damage, self.global_position)
		timer.set_wait_time(invulnerability_time)
		timer.start()
		
		
func on_timer_timeout() -> void:
	monitorable = true
	can_interact = true
