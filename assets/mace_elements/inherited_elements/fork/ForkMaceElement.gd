class_name ForkMaceElement

extends BaseMaceElement

@onready var dockLeft: MeshInstance3D = $fork/Fork/DockLeft
@onready var dockRight: MeshInstance3D = $fork/Fork/DockRight

func getExpansion() -> int:
	return 2

func getInstanceId() -> String:
	return str("Fork@", str(get_instance_id()))
	
func getDockPositionLeft() -> Vector3:
	return dockLeft.global_position

func getDockPositionRight() -> Vector3:
	return dockRight.global_position
	
func onBodyEntered(body: Node3D) -> void:
	if body is Ship:
		print(str("entered --> ", str(body)))
		onShipEntered()

func extend(extendedElement: BaseMaceElement) -> void:
	# left
	var leftTrail = MaceElementFactoryInstance.buildTrailElement()
	leftTrail.acceptPosition(getDockPositionLeft())
	var rotationLeft = extendedElement.rotationDegrees + 30.0
	leftTrail.rotateY(rotationLeft)
	leftTrail.rotationDegrees = rotationLeft
	get_tree().get_current_scene().add_child(leftTrail)
	# right
	var rightTrail = MaceElementFactoryInstance.buildTrailElement()
	rightTrail.acceptPosition(getDockPositionRight())
	var rotationRight = extendedElement.rotationDegrees - 30.0
	rightTrail.rotateY(rotationRight)
	rightTrail.rotationDegrees = rotationRight
	get_tree().get_current_scene().add_child(rightTrail)
