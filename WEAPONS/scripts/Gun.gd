extends Weapon
class_name Gun
# Called when the node enters the scene tree for the first time.
@export var ammo = 40
@export var maxammo = 40
@export var bullet:PackedScene
@export var clipsize = 7
@export var firesound : AudioStreamWAV
@export var reloadDelay=1
var reloadTimeRemaining =0
@export var firingDelay = 0.5
var firingTimeRemaining =0
@export var aimdownDelay = 0.2
var aimdownTimeRemaining =0
func _process(delta):
	if reloadTimeRemaining > 0:
		#print(cooldown)
		reloadTimeRemaining -= delta
	if firingTimeRemaining > 0:
		firingTimeRemaining -= delta

func reload():
	if ammo != maxammo:
		reloadTimeRemaining = reloadDelay
func _ready():
	pass
func aimDown():
	pass
func stopAimDown():
	pass
func attack():

	if (reloadTimeRemaining <= 0 && firingTimeRemaining <= 0):
		print("shooting")
		return shoot()

func shoot():
	firingTimeRemaining = firingDelay
	var newbullet = bullet.instantiate() as RigidBody3D
	newbullet.linear_velocity+=Vector3.FORWARD*10
	get_tree().root.get_child(0).add_child(newbullet)
	return newbullet as RigidBody3D
