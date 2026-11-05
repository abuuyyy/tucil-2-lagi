class_name chest extends Area2D

@export var keep: Label

func _on_body_entered(body: Node2D) -> void:
	print("Player touched me!")
	if keep:
		keep.text = str(SignalBus.total_items)
