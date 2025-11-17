class_name Door

extends StaticBody3D

@onready var animator: AnimationPlayer = $door/AnimationPlayer

func close() -> void:
	animator.play_backwards("WingAction")	
	
func open() -> void:
	animator.play("WingAction")
