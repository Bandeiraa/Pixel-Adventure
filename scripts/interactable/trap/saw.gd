extends Interactable

onready var texture: Sprite = get_node("Texture")

export(int, -1, 1, 1) var direction

func _ready() -> void:
	verify_direction()
	
	
func verify_direction() -> void:
	if direction > 0:
		texture.flip_h = true
	elif direction < 0:
		texture.flip_h = false
		
		
func on_body_entered(body: Object) -> void:
	if body.is_in_group("Player") and can_interact:
		can_interact = false
		body.get_node("Stats").update_health(damage, self.global_position)
		animation.play("Off")
		timer.set_wait_time(invulnerability_time)
		timer.start()
		
		
func on_timer_timeout() -> void:
	can_interact = true
	animation.play("Idle")
