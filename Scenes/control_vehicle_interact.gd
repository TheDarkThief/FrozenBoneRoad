extends Area3D

var isVehicleControlled = false
@onready var root: TheVehicle = $".."
@onready var plr_binder: Generic6DOFJoint3D = $"../PlrBinder"

	

func interactWith(plr: Plr) -> void:
	print("Player interacted with the vehicle")
	isVehicleControlled = not isVehicleControlled
	plr.setControl(not isVehicleControlled)
	root.setControl(isVehicleControlled)
	
	#if isVehicleControlled:
		#plr_binder.node_b = plr.get_path()
	#else:
		#plr_binder.node_b = ""
	#
