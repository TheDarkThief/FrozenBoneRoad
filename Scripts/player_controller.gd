extends CharacterBody3D
@onready var camera_3d: Camera3D = $Camera3D
const MAX_TILT = PI/2 -0.01
const ACCELERATION = 50
const MAX_SPEED = 3.5
const FRICTION = 30

var mouse_sensi = 0.01

var isInControl = true

var move_dir = Vector3(0,0,0)

func setControl(isControl:bool) -> void:
	isInControl = isControl

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if not isInControl:
		move_dir = Vector3(0,0,0)
		return
	
	if event is InputEventMouseMotion:
		rotation.y -= (event.relative.x * mouse_sensi)
		camera_3d.rotation.x -= (event.relative.y * mouse_sensi)
		camera_3d.rotation.x = clamp(camera_3d.rotation.x, -MAX_TILT, MAX_TILT)
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	move_dir = Vector3(input_dir.x, 0, input_dir.y)
	move_dir = move_dir.rotated(Vector3(0,1,0), rotation.y)
	

func _physics_process(delta: float) -> void:
	if velocity.length() < MAX_SPEED:
		velocity = velocity + move_dir * ACCELERATION * delta
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	else:
		velocity.y = 0
		# Apply friction
		var friction_force = velocity.normalized() * FRICTION * delta
		friction_force.x = \
			friction_force.x if abs(friction_force.x) < abs(velocity.x) else velocity.x
		friction_force.z = \
			friction_force.z if abs(friction_force.z) < abs(velocity.z) else velocity.z
		velocity -= friction_force
	self.move_and_slide()
