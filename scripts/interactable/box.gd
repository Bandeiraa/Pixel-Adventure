extends Interactable

const SLICE = preload("res://scenes/interactable/box/slice.tscn")
const FRUIT = preload("res://scenes/interactable/fruit_controller.tscn")

export(int) var health
export(int) var max_fruit_amount
export(Array, String) var texture_list
export(Vector2) var offset

func _ready() -> void:
	timer.set_wait_time(invulnerability_time)
	
	
func on_body_entered(body: Object) -> void:
	if can_interact:
		update_health(body.object_damage)
		timer.start()
		can_interact = false
		
		
func update_health(damage: int) -> void:
	health -= damage
	animation.play("Hit")
	animation.queue("Idle")
	if health <= 0:
		spawn_fruit()
		spawn_slice()
		
		
func spawn_fruit() -> void:
	randomize()
	var random_fruit_amount: int = randi() % max_fruit_amount + 1
	for fruit in random_fruit_amount:
		var fruit_to_instance: Object = FRUIT.instance()
		get_tree().root.call_deferred("add_child", fruit_to_instance)
		fruit_to_instance.gravity_on = true
		fruit_to_instance.can_kill = true
		fruit_to_instance.can_apply_impulse()
		fruit_to_instance.global_position = global_position + offset
		
		
func spawn_slice() -> void:
	for texture in texture_list:
		var slice_to_spawn: Object = SLICE.instance()
		get_tree().root.call_deferred("add_child", slice_to_spawn)
		slice_to_spawn.get_node("Texture").texture = load(texture)
		slice_to_spawn.global_position = global_position
		
	queue_free()
	
	
func on_timer_timeout() -> void:
	can_interact = true
