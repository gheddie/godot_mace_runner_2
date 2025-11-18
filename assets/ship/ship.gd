class_name Ship

extends RigidBody3D

@export var speed := 1.0

var body_rotation: float

const MAX_SPEED: float = 0.5

const ROTATION_DIFF = 0.05

@onready var weapon1: Weapon = $Weapon1
@onready var weapon2: Weapon = $Weapon2

func _ready() -> void:
	gravity_scale = 2.0		
	
func _physics_process(delta: float) -> void:
	var velocity := Vector3.ZERO	
	var direction := Input.get_vector("turn_left", "turn_right", "", "")
	if Input.is_action_pressed('move_forward'):
		velocity.x -= clamp(speed, 0.0, MAX_SPEED)
	if Input.is_action_pressed('move_backward'):
		velocity.x += clamp(speed, 0.0, MAX_SPEED)
	if Input.is_action_pressed('turn_right'):
		body_rotation -= ROTATION_DIFF
	if Input.is_action_pressed('turn_left'):
		body_rotation += ROTATION_DIFF
		
	rotation.y = body_rotation
		
	apply_impulse(velocity.rotated(Vector3.UP, rotation.y), Vector3.ZERO)
	
	if Input.is_action_pressed("thrust_upwards"):
		apply_force(Vector3(0,25.0,0),Vector3(0,0,0))
		
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot() -> void:	
	print("shooting...")
	weapon1.shoot()
	weapon2.shoot()
