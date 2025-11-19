class_name Enemy

extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var animation_player : AnimationPlayer = $AnimationPlayer

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
	pass
	
func _process(delta: float) -> void:
	"""
	if provoked:
		navigation_agent.target_position = player.global_position
		"""
	pass		

func _physics_process(delta: float) -> void:
	
	var next_position: Vector3 = Vector3.ZERO
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
