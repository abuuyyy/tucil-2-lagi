extends Node2D
@onready var timering = $Timering
@onready var timeringShown = $timeShown
@onready var decRed = $redMist/AnimationPlayer
@onready var redMist = $redMist/oneRed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		timering.start()



func time_left_before_agony():
	var timeLeft = timering.time_left
	var m = timeLeft / 60
	var s = int(timeLeft) % 60
	return [m, s]
	
	
func levels_of_agony():
	if timering.time_left < 11:
		redMist.show()
		decRed.play("decRed3")
	elif timering.time_left < 21:
		redMist.show()
		decRed.play("decRed2")
	elif timering.time_left < 31:
		redMist.show()
		decRed.play("decRed")
	else:
		redMist.hide()

		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timeringShown.text = "%2d:%02d" % time_left_before_agony()
	levels_of_agony()
