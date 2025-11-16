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

func extend() -> void:
	pass
