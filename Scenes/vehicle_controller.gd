extends VehicleBody3D

@export var MAX_RPM: int = 100
@export var MAX_TORQUE: float = 500.0

@onready var front_wheel: VehicleWheel3D = $FrontWheel
@onready var left_back_wheel: VehicleWheel3D = $LeftBackWheel


var isBeingControlled = false

func _physics_process(delta: float) -> void:
	if not isBeingControlled:
		
		return
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var cur_RPM = front_wheel.get_rpm() + left_back_wheel.get_rpm()
	cur_RPM *= 0.5
		
