class_name LiftPlatform

extends StaticBody3D

var rising: bool

const SPEED: int = 1.0

func _ready() -> void:
	rising = true

func _process(delta: float) -> void:
	pass

func movePlatform(_delta: float) -> void:
	if rising:
		global_position.y += SPEED * _delta
	else:
		global_position.y -= SPEED * _delta
