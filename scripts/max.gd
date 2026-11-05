extends Label

@onready var max: Label = $"."


func _ready() -> void:
	max.hide()

func _process(float) -> void:
	if max and SignalBus.total_items == SignalBus.max_keep:
		max.show()
	else:
		max.hide()
