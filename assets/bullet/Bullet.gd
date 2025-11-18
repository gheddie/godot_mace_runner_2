class_name Bullet

extends Node3D

const SPEED = 5000.0

func _process(delta: float) -> void:
	position += transform.basis * Vector3(0.0, 0.0, -SPEED) * delta
