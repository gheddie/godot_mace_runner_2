extends Node3D

var ship: Ship

var shipInstance: PackedScene = preload("res://assets/ship/Ship.tscn")	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	var shipInstance: Ship = shipInstance.instantiate()
	ship = shipInstance
	get_tree().get_current_scene().add_child(ship)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
