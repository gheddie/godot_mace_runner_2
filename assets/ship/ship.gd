class_name Ship
extends RigidBody3D

const MAX_SPEED: float = 0.5
const ROTATION_DIFF = 0.05
const STRAFE_FACTOR = 1.5
const CAMERA_SWING_FACTOR = 5.0
const MAX_CAMERA_SWING_DEGREES = 20.0
const CAMERA_SWINGBACK_FACTOR = 250.0
const MAX_ASCENT = 1000.0
const THRUST_UP_FORCE = 25.0
const CAMERA_ZOOM_MULTIPLICATOR = 0.001
const CAMERA_MAX_ZOOM_FACTOR = 10

var speed := 1.0
var body_rotation: float
var mouse_motion := Vector2.ZERO

var moveForward: bool = false
var moveBackward: bool = false

var turnRight: bool = false
var turnLeft: bool = false

var swingLeft: bool = false
var swingRight: bool = false

var boostUp: bool = false

@onready var weapon1: Weapon = $WeaponHolder/Weapon1
@onready var weapon2: Weapon = $WeaponHolder/Weapon2
@onready var castLeft: RayCast3D = $RayCastLeft
@onready var castRight: RayCast3D = $RayCastRight
@onready var weaponHolder: Node3D = $WeaponHolder

@onready var boostFwRight: VfxBoost = $Thrusters/BoostFwRight
@onready var boostFwLeft: VfxBoost = $Thrusters/BoostFwLeft
@onready var boostBwRight: VfxBoost = $Thrusters/BoostBwRight
@onready var boostBwLeft: VfxBoost = $Thrusters/BoostBwLeft

@onready var boostRight: VfxBoost = $Thrusters/BoostRight
@onready var boostLeft: VfxBoost = $Thrusters/BoostLeft
@onready var boostRightSwing: VfxBoost = $Thrusters/BoostRightSwing
@onready var boostLeftSwing: VfxBoost = $Thrusters/BoostLeftSwing

@onready var boostUwFront: VfxBoost = $Thrusters/BoostUwFront
@onready var boostUwLeft: VfxBoost = $Thrusters/BoostUwLeft
@onready var boostUwRight: VfxBoost = $Thrusters/BoostUwRight

@onready var zoomLabel: Label = $GridContainer/ZoomLabel

@onready var cameraForwardRaycast: RayCast3D = $WeaponHolder/ForwardRayCast

@onready var defaultCenterContainer: CenterContainer = $CenterContainerDefault
@onready var zoomedCenterContainer: CenterContainer = $CenterContainerZoom

@onready var shipCamera: Camera3D = $WeaponHolder/Camera3D

var zoomFactor: int = 0

var zoomedCameraPos: Vector3

func _ready() -> void:
	gravity_scale = 1.5		
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _process(_delta: float) -> void:
	fireBoosters()
	updateZoomLabel()
	zoomCamera()
	
func zoomCamera() -> void:
	zoomedCameraPos = calculateZoomedCamPosition(Input.is_action_pressed("look_around"))
	# var origCamPos: Vector3 = shipCamera.global_position
	if Input.is_action_pressed("look_around"):
		# print(str(cameraForwardRaycast.global_rotation), str(" --> "), str(zoomFactor))
		zoomedCenterContainer.visible = true
		defaultCenterContainer.visible = false
		var direction = cameraForwardRaycast.target_position.normalized()
		var global_dir = cameraForwardRaycast.global_transform.basis * direction
		var alteredCamPos: Vector3 = global_dir * zoomFactor * CAMERA_ZOOM_MULTIPLICATOR
		# print(alteredCamPos)
		# shipCamera.global_position = origCamPos + alteredCamPos
	else:
		zoomedCenterContainer.visible = false
		defaultCenterContainer.visible = true
		# shipCamera.global_position = origCamPos
		
func calculateZoomedCamPosition(cameraZoomed: bool) -> Vector3:
	if !cameraZoomed:
		return shipCamera.global_position
	else:
		var direction = cameraForwardRaycast.target_position.normalized()
		var global_dir = cameraForwardRaycast.global_transform.basis * direction
		var alteredPos: Vector3 = global_dir * zoomFactor * CAMERA_ZOOM_MULTIPLICATOR
		return shipCamera.global_position + alteredPos
	
