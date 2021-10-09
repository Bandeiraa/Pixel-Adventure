extends RigidBody2D

const FRUIT_LIST = [
	preload("res://assets/fruit/apple.png"), 
	preload("res://assets/fruit/banana.png"),
	preload("res://assets/fruit/cherry.png"),
	preload("res://assets/fruit/kiwi.png"),
	preload("res://assets/fruit/melon.png"),
	preload("res://assets/fruit/orange.png"),
	preload("res://assets/fruit/pineapple.png"),
	preload("res://assets/fruit/strawberry.png")
]

const COLLECTED_EFFECT = preload("res://scenes/effect/collected_effect.tscn")

export(bool) var gravity_on
export(bool) var can_kill

var fruit_value: int

onready var sprite: Sprite = get_node("Texture")

func _ready() -> void:
	randomize()
	sleeping = !gravity_on
	fruit_value = random_fruit_value()
	select_random_fruit()
	if can_kill:
		lifetime_timer()
	
	
func random_fruit_value() -> int:
	return randi() % 5 + 1
	
	
func select_random_fruit() -> void:
	var random_fruit: int = randi() % FRUIT_LIST.size()
	sprite.texture = FRUIT_LIST[random_fruit]
	
	
func can_apply_impulse() -> void:
	randomize()
	apply_impulse(Vector2.ZERO, Vector2(rand_range(-60, 60), rand_range(-150, -90)))
	
	
func on_body_entered(body: Object) -> void:
	if body.is_in_group("Player"):
		body.increase_score(fruit_value)
		instance_effect()
		
		
func instance_effect() -> void:
	var effect: Object = COLLECTED_EFFECT.instance()
	get_tree().root.call_deferred("add_child", effect)
	effect.global_position = global_position
	queue_free()
	
	
func lifetime_timer() -> void:
	var lifetime: Timer = Timer.new()
	add_child(lifetime)
	lifetime.set_autostart(true)
	lifetime.set_wait_time(5.0)
	lifetime.start()
	var _connect = lifetime.connect("timeout", self, "instance_effect")
