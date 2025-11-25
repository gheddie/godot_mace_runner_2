class_name Ship

extends RigidBody3D

@export var speed := 1.0

var body_rotation: float

const MAX_SPEED: float = 0.5

const ROTATION_DIFF = 0.05

const STRAFE_FACTOR = 1.5

const CAMERA_SWING_FACTOR = 5.0
const MAX_CAMERA_SWING_DEGREES = 20.0
const CAMERA_SWINGBACK_FACTOR = 250.0

const MAX_ASCENT = 2.5

var mouse_motion := Vector2.ZERO

@onready var weapon1: Weapon = $WeaponHolder/Weapon1
@onready var weapon2: Weapon = $WeaponHolder/Weapon2

@onready var castLeft: RayCast3D = $RayCastLeft
@onready var castRight: RayCast3D = $RayCastRight

@onready var weaponHolder: Node3D = $WeaponHolder

func _ready() -> void:
	gravity_scale = 1.5		
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _physics_process(_delta: float) -> void:
	
	handle_rotation(mouse_motion)
	handleLookAround(mouse_motion, _delta)
	
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

func handle_rotation(motion: Vector2) -> void:
	if !Input.is_action_pressed("look_around"):
		body_rotation += motion.x	

func handleLookAround(motion: Vector2, _delta: float) -> void:
	if Input.is_action_pressed("look_around"):				
		
		var absX = abs(weaponHolder.rotation_degrees.x)
		print(str("absX -> ", absX))
		var absY = abs(weaponHolder.rotation_degrees.y)
		# print(absY)
		
		# x
		if weaponHolder.rotation_degrees.x >= -MAX_CAMERA_SWING_DEGREES and weaponHolder.rotation_degrees.x <= MAX_CAMERA_SWING_DEGREES:
			weaponHolder.rotation_degrees.x -= mouse_motion.y * _delta * 1000.0 * CAMERA_SWING_FACTOR			
			print(str("weaponHolder.rotation_degrees.x -> ", weaponHolder.rotation_degrees.x))
		else:
			if weaponHolder.rotation_degrees.x >= 0.0:
				weaponHolder.rotation_degrees.x = MAX_CAMERA_SWING_DEGREES
			else:
				weaponHolder.rotation_degrees.x = -MAX_CAMERA_SWING_DEGREES
			
		# y				
		weaponHolder.rotation_degrees.y += mouse_motion.x * _delta * 1000.0 * CAMERA_SWING_FACTOR
		
	else:
		# swing weapon holder (camera rotation) back to ZERO
		swingBackCamera(_delta)
		
func swingBackCamera(_delta: float) -> void:
	
	# TODO -> somehting like lerp(...)?
	
	if weaponHolder.rotation_degrees.x > 0:
		weaponHolder.rotation_degrees.x -= 1.0 * CAMERA_SWINGBACK_FACTOR * _delta
	if weaponHolder.rotation_degrees.x < 0:
		weaponHolder.rotation_degrees.x += 1.0 * CAMERA_SWINGBACK_FACTOR * _delta
		
	if weaponHolder.rotation_degrees.y > 270:
		weaponHolder.rotation_degrees.y -= 1.0 * CAMERA_SWINGBACK_FACTOR * _delta
	if weaponHolder.rotation_degrees.y < 270:
		weaponHolder.rotation_degrees.y += 1.0 * CAMERA_SWINGBACK_FACTOR * _delta
		
	if weaponHolder.rotation_degrees.z > 0:
		weaponHolder.rotation_degrees.z -= 1.0 * CAMERA_SWINGBACK_FACTOR * _delta
	if weaponHolder.rotation_degrees.z < 0:
		weaponHolder.rotation_degrees.z += 1.0 * CAMERA_SWINGBACK_FACTOR * _delta
