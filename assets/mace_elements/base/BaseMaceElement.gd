@abstract class_name BaseMaceElement

extends StaticBody3D

var hasExtended: bool = false

@abstract func getExpansion() -> int

func debugExpansion() -> void:
	print("my expansion is ", str(getExpansion()))

func removeFromScene() -> void:
	queue_free()

@abstract func getInstanceId() -> String

func acceptPosition(pos: Vector3) -> void:
	global_position = pos
	
func calculateSuccessorPosition(predecessor: BaseMaceElement) -> Vector3:
	var predecessorPosition: Vector3 = predecessor.global_position
	return Vector3(predecessorPosition.x + 10.0, predecessorPosition.y, predecessorPosition.z)

func rotateY(degrees: int) -> void:
	rotation_degrees.y += degrees
	
func onShipEntered() -> void:
	if !hasExtended:
		extend()
		hasExtended = true

@abstract func extend() -> void
