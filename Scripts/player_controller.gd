extends CharacterBody3D

const speed = 0.1
const mouse_sensi = 0.01

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		rotation.y -= (event.relative.x * mouse_sensi)
		rotation.x -= (event.relative.y * mouse_sensi)
		rotation.x = clamp(rotation.x, -90, 90)
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var move_dir = Vector3(input_dir.x, 0, input_dir.y)
	move_dir = move_dir.rotated(Vector3(0,1,0), rotation.y)
	velocity = move_dir.normalized() * speed
	

func _physics_process(delta: float) -> void:
	
	move_and_collide(velocity, false, 0.001, false, 1)
