class_name DoorWing

extends StaticBody3D
 
@onready var animator: AnimationPlayer = $doorwing/AnimationPlayer

func open() -> void:
	animator.play("WingAction")

func close() -> void:
	animator.play_backwards("WingAction")
