class_name Ship

extends RigidBody3D

@export var speed := 1.0

var body_rotation: float

const MAX_SPEED: float = 0.5

const ROTATION_DIFF = 0.05

const STRAFE_FACTOR = 1.5

const MAX_ASCENT = 2.5

var mouse_motion := Vector2.ZERO

@onready var weapon1: Weapon = $Weapon1
@onready var weapon2: Weapon = $Weapon2

@onready var castLeft: RayCast3D = $RayCastLeft
@onready var castRight: RayCast3D = $RayCastRight

func _ready() -> void:
	gravity_scale = 1.5		
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _physics_process(_delta: float) -> void:
	
	handle_rotation()
	
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

func shoot() -> void:	
	weapon1.shoot()
	weapon2.shoot()
	
func thrust_upwards() -> void:	
	if global_position.y <= MAX_ASCENT:
		if Input.is_action_pressed("thrust_upwards"):
			apply_force(Vector3(0,100.0,0),Vector3(0,0,0))

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			mouse_motion = -event.relative * 0.001		
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func handle_rotation() -> void:
	body_rotation += mouse_motion.x
	mouse_motion = Vector2.ZERO
