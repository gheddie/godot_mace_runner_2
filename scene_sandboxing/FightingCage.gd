extends Node3D

@onready var ship: Ship = $Ship

func _ready() -> void:
	PlayerAccessInstance.player = ship
