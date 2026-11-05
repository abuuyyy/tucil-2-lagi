class_name Hitbox extends Area2D

const breakable = [
	Vector2i(4, 2), #Carrot
	Vector2i(6, 2) #Wheat
]

@onready var player = get_parent()

func execute_overlap_check() -> void:
	var overlap = get_overlapping_bodies()
	for body in overlap:
		if body is TileMapLayer:
			var tilemap: TileMapLayer = body
			var impact: Vector2 = player.global_position
			var map_coords: Vector2i = tilemap.local_to_map(tilemap.to_local(impact))
			var atlas: Vector2i = tilemap.get_cell_atlas_coords(map_coords)
			
			if atlas in breakable:
				tilemap.set_cell(map_coords, -1)
