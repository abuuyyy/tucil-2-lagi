class_name Hitbox extends Area2D

const CARROT = preload("res://scenes/carrot_item.tscn")
const WHEAT = preload("res://scenes/wheat_item.tscn")

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
			var impact: Vector2 = global_position
			var map_coords: Vector2i = tilemap.local_to_map(tilemap.to_local(impact))
			var atlas: Vector2i = tilemap.get_cell_atlas_coords(map_coords)
			
			if atlas in breakable:
				var tilemap_pos: Vector2 = tilemap.to_global(tilemap.map_to_local(map_coords))
				if atlas == Vector2i(4, 2):
					spawn_carrot(tilemap_pos)
				elif  atlas == Vector2i(6, 2):
					spawn_wheat(tilemap_pos)
				tilemap.set_cell(map_coords, -1)

func spawn_carrot(spawn_pos: Vector2):
	var new_carrot = CARROT.instantiate() as Area2D
	new_carrot.global_position = spawn_pos
	get_tree().current_scene.add_child(new_carrot)

func spawn_wheat(spawn_pos: Vector2):
	var new_wheat = WHEAT.instantiate() as Area2D
	new_wheat.global_position = spawn_pos
	get_tree().current_scene.add_child(new_wheat)
	
