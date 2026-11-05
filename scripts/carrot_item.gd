class_name Carrot extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D: 
		if SignalBus.total_items >= SignalBus.max_keep:
			return
		SignalBus.item_collected.emit(1)
		queue_free()
