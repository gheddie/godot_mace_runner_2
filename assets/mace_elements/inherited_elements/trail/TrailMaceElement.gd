class_name TrailMaceElement

extends BaseMaceElement

@onready var dock: MeshInstance3D = $trail/Fork/EndMarker

@onready var delimiter1: MeshInstance3D = $trail/Delimiter1
@onready var delimiter2: MeshInstance3D = $trail/Delimiter2
@onready var delimiter3: MeshInstance3D = $trail/Delimiter3
@onready var delimiter4: MeshInstance3D = $trail/Delimiter4

func getExpansion() -> int:
	return 4

func getInstanceId() -> String:
	return str("Trail@", str(get_instance_id()))

func getDockPosition() -> Vector3:
	return dock.global_position

func onBodyEntered(body: Node3D) -> void:
	if body is Ship:
		print(str("entered --> ", str(body)))
		flash()
		onShipEntered()

func onBodyExited(body: Node3D) -> void:
	if body is Ship:
		print(str("exited --> ", str(body)))
		flash()

func flash() -> void:
	# var c = delimiter1.mesh.surface_set_material()
	pass

func extend() -> void:
	print(str("extending trail element --> ", str(get_instance_id())))
	var createdSuccessor: BaseMaceElement
	if (getRandom()):
		createdSuccessor = MaceElementFactoryInstance.buildTrailElement()
	else:
		createdSuccessor = MaceElementFactoryInstance.buildForkElement()
	createdSuccessor.acceptPosition(getDockPosition())
	# createdFork.rotateY(30)
	get_tree().get_current_scene().add_child(createdSuccessor)
