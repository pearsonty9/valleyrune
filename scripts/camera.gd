extends Camera2D

@onready var tilemap: TileMap = get_node("/root/Game/TileMap")

func _ready():
	var tilemap_rect = tilemap.get_used_rect()
	var tilemap_cell_size = tilemap.tile_set.tile_size
	limit_left = tilemap.global_position.x + tilemap_rect.position.x * tilemap_cell_size.x
	limit_right = tilemap.global_position.x + tilemap_rect.end.x * tilemap_cell_size.x
	limit_top = tilemap.global_position.y + tilemap_rect.position.y * tilemap_cell_size.y
	limit_bottom = tilemap.global_position.y + tilemap_rect.end.y * tilemap_cell_size.y
	print(self.limit_left)
	print(self.limit_right)
	print(self.limit_top)
	print(self.limit_bottom)
