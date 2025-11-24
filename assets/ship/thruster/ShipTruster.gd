class_name ShipThruster

extends StaticBody3D

@onready var animator: AnimationPlayer = $SpaceshipThruster/AnimationPlayer

@onready var animWatcher : AnimationWatcher = AnimationWatcher.new()

func _ready() -> void:
	"""
	animator.get_animation("FanHolderAction").loop_mode = Animation.LOOP_PINGPONG
	animator.play("FanHolderAction")
	"""
	animWatcher.registerAnimation(animator, "FanHolderAction")

func _process(delta: float) -> void:
	animWatcher.tick()
