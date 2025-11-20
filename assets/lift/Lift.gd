class_name Lift

extends Node3D

@onready var platform: LiftPlatform = $LiftPlatform

@onready var upperStop: Area3D = $LiftPlatform/UpperEntry
@onready var lowerStop: Area3D = $LiftPlatform/LowerEntry

func _ready() -> void:
	pass # Replace with function body.

func _process(_delta: float) -> void:

	if platform.rising and platform.global_position.y < 10.0:
		pass
		
	if !platform.rising and platform.global_position.y < 10.0:
		pass
	
	platform.movePlatform(_delta)
	
	var diffUpper = platform.global_position.y - upperStop.global_position.y
	var diffLower = platform.global_position.y - lowerStop.global_position.y
	
	# print(str("to upper: "), str(diffUpper), ", ", str("to lower: "), str(diffLower))
