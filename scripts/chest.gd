class_name chest extends Area2D

@export var depo: Label

var keep: int = 0

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		deposit_items()

func deposit_items() -> void:
	if SignalBus.total_items > 0:
		keep += SignalBus.total_items
		SignalBus.total_items = 0
		SignalBus.item_collected.emit(0)
		_update_text()

func _update_text() -> void:
	if depo:
		depo.text = str(keep)
