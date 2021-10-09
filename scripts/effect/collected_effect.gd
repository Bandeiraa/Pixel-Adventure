extends AnimatedSprite

func _ready() -> void:
	play("Effect")
	
	
func on_animation_finished() -> void:
	queue_free()
