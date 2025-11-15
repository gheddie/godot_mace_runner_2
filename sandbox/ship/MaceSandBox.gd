extends Node3D

@onready var addTrailButton: Button = $Buttons/AddTrail
@onready var addForkButton: Button = $Buttons/AddFork
@onready var switchCameraButton: Button = $Buttons/SwitchCamera
@onready var removeObjectsButton: Button = $Buttons/RemoveObjects

var maceElements: Dictionary[int, BaseMaceElement]

func _ready() -> void:
	addTrailButton.pressed.connect(addTrail)
	addForkButton.pressed.connect(addFork)
	switchCameraButton.pressed.connect(switchCamera)
	removeObjectsButton.pressed.connect(removeObjects)

func removeObjects() -> void:
	print(str("removing ", str(maceElements.size()), " objects..."))
	for maceElement: BaseMaceElement in maceElements.values():
		print(str("removing ", str(maceElement), " object..."))
		maceElement.removeFromScene()
		maceElement.debugExpansion()

func addTrail() -> void:
	print("add trail...")
	var trail: BaseMaceElement = MaceElementFactoryInstance.buildTrailElement()
	add_child(trail)
	maceElements[trail.get_instance_id()] = trail
	
func addFork() -> void:
	print("add fork...")
	var fork: BaseMaceElement = MaceElementFactoryInstance.buildForkElement()
	add_child(fork)
	maceElements[fork.get_instance_id()] = fork
	
func switchCamera() -> void:
	print("switch camera...")
