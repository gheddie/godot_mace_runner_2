class_name ForkMaceElement

extends BaseMaceElement

@onready var dockLeft: MeshInstance3D = $fork/Fork/DockLeft
@onready var dockRight: MeshInstance3D = $fork/Fork/DockRight

@onready var spawner: MeshInstance3D = $fork/Fork/Spawner

var enemyInstance: PackedScene = preload("res://assets/enemy/enemy.tscn")	

func _ready() -> void:
	# spawnEnemy()
	pass
	
func spawnEnemy() -> void:
	var enemy: Enemy = enemyInstance.instantiate()
	enemy.global_position = spawner.global_position
	get_tree().get_current_scene().add_child(enemy)
	
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
