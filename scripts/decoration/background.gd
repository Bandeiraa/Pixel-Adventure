extends ParallaxBackground

export(int) var layer_speed

const BACKGROUND_LIST = [
	preload("res://assets/background/blue.png"), 
	preload("res://assets/background/brown.png"),
	preload("res://assets/background/gray.png"),
	preload("res://assets/background/green.png"),
	preload("res://assets/background/pink.png"),
	preload("res://assets/background/purple.png"),
	preload("res://assets/background/yellow.png")
]

onready var parallax_layer: ParallaxLayer = get_node("Layer")
onready var image: TextureRect = get_node("Layer/Image")

func _ready() -> void:
	select_random_background()
	
	
func select_random_background() -> void:
	randomize()
	var random_tile: int = randi() % BACKGROUND_LIST.size()
	image.texture = BACKGROUND_LIST[random_tile]
	
	
func _process(delta: float) -> void:
	parallax_layer.motion_offset.y += delta * layer_speed
