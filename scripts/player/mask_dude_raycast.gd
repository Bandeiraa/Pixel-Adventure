extends RayCast2D

func verify_direction(direction: int) -> void:
	if direction > 0:
		cast_to = Vector2(12, 0)
	elif direction < 0:
		cast_to = Vector2(-10, 0)
		
		
func next_to_wall() -> bool:
	return is_colliding()
