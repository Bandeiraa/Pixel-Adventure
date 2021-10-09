extends Sprite

func verify_direction(direction: int) -> void:
	if direction > 0:
		flip_h = false
	elif direction < 0:
		flip_h = true
