class_name RessourcesRoomBottomPlate

extends StaticBody3D

@onready var grid: Node3D  = $Grid

func _ready() -> void:
	print(grid.transform.basis)
	pass
