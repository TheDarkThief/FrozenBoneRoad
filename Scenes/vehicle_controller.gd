extends CharacterBody3D

@onready var front_cast: RayCast3D = $FrontCast
@onready var left_wheel_cast: RayCast3D = $LeftWheelCast
@onready var right_wheel_cast: RayCast3D = $RightWheelCast

@onready var vehicle_model: Node3D = $TheVehicle

@onready var front_ray_pos: CSGSphere3D = $FrontRayPos
@onready var calculated_pos_viz: CSGSphere3D = $CalculatedPosViz

var isPlayerControlling := false

func _physics_process(_delta: float) -> void:
	
	front_ray_pos.position = front_cast.get_collision_point() - position
	
	var left_vec = left_wheel_cast.get_collision_point() - front_cast.get_collision_point()
	var right_vec = right_wheel_cast.get_collision_point() - front_cast.get_collision_point()
	
	var midpoint_pos = front_cast.get_collision_point() + left_wheel_cast.get_collision_point() + right_wheel_cast.get_collision_point()
	midpoint_pos = midpoint_pos * 0.333333333333
	midpoint_pos = to_local(midpoint_pos)
	
	calculated_pos_viz.position = midpoint_pos
	
	var up_vector = left_vec.cross(right_vec).normalized()
	var point_dir = up_vector.cross(transform.basis.x.normalized()).normalized()
	
	vehicle_model.position = Vector3(0,0,0)
	vehicle_model.transform = vehicle_model.transform.looking_at(point_dir, up_vector, false)
	vehicle_model.position = midpoint_pos
	
	
