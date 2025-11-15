@abstract class_name BaseMaceElement

extends StaticBody3D

func _ready() -> void:
	pass # Replace with function body.

@abstract func getExpansion() -> int

func debugExpansion() -> void:
	print("my expansion is ", str(getExpansion()))

func removeFromScene() -> void:
	queue_free()

@abstract func getInstanceId() -> String

func acceptPosition(position: Vector3) -> void:
	global_position = position
	
func calculateSuccessorPosition(predecessor: BaseMaceElement) -> Vector3:
	var predecessorPosition: Vector3 = predecessor.global_position
	return Vector3(predecessorPosition.x + 10.0, predecessorPosition.y, predecessorPosition.z)
