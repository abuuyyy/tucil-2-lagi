extends CanvasLayer

@onready var exit_button: Button = $HBoxContainer/exit_button
@onready var reset_button: Button = $HBoxContainer/reset_button
@onready var mute_button: Button = $HBoxContainer/mute_button
@onready var back_button: Button = $back

var master_bus_index: int

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()
	
	master_bus_index = AudioServer.get_bus_index("Master")
	
	exit_button.pressed.connect(_on_exit_pressed)
	reset_button.pressed.connect(_on_reset_pressed)
	mute_button.pressed.connect(_on_mute_pressed)
	
	if back_button:
		back_button.pressed.connect(_on_back_pressed)
		
	_update_mute_text()

func _on_exit_pressed() -> void:
	get_tree().paused = false
	get_tree().quit()

func _on_reset_pressed() -> void:
	get_tree().paused = false
	hide()
	get_tree().reload_current_scene()

func _on_mute_pressed() -> void:
	var is_muted = AudioServer.is_bus_mute(master_bus_index)
	AudioServer.set_bus_mute(master_bus_index, not is_muted)
	_update_mute_text()

func _on_back_pressed() -> void:
	get_tree().paused = false
	hide()

func _update_mute_text() -> void:
	if AudioServer.is_bus_mute(master_bus_index):
		mute_button.text = "unmute"
	else:
		mute_button.text = "mute"
