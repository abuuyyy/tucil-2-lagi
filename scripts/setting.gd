extends Button

@onready var vol = $"../../volslide"

func _process(delta: float) -> void:
	vol.visible = false

func _on_pressed() -> void:
	get_tree().paused = true
	vol.visible = true
