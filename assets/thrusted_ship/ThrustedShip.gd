class_name ThrustedShip
extends RigidBody3D

const MAX_ASCENT = 1000.0

var mouse_motion := Vector2.ZERO

const THRUST_UP_FORCE = 25.0
const STRAFE_FACTOR = 1.5
const MAX_SPEED: float = 0.5

var speed := 1.0

var body_rotation: float

func _process(_delta: float) -> void:
	# handle_rotation(mouse_motion)
	# handleLookAround(mouse_motion, _delta)
	var velocity := Vector3.ZERO	
	if Input.is_action_pressed('move_forward'):
		velocity.x -= clamp(speed, 0.0, MAX_SPEED)
	if Input.is_action_pressed('move_backward'):
		velocity.x += clamp(speed, 0.0, MAX_SPEED)
	if Input.is_action_pressed('turn_right'):
		velocity.z -= clamp(speed, 0.0, MAX_SPEED) * STRAFE_FACTOR
	if Input.is_action_pressed('turn_left'):
		velocity.z += clamp(speed, 0.0, MAX_SPEED) * STRAFE_FACTOR
	rotation.y = body_rotation		
	apply_impulse(velocity.rotated(Vector3.UP, rotation.y), Vector3.ZERO)	
	thrust_upwards()		
	if Input.is_action_pressed("shoot"):
		shoot()		
	# reset mouse motion
	mouse_motion = Vector2.ZERO
	
func thrust_upwards() -> void:	
	if global_position.y <= MAX_ASCENT:
		if Input.is_action_pressed("thrust_upwards"):
			apply_force(Vector3(0,THRUST_UP_FORCE,0),Vector3(0,0,0))

func shoot() -> void:
	pass
