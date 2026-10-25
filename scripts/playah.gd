class_name Player extends CharacterBody2D

const walk = 100.0
const sprint = 150.0
var cardinal_dir: Vector2 = Vector2.RIGHT
var is_attack: bool = false
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var swing: AudioStreamPlayer2D = $swing

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
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Action1") and not is_attack:
		attack()
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
