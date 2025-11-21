class_name TankEnemy

extends AbstractEnemy

const SPEED = 2.0
const JUMP_VELOCITY = 4.5

@onready var playerAxis1 : AnimationPlayer = $Axis/Axis1/enemy_mech_axis/AnimationPlayer
@onready var playerAxis2 : AnimationPlayer = $Axis/Axis2/enemy_mech_axis/AnimationPlayer
@onready var playerAxis3 : AnimationPlayer = $Axis/Axis3/enemy_mech_axis/AnimationPlayer
@onready var playerAxis4 : AnimationPlayer = $Axis/Axis4/enemy_mech_axis/AnimationPlayer
@onready var playerAxis5 : AnimationPlayer = $Axis/Axis5/enemy_mech_axis/AnimationPlayer

var provoked := false
var aggro_range := 12.0

@export var attack_range : float = 2.5

@export var max_hitpoints : int = 100

var hitpoints: int = max_hitpoints:
	set(value):
		hitpoints = value
		if hitpoints <= 0:
			queue_free()
		provoked = true

func _ready() -> void:	
	"""
	player = get_tree().get_first_node_in_group("player")
	"""
	playerAxis1.play("RollAction")
	playerAxis2.play("RollAction")
	playerAxis3.play("RollAction")
	playerAxis4.play("RollAction")
	playerAxis5.play("RollAction")
	
func _process(delta: float) -> void:
	"""
	if provoked:
		navigation_agent.target_position = player.global_position
		"""		
	watchAnimations()
	
func watchAnimations() -> void:
	if !playerAxis1.is_playing():
		playerAxis1.play("RollAction")
	if !playerAxis2.is_playing():
		playerAxis2.play("RollAction")
	if !playerAxis3.is_playing():
		playerAxis3.play("RollAction")
	if !playerAxis4.is_playing():
		playerAxis4.play("RollAction")
	if !playerAxis5.is_playing():
		playerAxis5.play("RollAction")
	pass

func _physics_process(delta: float) -> void:
	
	# TODO hier muss die Position des Schiffs hin...
	var next_position: Vector3 = PlayerAccessInstance.player.global_position
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	var direction = global_position.direction_to(next_position)
	
	"""
	var distance = global_position.distance_to(player.global_position)
	if distance <= aggro_range:
		provoked = true
		"""
		
	"""
	if provoked:
		if distance <= attack_range:
			animation_player.play("attack")
			"""
		
	if direction:
		look_at_target(direction)
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	move_and_slide()

func look_at_target(direction: Vector3) -> void:
	var adjusted_direction = direction
	# do not look up or down
	adjusted_direction.y = 0
	look_at(global_position + adjusted_direction, Vector3.UP, true)

func attack() -> void:	
	"""
	log.print_message("enemy attack!!!")	
	player.hitpoints -= 10
	"""
	pass


func onBodyEntered(body: Node3D) -> void:
	if body is Bullet:
		body.onEnemyHit()
		applyWeaponHit()

func die() -> void:
	queue_free()
