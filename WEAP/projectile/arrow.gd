extends Node3D
var projectilePart:RigidBody3D
func _ready():
	projectilePart = $"." as RigidBody3D
	#projectilePart.apply_force()
	projectilePart.apply_force(basis*Vector3.FORWARD)
