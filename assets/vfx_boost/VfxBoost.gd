class_name VfxBoost
extends Node3D

func _physics_process(delta: float) -> void:
	$boost_light["light_energy"] = scale.x * 0.3	
