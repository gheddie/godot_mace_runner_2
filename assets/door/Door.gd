class_name Door

extends StaticBody3D

@onready var leftWing: DoorWing = $DoorwingLeft
@onready var rightWing: DoorWing = $DoorwingRight

func open() -> void:
	leftWing.open()
	rightWing.open()
