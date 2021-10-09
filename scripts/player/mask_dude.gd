extends KinematicBody2D
class_name Player

onready var raycast: RayCast2D = get_node("RayCast")
onready var texture: Sprite = get_node("Texture")
onready var stats: Node = get_node("Stats")
onready var animation: AnimationPlayer = get_node("Animation")
onready var camera: Camera2D = get_node("Camera")

export(int) var speed
export(int) var wall_speed
export(int) var knockback_strength

export(int) var gravity
export(int) var max_gravity_speed
export(int) var max_wall_gravity_speed
export(int) var jump_speed

export(int) var object_damage = 1

export(float) var stop_friction
export(float) var running_friction

var velocity: Vector2 = Vector2.ZERO

var fade_anim_name: String = "Appearing"

var can_fade: bool = true
var jump_count: int = 0
var score: int = 0

func _ready() -> void:
	set_physics_process(false)
	
	
func _physics_process(delta: float) -> void:
	move()
	jump()
	friction()
	knockback()
	animate()
	raycast.verify_direction(velocity.x) 
	if not stats.on_hit:
		texture.verify_direction(velocity.x) 
		
	velocity.y += gravity * delta #Gravidade Normal
	clamp_velocity()
	velocity = move_and_slide(velocity, Vector2.UP)
	
	
func move() -> void:
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= speed
		
		
func jump() -> void:
	if is_on_floor() or raycast.next_to_wall(): # Resetar Jump Count
		jump_count = 0
		
	if Input.is_action_just_pressed("ui_select") and jump_count < 2: # Pular
		jump_count += 1
		velocity.y = -jump_speed
		
		if raycast.next_to_wall() and not is_on_floor(): # Aplicar impulso em x se estiver próximo a uma parede
			wall_impulse()
			
			
func wall_impulse() -> void:
	if raycast.cast_to.x > 0:
		velocity.x -= wall_speed 
	elif raycast.cast_to.x < 0:
		velocity.x += wall_speed
		
		
func friction() -> void:
	var is_running: bool = Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")
	if not is_running and is_on_floor():
		velocity.x *= stop_friction
	else:
		velocity.x *= running_friction
		
		
func clamp_velocity() -> void:
	if velocity.y > max_gravity_speed: 
		velocity.y = max_gravity_speed #Limite da Gravidade Normal
	if raycast.next_to_wall() and velocity.y > max_wall_gravity_speed: 
		velocity.y = max_wall_gravity_speed #Limite da Gravidade na Parede
		
		
func knockback() -> void:
	if stats.on_hit:
		var direction = (global_position - stats.enemy_position).normalized()
		velocity.x = direction.x * knockback_strength
		
		
func animate() -> void:
	if stats.on_hit:
		hit_animation()
	elif can_fade:
		fade_animation(fade_anim_name)
	elif raycast.next_to_wall() and velocity.y != 0:
		wall_animation()
	elif velocity.y != 0 and not raycast.next_to_wall():
		jump_animation()
	else:
		move_animation()
		
		
func hit_animation() -> void:
	animation.play("Hit")
	
	
func wall_animation() -> void:
	if raycast.cast_to.x > 0:
		animation.play("Right_Wall_Slide")
	elif raycast.cast_to.x < 0:
		animation.play("Left_Wall_Slide")
		
		
func jump_animation() -> void:
	if velocity.y < 0:
		animation.play("Jump")
	elif velocity.y > 0:
		animation.play("Fall")
		
		
func move_animation() -> void:
	if abs(velocity.x) > 0.05:
		animation.play("Run")
	elif abs(velocity.x) < 0.05:
		animation.play("Idle")
		
		
func fade_animation(current_animation: String) -> void:
	animation.play(current_animation)
	
	
func current_camera() -> void:
	camera.current = true
	camera.can_move_camera = true
	
	
func increase_score(value: int) -> void:
	score += value
	
	
func on_animation_finished(anim_name: String) -> void:
	match anim_name:
		"Appearing":
			set_physics_process(true)
			current_camera()
			can_fade = false
			
		"Hit":
			velocity.x = 0
			
		"Disappearing":
			if stats.can_die:
				get_tree().call_group("Level", "fade", global_position, "")
				kill_player()
			else:
				get_tree().call_group("Level", "fade", global_position, "Next_Level")
				kill_player()
				
				
func can_kill(target_animation: String) -> void:
	fade_anim_name = target_animation
	can_fade = true
	
	
func kill_player() -> void:
	set_physics_process(false)
	queue_free()
