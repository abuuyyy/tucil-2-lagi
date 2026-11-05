extends CharacterBody2D

const movement_speed = 9000.0

@export var Goal: Node = null
@onready var sprite = $Sprite2D
@onready var time = $"../playah/Camera2D/gameui/Timer/Timering"

func _ready() -> void:
		sprite.hide()


func _physics_process(delta: float) -> void:
	if time.time_left <= 0:
		sprite.show()
		$NavigationAgent2D.target_position = Goal.global_position
		if !$NavigationAgent2D.is_target_reached():
			var nav_point_direction = to_local($NavigationAgent2D.get_next_path_position()).normalized()
			velocity = nav_point_direction * movement_speed * delta
		move_and_slide()

func _on_timer_timeout() -> void:
	if $NavigationAgent2D.target_position != Goal.global_position:
		$NavigationAgent2D.target_position = Goal.global_position
	$PathfindingUpdateTimer.start()
