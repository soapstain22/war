extends Weapon
class_name Bow
var pull = 0
var pulling = false
@export var arrow:PackedScene
func _process(delta):
	if pulling:
		pull=clampf(pull+delta,0,2)
		
func attack():
	pulling=true
	pass
func attack_release():
	pulling=false
	var a:RigidBody3D = arrow.instantiate() as RigidBody3D
	get_tree().root.get_child(0).add_child(a)
	a.apply_force(Vector3.FORWARD*pull)
	return a;
