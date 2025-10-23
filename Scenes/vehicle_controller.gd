extends CharacterBody3D

@onready var front_cast: RayCast3D = $FrontCast
@onready var left_wheel_cast: RayCast3D = $LeftWheelCast
@onready var right_wheel_cast: RayCast3D = $RightWheelCast

@onready var vehicle_model: Node3D = $TheVehicle

var isPlayerControlling := false

func _physics_process(delta: float) -> void:
	
	
	var left_vec = left_wheel_cast.get_collision_point() - front_cast.get_collision_point()
	var right_vec = right_wheel_cast.get_collision_point() - front_cast.get_collision_point()
	
	var up_vector = left_vec.cross(right_vec).normalized()
	var point_dir = up_vector.cross(transform.basis.z).normalized() * -1
	
	vehicle_model.transform = vehicle_model.transform.looking_at(point_dir, Vector3(0,1,0), true)
