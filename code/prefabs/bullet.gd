extends Node3D
class_name Bullet
@export var damage = 5
@export var collisionShape:CollisionShape3D
func _on_rigid_body_3d_body_entered(body):
	if body.has_method("hit"):
		body.hit(damage)
	queue_free()
	pass # Replace with function body.
