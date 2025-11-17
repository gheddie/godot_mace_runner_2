extends Node3D

@onready var initialTrail: BaseMaceElement = $InitialTrail

@onready var ship: Ship = $Ship

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialTrail.rotationDegrees = 0.0
	# ship.rotation_degrees.y += 180.0
