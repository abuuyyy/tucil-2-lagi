extends Node

signal item_collected(amount: int)

var total_items = 0

func _ready() -> void:
	item_collected.connect(_on_item_collected)

func _on_item_collected(amount: int) -> void:
	total_items += amount
 
