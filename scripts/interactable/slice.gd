extends RigidBody2D

var impulse: Vector2

func _ready() -> void:
	randomize()
	apply_impulse(Vector2.ZERO, Vector2(rand_range(-30, 30), rand_range(-60, -30)))


func on_screen_exited() -> void:
	queue_free()
