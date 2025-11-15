@abstract class_name BaseMaceElement

extends StaticBody3D

func _ready() -> void:
	pass # Replace with function body.

@abstract func getExpansion() -> int

func debugExpansion() -> void:
	print("my expansion is ", str(getExpansion()))

func removeFromScene() -> void:
	queue_free()
