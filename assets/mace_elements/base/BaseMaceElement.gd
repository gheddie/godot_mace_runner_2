@abstract class_name BaseMaceElement

extends StaticBody3D

var hasExtended: bool = false

var rotationDegrees: float

func removeFromScene() -> void:
	queue_free()

@abstract func getInstanceId() -> String

func acceptPosition(pos: Vector3) -> void:
	global_position = pos
	
func calculateSuccessorPosition(predecessor: BaseMaceElement) -> Vector3:
	var predecessorPosition: Vector3 = predecessor.global_position
	return Vector3(predecessorPosition.x + 10.0, predecessorPosition.y, predecessorPosition.z)

func rotateY(degrees: float) -> void:
	rotation_degrees.y += degrees
	
func onShipEntered() -> void:
	if !hasExtended:
		extend(self)
		hasExtended = true

@abstract func extend(extendedElement: BaseMaceElement) -> void

func getRandom() -> bool:
	return randi() % 2 == 0
