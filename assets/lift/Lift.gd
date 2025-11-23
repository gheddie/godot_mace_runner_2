class_name Lift

extends Node3D

@onready var platform: LiftPlatform = $LiftPlatform

@onready var upperStop: Area3D = $UpperEntry
@onready var lowerStop: Area3D = $LowerEntry

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	platform.move(_delta)
	var diffUpper = upperStop.global_position.y - platform.global_position.y
	var diffLower = platform.global_position.y - lowerStop.global_position.y
	# print(str("to upper: "), str(diffUpper), ", ", str("to lower: "), str(diffLower))
	
	if platform.rising and diffUpper <= 0:
		platform.rising = false
		
	if !platform.rising and diffLower <= 0:
		platform.rising = true
