class_name TheVehicle
extends VehicleBody3D

@export var MAX_RPM: int = 100
@export var MAX_TORQUE: float = 1500.0
@export var BRAKE:float = 100
@export var MAX_STEER = PI/3.0

@onready var front_wheel: VehicleWheel3D = $FrontWheel
@onready var left_back_wheel: VehicleWheel3D = $LeftBackWheel



var isBeingControlled = false

func setControl(control):
	isBeingControlled = control

func _physics_process(delta: float) -> void:
	if not isBeingControlled:
		brake = BRAKE
		return
	else:
		brake = 0
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var cur_RPM = front_wheel.get_rpm() + left_back_wheel.get_rpm()
	cur_RPM *= 0.5
	
	engine_force = -MAX_TORQUE * input_dir.y * (1 - cur_RPM / MAX_RPM)
	steering = -MAX_STEER * input_dir.x
	
		