func updateZoomLabel() -> void:
	zoomLabel.text = str(str("ZOOM -> "), str(zoomFactor))
	
func fireBoosters() -> void:
	
	boostFwRight.visible = moveForward
	boostFwLeft.visible = moveForward
	
	boostBwRight.visible = moveBackward
	boostBwLeft.visible = moveBackward
	
	boostRight.visible = turnLeft
	boostLeft.visible = turnRight
	
	boostRightSwing.visible = swingLeft
	boostLeftSwing.visible = swingRight
	
	boostUwFront.visible = boostUp
	boostUwLeft.visible = boostUp
	boostUwRight.visible = boostUp
		
func _physics_process(_delta: float) -> void:
	
	handle_rotation(mouse_motion)
	handleLookAround(mouse_motion, _delta)
	
	var velocity := Vector3.ZERO	
	
	if Input.is_action_pressed('move_forward'):
		velocity.x -= clamp(speed, 0.0, MAX_SPEED)
		moveForward = true
	else:
		moveForward = false
		
	if Input.is_action_pressed('move_backward'):
		velocity.x += clamp(speed, 0.0, MAX_SPEED)
		moveBackward = true
	else:
		moveBackward = false
		
	if Input.is_action_pressed('turn_right'):
		velocity.z -= clamp(speed, 0.0, MAX_SPEED) * STRAFE_FACTOR
		turnRight = true
	else:
		turnRight = false
		
	if Input.is_action_pressed('turn_left'):
		velocity.z += clamp(speed, 0.0, MAX_SPEED) * STRAFE_FACTOR
		turnLeft = true
	else:
		turnLeft = false
		
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
			apply_force(Vector3(0,THRUST_UP_FORCE,0),Vector3(0,0,0))
			boostUp = true
		else:
			boostUp = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			mouse_motion = -event.relative * 0.001		
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	handleTargetZoom(event)
	
func handleTargetZoom(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			# print("wheel up")
			if zoomFactor < CAMERA_MAX_ZOOM_FACTOR:
				zoomFactor += 1
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			# print("wheel down")
			if (zoomFactor > 0):
				zoomFactor -= 1

func handle_rotation(motion: Vector2) -> void:
	if !Input.is_action_pressed("look_around"):
		body_rotation += motion.x
		# print(str("motion.x --> "), str(motion.x))
		if motion.x== 0.0:
			swingLeft = false
			swingRight = false
		else:
			if motion.x > 0.0:
				swingLeft = true
			else:
				swingRight = true

func handleLookAround(motion: Vector2, _delta: float) -> void:
	if Input.is_action_pressed("look_around"):	
		swingLeft = false
		swingRight = false
		var absX = abs(weaponHolder.rotation_degrees.x)
		# print(str("absX -> ", absX))
		var absY = abs(weaponHolder.rotation_degrees.y)
		if weaponHolder.rotation_degrees.x >= -MAX_CAMERA_SWING_DEGREES and weaponHolder.rotation_degrees.x <= MAX_CAMERA_SWING_DEGREES:
			weaponHolder.rotation_degrees.x -= mouse_motion.y * _delta * 1000.0 * CAMERA_SWING_FACTOR			
			# print(str("weaponHolder.rotation_degrees.x -> ", weaponHolder.rotation_degrees.x))
		else:
			if weaponHolder.rotation_degrees.x >= 0.0:
				weaponHolder.rotation_degrees.x = MAX_CAMERA_SWING_DEGREES
			else:
				weaponHolder.rotation_degrees.x = -MAX_CAMERA_SWING_DEGREES
		weaponHolder.rotation_degrees.y += mouse_motion.x * _delta * 1000.0 * CAMERA_SWING_FACTOR
	else:
		# swing weapon holder (camera rotation) back to ZERO
		swingBackCamera(_delta)
		zoomFactor = 0
		
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

func isLookingAround() -> bool:
	if Input.is_action_pressed("look_around"):
		return true
	else:
		return false
