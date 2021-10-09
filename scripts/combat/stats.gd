extends Node

signal can_kill

var enemy_position: Vector2 = Vector2.ZERO
var can_die: bool = false

export(int) var health
export(bool) var on_hit = false

func update_health(value: int, interactable_position: Vector2) -> void:
	health -= value
	if health > 0 and can_die != true:
		on_hit = true
		enemy_position = interactable_position
	elif health <= 0 and can_die != true:
		emit_signal("can_kill", "Disappearing")
		can_die = true
