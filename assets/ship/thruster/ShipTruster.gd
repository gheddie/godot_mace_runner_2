class_name ShipThruster

extends StaticBody3D

@onready var animator: AnimationPlayer = $SpaceshipThruster/AnimationPlayer

func _ready() -> void:
	animator.get_animation("FanHolderAction").loop_mode = Animation.LOOP_PINGPONG
	animator.play("FanHolderAction")
