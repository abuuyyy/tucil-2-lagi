class_name Player extends CharacterBody2D
@onready var time = $"Camera2D/gameui/Timer/Timering"


const walk = 100.0
const sprint = 150.0
var cardinal_dir: Vector2 = Vector2.RIGHT
var is_attack: bool = false
var hitbox_offset: Vector2
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var swing: AudioStreamPlayer2D = $swing
@onready var hitbox: Area2D = $hitbox
@onready var objects: TileMapLayer = $"../objects"


func _ready() -> void:
	hitbox_offset = hitbox.position

#movement
func _process(_delta: float) -> void:
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	var shift = Input.get_action_strength("Shift")
	if direction != Vector2.ZERO:
		if shift:
			velocity = direction * sprint
			anim.speed_scale = 1.5
		else:
			velocity = direction * walk
			anim.speed_scale = 1.0
		cardinal_dir = direction
	else:
		velocity = Vector2.ZERO
	process_anim(cardinal_dir)
	update_hitbox()
	
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("Action1") and not is_attack:
		attack()
		hitbox.execute_overlap_check()
	if is_attack:
		velocity = Vector2.ZERO
		return
	move_and_slide()

#update animation
func animation(last: String, dir: Vector2) -> void:
	if dir.x != 0:
		anim.flip_h = dir.x < 0
		anim.play(last + "_side")
	elif dir.y < 0:
		anim.play(last + "_up")
	elif dir.y > 0:
		anim.play(last + "_down")

func process_anim(direction) -> void:
	if is_attack:
		return
	if velocity != Vector2.ZERO:
		animation("walk", direction)
	else:
		animation("idle", direction)

#attacking
func attack() -> void:
	is_attack = true
	swing.play()
	animation("attack", cardinal_dir)

func _on_animated_sprite_2d_animation_finished() -> void:
	if is_attack:
		is_attack = false
		
#hitbox position
func update_hitbox() -> void:
	var x := hitbox_offset.x
	var y := hitbox_offset.y
	
	match cardinal_dir:
		Vector2.LEFT:
			hitbox.position = Vector2(-x-46, y)
		Vector2.RIGHT:
			hitbox.position = Vector2(x-7, y)
		Vector2.UP:
			hitbox.position = Vector2(y-37, -x-40)
		Vector2.DOWN:
			hitbox.position = Vector2(-y-22, x)
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	if time.time_left == 0:
		if area.is_in_group("ogre"):
			get_tree().change_scene_to_file("res://scenes/loser.tscn")
