extends StaticBody2D

onready var chain: TextureRect = get_node("Chain")
onready var interactable: Area2D = chain.get_node("Interactable")

export(int, 8, 120, 8) var chain_length

var offset: int = 14

func _ready() -> void:
	chain.rect_size = Vector2(chain_length, 8)
	interactable.position = Vector2(chain_length + offset, 4)
