extends Button

func _on_pressed() -> void:
	SignalBus.total_items = 0
	get_tree().change_scene_to_file("res://scenes/game_i_guess.tscn")
