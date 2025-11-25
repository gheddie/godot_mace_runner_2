class_name Lift

extends Node3D

@onready var platform: LiftPlatform = $LiftPlatform

@onready var upperStop: Area3D = $UpperEntry
@onready var lowerStop: Area3D = $LowerEntry

var parentFork: ForkMaceElement

var firstElevation: bool = false

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	platform.move(_delta)
	var diffUpper = upperStop.global_position.y - platform.global_position.y
	var diffLower = platform.global_position.y - lowerStop.global_position.y
	# print(str("to upper: "), str(diffUpper), ", ", str("to lower: "), str(diffLower))
	
	if platform.rising and diffUpper <= 0:
		if !firstElevation:
			extendByTrail()
			firstElevation = true
		platform.rising = false
		
	if !platform.rising and diffLower <= 0:
		platform.rising = true

func extendByTrail() -> void:
	var trail: TrailMaceElement = MaceElementFactoryInstance.buildTrailElement()
	trail.acceptPosition(platform.trailSpawner.global_position)
	var rotation = rotation_degrees.y + 90.0 + parentFork.rotationDegrees
	trail.rotateY(rotation)
	trail.rotationDegrees = rotation
	get_tree().get_current_scene().add_child(trail)
