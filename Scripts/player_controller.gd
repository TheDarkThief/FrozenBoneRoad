class_name Plr
extends CharacterBody3D

@export var enviroment:WorldEnvironment
@export var vehicle:TheVehicle
@export var cool_area: Node3D
@export var SEC_BEFORE_FREEZING:float = 15.0
@export var distToDefrost = 3
@export var DEFROST_SPEED = 4
var current_freezing_time = 0

@onready var death_vingette: TextureRect = $DeathVingette
@onready var camera_3d: Camera3D = $Camera3D
@onready var inter_act_ray: RayCast3D = $Camera3D/InterActRay
const MAX_TILT = PI/2 -0.01
const ACCELERATION = 50
const MAX_SPEED = 3.5
const FRICTION = 30

var mouse_sensi = 0.01

var isInControl = true
var lastInteract: CollisionObject3D = null

var move_dir = Vector3(0,0,0)

func setControl(isControl:bool) -> void:
	isInControl = isControl

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

var debounceInter = false
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Interact") && not debounceInter:
		debounceInter = true
		var possInteract = inter_act_ray.get_collider()
		if possInteract != null && possInteract.has_method("interactWith"):
			possInteract.interactWith(self)
			lastInteract = possInteract
		elif not isInControl && lastInteract != null:
			lastInteract.interactWith(self)
			lastInteract = null
	elif event.is_action_released("Interact"):
		debounceInter = false
	
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
	
	if position.distance_to(cool_area.position) < distToDefrost:
		current_freezing_time = clamp(current_freezing_time - DEFROST_SPEED * delta,\
			0, SEC_BEFORE_FREEZING)
	else:
		current_freezing_time += delta
		
	death_vingette.modulate.a = current_freezing_time / SEC_BEFORE_FREEZING
