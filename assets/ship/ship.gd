class_name Ship

extends RigidBody3D

@export var speed := 1.0

var body_rotation: float

const MAX_SPEED: float = 1.0

const ROTATION_DIFF = 0.05

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
	apply_torque(velocity.rotated(Vector3.UP, rotation.x))
