class_name Weapon

extends StaticBody3D

@onready var trigger: MeshInstance3D = $weapon/Trigger

var granadeInstance: PackedScene = preload("res://assets/projectile/granade.tscn")	

@onready var weaponAnim: AnimationPlayer = $weapon/AnimationPlayer

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func shoot() -> void:
	weaponAnim.play("ShootAction")
	var granade: GranadeWeapon = granadeInstance.instantiate()
	granade.global_position = trigger.global_position
	get_tree().get_current_scene().add_child(granade)
