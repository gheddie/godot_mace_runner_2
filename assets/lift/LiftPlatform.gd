class_name LiftPlatform

extends StaticBody3D

var rising: bool

@onready var trailSpawner: MeshInstance3D = $lift_platform/TrailSpawner

const SPEED: int = 1.0

func _ready() -> void:
	rising = true

func _process(delta: float) -> void:
	pass

func move(_delta: float) -> void:
	if rising:
		global_position.y += SPEED * _delta
	else:
		global_position.y -= SPEED * _delta
