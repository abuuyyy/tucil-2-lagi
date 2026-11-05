extends Node

signal item_collected(amount: int)

var total_items = 0
const max_keep: int = 20

func _ready() -> void:
	item_collected.connect(_on_item_collected)

func _on_item_collected(amount: int) -> void:
	if total_items < max_keep:
		total_items += amount
 
