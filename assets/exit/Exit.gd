extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func onBodyEntered(body: Node3D) -> void:
	if body is Ship:
		get_tree().change_scene_to_file("res://assets/ressources/RessourcesRoom.tscn")
