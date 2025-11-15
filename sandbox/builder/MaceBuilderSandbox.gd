extends Node3D

@onready var addTrailButton: Button = $Buttons/AddTrail
@onready var addForkButton: Button = $Buttons/AddFork

func _ready() -> void:
	addTrailButton.pressed.connect(addTrail)
	addForkButton.pressed.connect(addFork)

func addTrail() -> void:
	var element = MaceElementFactoryInstance.buildTrailElement()
	add_child(element)
	element.acceptPosition(MaceObjectManagerInstance.registerMaceElement(element))
	
func addFork() -> void:
	var element = MaceElementFactoryInstance.buildForkElement()
	add_child(element)
	element.acceptPosition(MaceObjectManagerInstance.registerMaceElement(element))
