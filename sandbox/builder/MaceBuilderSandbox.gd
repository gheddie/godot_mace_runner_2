extends Node3D

@onready var addTrailButton: Button = $Buttons/AddTrail
@onready var addForkButton: Button = $Buttons/AddFork

@onready var camera: Camera3D = $Camera3D

func _ready() -> void:
	addTrailButton.pressed.connect(addTrail)
	addForkButton.pressed.connect(addFork)

func addTrail() -> void:
	var element = MaceElementFactoryInstance.buildTrailElement()
	add_child(element)
	var position = MaceObjectManagerInstance.registerMaceElement(element)
	element.acceptPosition(position)
	updateCameraPosition(position.x)
	
func addFork() -> void:
	var element = MaceElementFactoryInstance.buildForkElement()
	add_child(element)
	var position = MaceObjectManagerInstance.registerMaceElement(element)
	element.acceptPosition(position)
	updateCameraPosition(position.x)
	
func updateCameraPosition(xPosition: float) -> void:
	camera.global_position.x = xPosition
	print(str("updating camera position to --> ", str(camera.global_position)))
