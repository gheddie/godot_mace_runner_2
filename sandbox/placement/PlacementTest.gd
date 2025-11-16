extends Node3D

@onready var camera: Camera3D = $Camera3D

@onready var switchToShipButton: Button = $GridContainer/SwitchToShip

var shipInstance: PackedScene = preload("res://assets/ship/Ship.tscn")	

var shipPosition: Vector3

func _ready() -> void:
	
	switchToShipButton.pressed.connect(switchToShip)
	
	var fork1: ForkMaceElement = MaceElementFactoryInstance.buildForkElement()
	add_child(fork1)
	
	var trailLeft: TrailMaceElement = MaceElementFactoryInstance.buildTrailElement()
	trailLeft.acceptPosition(fork1.getDockPositionLeft())
	trailLeft.rotateY(30)
	add_child(trailLeft)
	
	var trailRight: TrailMaceElement = MaceElementFactoryInstance.buildTrailElement()
	trailRight.acceptPosition(fork1.getDockPositionRight())
	trailRight.rotateY(-30)
	add_child(trailRight)
	
	# links mit Fork weiter...
	var fork2: ForkMaceElement = MaceElementFactoryInstance.buildForkElement()
	fork2.acceptPosition(trailLeft.getDockPosition())
	fork2.rotateY(30)
	add_child(fork2)
	
	# rechter Ausgang mit 2 Trails weiter...
	var trailAfterFork1: TrailMaceElement = MaceElementFactoryInstance.buildTrailElement()
	trailAfterFork1.acceptPosition(fork2.getDockPositionRight())
	add_child(trailAfterFork1)
	
	var trailAfterFork2: TrailMaceElement = MaceElementFactoryInstance.buildTrailElement()
	trailAfterFork2.acceptPosition(trailAfterFork1.getDockPosition())
	add_child(trailAfterFork2)
	
	# nochmal nach links nach Fork 2
	var trailFinal: TrailMaceElement = MaceElementFactoryInstance.buildTrailElement()
	trailFinal.acceptPosition(fork2.getDockPositionLeft())
	trailFinal.rotateY(60)
	add_child(trailFinal)

func switchToShip() -> void:
	camera.queue_free()
	var ship = shipInstance.instantiate()
	ship.global_position = shipPosition
	ship.rotation_degrees.y += 180
	add_child(ship)
