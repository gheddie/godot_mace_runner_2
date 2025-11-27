class_name Drone

extends CharacterBody3D

const SPEED = 50.0
const JUMP_VELOCITY = 4.5

var KEEP_DISTANCE := 25.0

var ship: Ship

func _physics_process(delta: float) -> void:
	var next_position: Vector3 = PlayerAccessInstance.player.global_position
	var direction = global_position.direction_to(next_position)
	var distance = global_position.distance_to(PlayerAccessInstance.player.global_position)
	print(distance)
	if direction:
		look_at_target(direction)
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
		velocity.z = direction.z * SPEED
	else:
		if distance >= KEEP_DISTANCE:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.y = move_toward(velocity.y, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
		
	if distance >= KEEP_DISTANCE:
		move_and_slide()
	

func look_at_target(direction: Vector3) -> void:
	var adjusted_direction = direction
	look_at(global_position + adjusted_direction, Vector3.UP, true)

"""
func draw_line_3d(start_point: Vector3, end_point: Vector3, color: Color, width: float = 1.0):
	# This is a simplified example. Thick lines are complex.
	# For actual thickness, you need to generate triangles (a mesh).
	# A simple ImmediateMesh with PRIMITIVE_LINES will render as a 1px line (driver-specific behavior).

	clear_surfaces()
	surface_begin(Mesh.PRIMITIVE_LINES)
	surface_set_color(color)
	surface_add_vertex(start_point)
	surface_add_vertex(end_point)
	surface_end()
	
func _draw():
	var color = Color(0, 1, 0)
	var start = camera.unproject_position(player.global_transform.origin)
	var end = camera.unproject_position(player.global_transform.origin + player.velocity)
	node.draw_line(start, end, color, width)
	node.draw_triangle(end, start.direction_to(end), width*2, color)

func draw_triangle(pos, dir, size, color):
	var a = pos + dir * size
	var b = pos + dir.rotated(2*PI/3) * size
	var c = pos + dir.rotated(4*PI/3) * size
	var points = PoolVector2Array([a, b, c])
	draw_polygon(points, PoolColorArray([color]))
	"""	
