extends Path2D

onready var path: PathFollow2D = get_node("PathFollow")
onready var saw: Area2D = get_node("PathFollow/Saw")

export(int) var speed

var step: float = 0.0

func _process(delta: float) -> void:
	if saw.can_interact:
		step += delta
		path.offset = step * speed * saw.direction
