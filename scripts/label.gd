class_name collect extends Label

@export var count_label: Label
@onready var maxmes: Label = $"../max"
@onready var timer: Timer = $"../Timer"

func _ready() -> void:
	maxmes.hide()
	SignalBus.item_collected.connect(_on_item_collected)

func _on_item_collected(amount: int) -> void:
	if count_label:
		count_label.text = str(SignalBus.total_items)
