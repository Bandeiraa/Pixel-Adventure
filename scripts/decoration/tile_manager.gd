extends TileMap

func _ready() -> void:
	var random_tile: int = random_tile()
	for tile in get_used_cells():
		set_cell(tile.x, tile.y, random_tile)
		
	update_bitmask_region() 
		
		
func random_tile() -> int:
	randomize()
	return randi() % 7
