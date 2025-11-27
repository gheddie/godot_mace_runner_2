class_name MineralRessourceAsset

extends AbstractRessourceAsset

@onready var mineral: Node3D = $mineral

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func getPresentationNode() -> Node3D:
	return mineral
