class_name ForkMaceElement

extends BaseMaceElement

@onready var dockLeft: MeshInstance3D = $fork/Fork/DockLeft
@onready var dockRight: MeshInstance3D = $fork/Fork/DockRight

@onready var spawner: MeshInstance3D = $fork/Fork/Spawner

@onready var lift: Lift = $Lift

var enemyInstance: PackedScene = preload("res://assets/enemy_hierarchic/inherited/tank/TankEnemy.tscn")	

func _ready() -> void:
	# spawnEnemy()
	rotateLift()
	lift.parentFork = self
	pass
	
func rotateLift() -> void:
	var liftRotation: float
	var rand = randi_range(0,2)
	if rand == 1:
		liftRotation = 0.0
	elif  rand == 2:
		liftRotation = 90.0
	else:
		liftRotation = 180.0
	lift.rotation_degrees.y = liftRotation
	
func spawnEnemy() -> void:
	var enemy: TankEnemy = enemyInstance.instantiate()
	enemy.global_position = spawner.global_position
	enemy.scale.x = enemy.scale.x/5
	enemy.scale.y = enemy.scale.y/5
	enemy.scale.z = enemy.scale.z/5
	# enemy.rotation_degrees = PlayerAccessInstance.player.rotation_degrees
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
