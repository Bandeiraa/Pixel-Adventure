extends Interactable

export(int) var platform_gravity

func on_body_entered(body: Object) -> void:
	if body.is_in_group("Player") and can_interact:
		animation.play("Off")
		can_interact = false
		
		
func _physics_process(_delta: float) -> void:
	if not can_interact:
		translate(Vector2(0, 1) * platform_gravity)
		
		
func on_screen_exited() -> void:
	queue_free()
