class_name Chest extends Area2D

var player = Player.new()
@onready var body: CollisionShape2D = $body

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(yeah: Node2D) -> void:
	if yeah is Player:
		_chest_collect(yeah)
		
func _chest_collect(_player: Node2D) -> void:
	queue_free()
