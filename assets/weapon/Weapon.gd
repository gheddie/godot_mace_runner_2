class_name Weapon

extends StaticBody3D

@onready var trigger: MeshInstance3D = $weapon/Cylinder_001/Trigger

var bullet: PackedScene = preload("res://assets/bullet/Bullet.tscn")	

var bulletInstance: Bullet

@onready var weaponAnim: AnimationPlayer = $weapon/AnimationPlayer

@onready var shootingRaycast: RayCast3D = $ShootingRaycast

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func shoot() -> void:
	if !weaponAnim.is_playing():
		weaponAnim.play("ShootAction")
		bulletInstance = bullet.instantiate()
		bulletInstance.position = trigger.global_position
		bulletInstance.transform.basis = trigger.global_transform.basis
		get_tree().get_current_scene().add_child(bulletInstance)	
